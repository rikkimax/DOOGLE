module doogle.window.window_def;
import doogle.window.component;
import doogle.window.context;

import doogle.events.event;
import doogle.events.types;

enum WindowStyle {
	Base = 0,
	Resize = 1,
	Close = 2,
	FullScreen = 4
}

abstract shared class Window_Def : Component, ComponentChildable {
	protected {
		bool _isOpen, _hasFocus;
		ComponentChild[] _children;
		Context _context = null;
		WindowStyle _windowStyle;

		/**
		 * Required to determine if to display
		 */
		ComponentChild _selectedChild;
	}
	
	this(uint width = 800, uint height = 600, wstring title = "Window", WindowStyle style = WindowStyle.Close){}

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
		 * stuff
		 */
		@property {
			/**
			 * Properties of window
			 */
			
			bool isOpen() { synchronized return _isOpen; }

			void updateStyle(WindowStyle);

			void selectChild(shared(ComponentChild) child) { synchronized _selectedChild = child; }

			shared(ComponentChild) selectedChild() { synchronized return _selectedChild; }

			bool hasFocus() { synchronized return _hasFocus; }
		}

		/**
		 * Common operations
		 */

		shared(Context) getContext(ubyte color = 32, ubyte depth = 24, ubyte stencil = 8, ubyte antialias = 1);

		void redraw();

		void visible(bool);

		void close();

		bool event();

		override bool getEvent(out shared(Event) ev) {
			event();
			return super.getEvent(ev);
		}

		bool whileOpenEvent() {
			Event ev;
			while(getEvent(ev) && isOpen) {
				if (ev.type == EventTypes.Close)
					return false;
			}
			return true;
		}

		void childEvent(shared(Event) event) {
			foreach(k; _eventHandlers.keys) {
				if (k == event.type) {
					foreach(handler; _eventHandlers[k]) {
						if (handler(event, this)) break;
					}
				}
			}
		}
	}
}

protected {
	Keys translateKey(uint code);
}