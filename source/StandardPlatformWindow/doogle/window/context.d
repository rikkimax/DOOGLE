module doogle.window.context;
public import doogle.window.context_def;

version(Windows) {
	public import doogle.window.opengl.context_win;
	alias Context_Win Context;
} else {
	pragma(msg, "No opengl context implementation for system");
	static assert(0);
}