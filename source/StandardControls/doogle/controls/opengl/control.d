module doogle.controls.opengl.control;
import doogle.controls.control_def;
import doogle.window.component;
import doogle.window.window;

shared class Control_OpenGL : Control_Def {
	protected {
		bool visible_ = true;
	}

	this(shared(ComponentChildable) parent) {
		super(parent);
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY) {
		super(parent, suggestedX, suggestedY);
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
	}

	override void resize(){}
	override void relocate(){}

	@property {
		bool visible() { synchronized return visible_; }

		void visible(bool value) { synchronized visible_ = value; }
	}
}