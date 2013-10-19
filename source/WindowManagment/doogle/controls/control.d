module doogle.controls.control;
import doogle.window.component;
import doogle.controls.font;
public import doogle.gl.texture : Texture;

/**
 * Loading order of different global control definitions
 * Allows for non supported implementations to be supplied
 */
static if (__traits(compiles, {import doogle.controls.control_impl;})) {
	public import doogle.controls.control_impl;
	alias Control_Impl Control;
} else static if (__traits(compiles, {import doogle.controls.control_standard;})) {
	public import doogle.controls.control_standard;
	alias Control_Standard Control;
} else {
	pragma(msg, "Control implementation is not implemented");
	static assert(0);
}

abstract shared class Control_Def : ComponentChild {
	protected {
		Component parent;
		Font font_;
	}

	this(shared(Component) parent) {
		this.parent = parent;
	}

	this(shared(Component) parent, uint suggestedX, uint suggestedY) {
		this.parent = parent;
		relocate(suggestedX, suggestedY);
	}

	this(shared(Component) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		this.parent = parent;
		relocate(suggestedX, suggestedY);
		resize(suggestedWidth, suggestedHeight);
	}

	@property void font(shared(Font) f) {
		synchronized {
			font_ = f;
		}
	}

	@property shared(Font) font() {
		synchronized {
			return font_;
		}
	}
}

shared interface ControlChildable {
	public {
		void addChild(shared(Control) child);
		void removeChild(shared(Control));
		@property shared(Control)[] childControls();
	}
}