module doogle.controls.control;

version(Windows) {
	public import doogle.controls.control_def;
	public import doogle.controls.opengl.control;
	alias Control_OpenGL Control;
}