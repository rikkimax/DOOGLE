module doogle.controls.opengl.control;
import doogle.controls.control_def;
import doogle.window.component;

shared class Control_OpenGL : Control_Def {
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
}