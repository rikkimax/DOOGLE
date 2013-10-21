module doogle.window.context;
import doogle.window.window;

static if (__traits(compiles, {import doogle.context.context_impl;})) {
	version = ContextImpl;
}
version(ContextImpl) {
	public import doogle.context.context_impl;
	alias Context_Impl Context;
} else version(Windows) {
	static if (!__traits(compiles, {import doogle.window.context_win;})) {
		pragma(msg, "Windows implementation of context not loaded");
		static assert(0);
	}
	
	public import doogle.window.context_win;
	alias Context_Win Context;
} else version(Posix) {
	static if (!__traits(compiles, {import doogle.window.context_x11;})) {
		pragma(msg, "Posix implementation of context not loaded");
		static assert(0);
	}

	public import doogle.window.context_x11;
	alias Context_X11 Context;
}


abstract shared class Context_Def {
	protected {
		int[4] defaultViewport;
	}

	public {
		void activate();
	
		void setVerticalSync(bool enabled);
	}
}