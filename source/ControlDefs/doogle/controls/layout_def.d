module doogle.controls.layout_def;
import doogle.controls.control;
import doogle.window.component;

enum Alignment {
	Top,
	Left,
	Right,
	Bottom,
	Center
}

enum VerticalAlignment {
	Top,
	Center,
	Bottom
}

enum HorizontalAlignment {
	Left,
	Center,
	Right
}

enum AlignmentType {
	Vertical,
	Horizontal
}

shared abstract class Layout_Def : Control_Def, ComponentChildable {
	protected {
		ComponentChild[] _children;
		Control[] _childControls;
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

	public {
		/**
		 * ComponentChildable
		 */
		
		void addChild(shared(ComponentChild) child) {
			synchronized _children ~= child;
		}
		
		void removeChild(shared(ComponentChild) child) {
			synchronized {
				if (_children.length == 0) return;
				size_t found;
				bool got = false;
				for(size_t i = 0; i < _children.length; i++ ) {
					if (_children[i] == child) {
						found = i;
						got = true;
						break;
					}
				}
				if (got) {
					if (found > _children.length) // middle
						_children = _children[0 .. found]  ~ _children[found .. $];
					else if (found > 0) // end
						_children = _children[0 .. found];
					else // start
						_children= _children[found .. $];
					
				}
			}
		}
		
		@property shared(Component)[] children() { synchronized return cast(shared(Component)[]) _children; }

		@property {
			override void resize() {update();}
			override void relocate() {update();}
		}
	}

	protected {
		void update();
	}
}