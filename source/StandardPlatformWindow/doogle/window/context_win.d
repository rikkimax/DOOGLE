module doogle.window.context_win;
import doogle.window.context;
import doogle.platform;

version(Windows) {
	shared class Context_Win : Context_Def {
		protected {
			platform.windows.HDC _hdc;
			platform.windows.HGLRC _context;
		}

		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, shared(platform.wgl.HDC) hdc) {
			auto pixelAttribs =
			[
				platform.wglext.WGL_DRAW_TO_WINDOW_ARB, GL_TRUE,
				platform.wglext.WGL_SUPPORT_OPENGL_ARB, GL_TRUE,
				platform.wglext.WGL_DOUBLE_BUFFER_ARB, GL_TRUE,
				platform.wglext.WGL_PIXEL_TYPE_ARB, platform.wglext.WGL_TYPE_RGBA_ARB,
				platform.wglext.WGL_COLOR_BITS_ARB, color,
				platform.wglext.WGL_DEPTH_BITS_ARB, depth,
				platform.wglext.WGL_STENCIL_BITS_ARB, stencil,
				platform.wglext.WGL_SAMPLE_BUFFERS_ARB, antialias > 1 ? GL_TRUE : GL_FALSE,
				platform.wglext.WGL_SAMPLES_ARB, antialias > 1 ? antialias : 0,
				0
			];
			platform.windows.SetPixelFormat(cast(platform.windows.HDC)hdc, platform.windows.PIXELFORMATDESCRIPTOR.sizeof, cast(platform.windows.PIXELFORMATDESCRIPTOR*)pixelAttribs.ptr);
			_context = cast(shared(platform.windows.HGLRC))platform.wgl.wglCreateContext(cast(platform.windows.HDC)hdc);
			platform.wgl.wglMakeCurrent(cast(void*)hdc, cast(void*)_context);
			_hdc = cast(shared(platform.windows.HDC))hdc;
		}

		~this() {
			platform.wgl.wglMakeCurrent(cast(void*)_hdc, null);
			platform.wgl.wglDeleteContext(cast(void*)_context);
		}

		public {
			override void activate() {
				if (platform.wgl.wglGetCurrentContext() != _context)
					platform.wgl.wglMakeCurrent(cast(void*)_hdc, cast(void*)_context);
			}
			
			override void setVerticalSync(bool enabled) {
				platform.wglext.wglSwapIntervalEXT(enabled);
			}
		}
	}
}