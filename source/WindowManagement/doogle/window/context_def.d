module doogle.window.context_def;
import doogle.window.window;

abstract shared class Context_Def {
	protected {
		int[4] defaultViewport;
	}

	public {
		void activate();
	
		void setVerticalSync(bool enabled);
	}
}