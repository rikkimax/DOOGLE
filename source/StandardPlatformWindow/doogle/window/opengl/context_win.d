module doogle.window.opengl.context_win;
import doogle.window.opengl.context_def;

version(Windows) {
	private struct PlatformImports {
		import windows = windows;
		public import wgl = derelict.opengl3.wgl;
		public import wglext = derelict.opengl3.wglext;
	}
	__gshared PlatformImports platform;

	shared class Context_Win : Context_OpenGL_Def {
		protected {
			platform.windows.HDC _hdc;
			platform.windows.HGLRC _context;
		}

		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, shared(platform.windows.HDC) hdc) {
			auto pixelAttribs =
			[
				platform.windows.PIXELFORMATDESCRIPTOR.sizeof,
				1,
				platform.windows.PFD_DRAW_TO_WINDOW  | platform.windows.PFD_SUPPORT_OPENGL | platform.windows.PFD_DOUBLEBUFFER,
				platform.windows.PFD_TYPE_RGBA,
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
			platform.wgl.wglMakeCurrent(cast(void*)_hdc, cast(void*)_context);

			_hdc = hdc;
			assert(_context !is null);
		}

		~this() {
			platform.wgl.wglMakeCurrent(cast(void*)_hdc, null);
			platform.wgl.wglDeleteContext(cast(void*)_context);
		}

		public {
			override void activate() {
				platform.wgl.wglMakeCurrent(cast(void*)_hdc, cast(void*)_context);
			}
			
			override void setVerticalSync(bool enabled) {
				platform.wglext.wglSwapIntervalEXT(enabled);
			}
		}
	}
}