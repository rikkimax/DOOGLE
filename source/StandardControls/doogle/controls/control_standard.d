module doogle.controls.control_standard;
import doogle.controls.control;
import doogle.window.component;

shared class Control_Standard : Control_Def {
	this(shared(Component) parent) {
		super(parent);
	}
	
	this(shared(Component) parent, uint suggestedX, uint suggestedY) {
		super(parent, suggestedX, suggestedY);
	}
	
	this(shared(Component) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
	}

	override void resize(){}
	override void relocate(){}
}