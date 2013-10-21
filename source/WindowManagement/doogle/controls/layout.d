module doogle.controls.layout;
import doogle.controls.control;
import doogle.window.component;

static if (__traits(compiles, {import doogle.controls.layout_impl;})) {
	public import doogle.controls.layout_impl;
	alias Layout_Impl Layout;
} else {
	alias Layout_Def Layout;
}

shared abstract class Layout_Def : ComponentChild, ComponentChildable, ControlChildable {
	protected {
		ComponentChild[] _children;
		Control[] _childControls;
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

		/**
		 * ControlChildable
		 */
		
		void addChild(shared(Control) child) {
			synchronized _childControls ~= child;
		}
		
		void removeChild(shared(Control) child) {
			synchronized {
				if (_childControls.length == 0) return;
				size_t found;
				bool got = false;
				for(size_t i = 0; i < _childControls.length; i++ ) {
					if (_childControls[i] == child) {
						found = i;
						got = true;
						break;
					}
				}
				if (got) {
					if (found > _childControls.length) // middle
						_childControls = _childControls[0 .. found]  ~ _childControls[found .. $];
					else if (found > 0) // end
						_childControls = _childControls[0 .. found];
					else // start
						_childControls= _childControls[found .. $];
					
				}
			}
		}
		
		@property shared(Control)[] childControls() { synchronized return cast(shared(Control)[]) _childControls; }

		@property {
			override void resize() {update();}
			override void relocate() {update();}
		}
	}

	protected {
		void update();
	}
}

/**
 * A very basic layout. All it does is contain a bunch of controls.
 */
class ContainerLayout : Layout {
	protected {
		override void update(){}
	}
}