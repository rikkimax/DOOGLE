module doogle.window.window;
public import doogle.window.window_def;

version(Windows) {
	public import doogle.window.opengl.window_win;
	alias Window_Win Window;
} else {
	pragma(msg, "No window implementation for system");
	static assert(0);
}