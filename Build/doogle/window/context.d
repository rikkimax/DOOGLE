module doogle.window.context;
import doogle.window.types;

import doogle.platform;


version(Windows) {
	public import doogle.window.context_win;
	alias Context_Win Context;
} else version(Posix) {
	public import doogle.window.context_x11;
	alias Context_X11 Context;
}


abstract shared class Context_Def {
	protected {
		GLint[4] defaultViewport;
	}

	public {
		void activate();
	
		void setVerticalSync(bool enabled);
	}
}