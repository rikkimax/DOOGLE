module doogle.controls.control_def;
import doogle.controls.control;
import doogle.window.component;
import doogle.controls.font;
public import doogle.gl.texture : Texture;

abstract shared class Control_Def : ComponentChild {
	protected {
		ComponentChildable parent_;
		Font font_;
	}

	this(shared(ComponentChildable) parent) {
		parent_ = parent;
		parent.addChild(this);
	}

	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY) {
		parent_ = parent;
		parent.addChild(this);
		relocate(suggestedX, suggestedY);
	}

	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		parent_ = parent;
		parent.addChild(this);
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