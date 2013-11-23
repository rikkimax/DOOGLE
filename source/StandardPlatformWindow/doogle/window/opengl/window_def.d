module doogle.window.opengl.window_def;
import doogle.window.window_def;
import gl3n.linalg : vec4;

abstract shared class Window_OpenGL_Def : Window_Def {
	shared(vec4) glslCoordFix = vec4(0, 0, 0, 0);
}