module doogle.platform;
public import derelict.opengl3.gl3;

struct PlatformVersions {

	version(Posix) {
		pragma(lib, "dl");
		pragma(lib, "X11");
		pragma(lib, "Xrandr");
		
		public import glx = derelict.opengl3.glx;
		public import glxext = derelict.opengl3.glxext;
		public import core.sys.posix.sys.time;

	} else version(Windows) {
		pragma(lib, "gdi32.lib");
		pragma(lib, "user32.lib");

		public import wgl = derelict.opengl3.wgl;
		public import wglext = derelict.opengl3.wglext;
		public import wingdi = win32.wingdi;
		public import basetsd = win32.basetsd;
		public import winuser = win32.winuser;
		public import windef = win32.windef;
		public import winnt = win32.winnt;
		public import winbase = win32.winbase;
		public import windows = win32.windows;
	}

}
__gshared PlatformVersions platform;

static this() {
	DerelictGL3.load();
}