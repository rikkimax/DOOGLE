module doogle.platform;
public import derelict.opengl3.gl3;
import doogle.util.shaderstorage;

struct PlatformVersions {

	version(Posix) {
		pragma(lib, "dl");
		pragma(lib, "X11");
		pragma(lib, "Xrandr");
		
		public import glx = derelict.opengl3.glx;
		public import glxext = derelict.opengl3.glxext;
		public import core.sys.posix.sys.time;
	} else version(Windows) {
		pragma(lib, "gdi32");
		pragma(lib, "user32");

		public import wgl = derelict.opengl3.wgl;
		public import wglext = derelict.opengl3.wglext;
		public import windows = windows;
	}

}
__gshared PlatformVersions platform;

static this() {
	DerelictGL3.load();
	shaderStorage.init();
}