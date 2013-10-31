module doogle.window.component_def;
import doogle.window.component;
import doogle.window.window;

import doogle.events.event;
import doogle.events.types;

shared interface ComponentChildable_Def {
	public {
		void addChild(shared(ComponentChild) child);
		void removeChild(shared(ComponentChild));
		@property shared(Component)[] children();
	}
}

/**
 * Use this for any components that does not extend window.
 */
abstract shared class ComponentChild_Def : Component {
	public {
		/**
		 * Don't worry about extending this.
		 * 
		 * Only call this from a ComponentChildable.
		 * 
		 * If the implementor also implements ComponentChildable then make it
		 * Forward the events to its children.
		 * 
		 * Don't forget to call the apropriete event upon _eventHandlers.
		 */
		void childEvent(shared(Window) window, shared(Component) parent, shared(Event) event) {
			synchronized {
				switch(cast(string)event.type) {
					case EventTypes.MouseMove:
						_mouseX = event.mouse.relx;
						_mouseY = event.mouse.rely;
						if (!mouseOver) {
							mouseOver = true;
						}
						break;
					case EventTypes.MouseDown:
						_mouseButtons[cast(size_t)event.mouse.button] = true;
						break;
					case EventTypes.MouseUp:
						_mouseButtons[cast(size_t)event.mouse.button] = false;
						break;
					case EventTypes.KeyDown:
						_keys[cast(size_t)event.key.code] = true;
						break;
					case EventTypes.KeyUp:
						_keys[cast(size_t)event.key.code] = false;
						break;
					default:
						break;
				}

				runEvent(event);

				static if (__traits(compiles, children.length)) {
					foreach (child; children) {
						if (isEventCatagory(EventCatagories.Mouse, ev.type)) {
							if (event.mouse.x >= child.x && event.mouse.y >= child.y && event.mouse.x <= child.x + child.width && event.mouse.y <= child.y + child.height) {
								if (!child.mouseOver) {
									Event e;
									e.type = EventTypes.MouseEnter;
									e.mouse.x = event.mouse.x;
									e.mouse.y = event.mouse.y;
									e.mouse.relx = event.mouse.x - _x;
									e.mouse.rely = event.mouse.y - _y;
									child.childEvent(window, this, e);
									child.mouseOver = true;
				                }
								child.childEvent(window, this, event);
							} else {
								if (child.mouseOver) {
									Event e;
									e.type = EventTypes.MouseLeave;
									e.mouse.x = event.mouse.x;
									e.mouse.y = event.mouse.y;
									child.childEvent(window, this, e);
									child.mouseOver = false;
								}
							}
						} else if (isEventCatagory(EventCatagories.Keyboard, event.type)) {
							if (child == _selectedChild) {
								child.childEvent(window, this, event);
							}
						}
					}
				}
			}
		}

		/**
		 * Only call this from a ComponentChildable.
		 * Remember to super.redraw(window) call as last thing.
		 */
		void redraw(shared(Window) window) {
			synchronized {
				shared(Event) event;
				event.type = EventTypes.Draw;
				this.childEvent(window, this, event);
			
				static if (__traits(compiles, children.length)) {
					foreach (child; children) {
						child.redraw();
					}
				}
			}
		}

		void runEvent(string event) {
			runEvent(Event(cast(EventTypes)event));
		}

		/**
		 * For your own custom little events.
		 */
		void runEvent(shared(Event) event) {
			synchronized {
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
}

alias bool delegate(shared(Event) event, shared(Component) component) shared EventFunc;

abstract shared class Component {
	protected {
		uint _width, _height;
		uint _x, _y;
		Event[] _events;
		
		uint _mouseX, _mouseY;
		bool[3] _mouseButtons;
		bool _mouseOver;
		
		bool[] _keys = new bool[93];

		EventFunc[][EventTypes] _eventHandlers;
	}
	
	public {
		/**
		 * Events
		 */
		void addEventHandler(EventTypes type, EventFunc func) {
			synchronized _eventHandlers[type] ~= func;
		}

		void removeEventHandler(EventTypes type, EventFunc func) {
			synchronized {
				if (_eventHandlers.get(type, cast(EventFunc[])null).length == 0) return;
				size_t found;
				bool got = false;
				for(size_t i = 0; i < _eventHandlers[type].length; i++ ) {
					if (_eventHandlers[type][i] == func) {
						found = i;
						got = true;
						break;
					}
				}
				if (got) {
					if (found > _eventHandlers.length) // middle
						_eventHandlers[type] = _eventHandlers[type][0 .. found]  ~ _eventHandlers[type][found .. $];
					else if (found > 0) // end
						_eventHandlers[type] = _eventHandlers[type][0 .. found];
					else // start
						_eventHandlers[type] = _eventHandlers[type][found .. $];

				}
			}
		}

		bool hasEventHandler(EventTypes type, EventFunc func) {
			synchronized {
				if (_eventHandlers.get(type, cast(EventFunc[])null).length == 0) return false;
				for(size_t i = 0; i < _eventHandlers[type].length; i++ ) {
					if (_eventHandlers[type][i] == func) return true;
				}
				return false;
			}
		}

		void clearEventHandlers(EventTypes type) { synchronized _eventHandlers[type].length = 0; }

		/**
		 * stuff
		 */
		@property {
			/**
			 * size of window getters / setters
			 */
			
			uint width() { synchronized return _width; }
			uint height() { synchronized return _height; }
			shared(Component) width(uint width) { synchronized { _width = width; return this; } }
			shared(Component) height(uint height) { synchronized { _height = height; return this; } }
			
			void resize(uint width, uint height) {
				_width = width;
				_height = height;
				resize();
			}
			
			void resize();
			
			/**
			 * location of window getters / setters
			 */

			uint x() { synchronized return _x; }
			uint y() { synchronized return _y; }
			shared(Component) x(uint x) { synchronized { _x = x; return this; } }
			shared(Component) y(uint y) { synchronized { _y = y; return this; } }
			
			void relocate(uint x, uint y) {
				synchronized {
					_x = x;
					_y = y;
					relocate();
				}
			}
			
			void relocate();

			/**
			 * mouse location
			 */
			uint mouseX() { synchronized return _mouseX; }
			uint mouseY() { synchronized return _mouseY; }

			bool mouseOver() { synchronized return _mouseOver; }

			/**
			 * Should only be called from ComponentChildable.
			 */
			void mouseOver(bool value) { synchronized _mouseOver = value; }

			/**
			 * Mouse button and keys
			 */
			bool mouseButtonDown(MouseButtons button)
			in {
				synchronized {
					assert(_mouseButtons.length > button);
					assert(button >= 0);
				}
			} body {
				synchronized return _mouseButtons[button];
			}

			bool keyDown(Keys key)
			in {
				synchronized {
					assert(_keys.length > key);
					assert(key >= 0);
				}
			} body {
				synchronized return _keys[key];
			}
			
			/**
			 * Properties of component
			 */

			bool getEvent(out shared(Event) ev) {
				synchronized {
					if (_events.length > 0) {
						ev = _events[0];
						_events = _events[1..$];
						return true;
					} else {
						return false;
					}
				}
			}
		}
	}
}