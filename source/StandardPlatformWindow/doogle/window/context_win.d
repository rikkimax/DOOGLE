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
				platform.windows.PIXELFORMATDESCRIPTOR.sizeof,
				1,
				platform.wglext.WGL_DRAW_TO_WINDOW_ARB | platform.wglext.WGL_SUPPORT_OPENGL_ARB | platform.wglext.WGL_DOUBLE_BUFFER_ARB,
				platform.wglext.WGL_TYPE_RGBA_ARB,
				color,
				0, 0, 0, 0, 0, 0,
				0,
				0,
				0,
				0, 0, 0, 0,
				depth,
				stencil,
				antialias,
				platform.windows.PFD_MAIN_PLANE,
				0,
				0, 0, 0
			];

			auto format = platform.windows.ChoosePixelFormat(cast(platform.windows.HDC)hdc, cast(platform.windows.PIXELFORMATDESCRIPTOR*)pixelAttribs.ptr);
			platform.windows.SetPixelFormat(cast(platform.windows.HDC)hdc, format, cast(platform.windows.PIXELFORMATDESCRIPTOR*)pixelAttribs.ptr);
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