module doogle.platform;

/**
 * 
 * This file is dedicated for _users_ of this library. It is meant to make it easier to handle it.
 * You are not required to use any part that you do not wish to.
 * The implementations can be swapped out very easily or only the definitions parts can be used.
 * 
 */

public import gl = derelict.opengl3.gl3;
public import glarb = derelict.opengl3.arb;
public import glwrap = doogle.overloads.wrappers;
public import glstruct = doogle.overloads.structify;

public import storage = doogle.util.storage;
import derelict.freetype.ft;

struct PlatformVersions {

	version(Posix) {
		public import glx = derelict.opengl3.glx;
		public import glxext = derelict.opengl3.glxext;
		public import core.sys.posix.sys.time;
	} else version(Windows) {
		public import wgl = derelict.opengl3.wgl;
		public import wglext = derelict.opengl3.wglext;
		public import windows = windows;
	}

}
__gshared PlatformVersions platform;

static this() {
	gl.DerelictGL3.load();

	DerelictFT.load();
	assert(FT_Init_FreeType !is null);
}