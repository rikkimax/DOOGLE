module doogle.events.oop;
import doogle.events.event;
import doogle.events.types;
import doogle.window.component;
import doogle.window.window;

shared interface EventInterface {
	bool unknown(Event);

	bool keyDown(Keys code, bool alt, bool control, bool shift);
	bool keyUp(Keys code, bool alt, bool control, bool shift);

	bool mouseDown(uint x, uint y, uint relx, uint rely, MouseButtons button);
	bool mouseUp(uint x, uint y, uint relx, uint rely, MouseButtons button);
	bool mouseWheel(uint x, uint y, uint relx, uint rely, int delta);
	bool mouseMove(uint x, uint y, uint relx, uint rely);
	
	bool redraw();
}

shared interface EventWindowInterface : EventInterface {
	bool windowClose();
	bool windowResize(uint width, uint height);
	bool windowMove(uint x, uint y);
	bool windowFocussed();
	bool windowBlurred();
}

interface EventChildInterface : EventInterface {
}

shared class EventClass(U : ComponentChild) : EventChildInterface {
	protected {
		U component;
	}

	/**
	 * Don't forget to call this after you created the component.
	 * So you MUST add a constructor.
	 * By just calling super();
	 */
	this(this T)() {
		component = new shared U();
		foreach(d; [__traits(derivedMembers, T)]) {
			switch(d) {
				case "unknown":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event);
					} 
					component.addEventHandler(EventTypes.Unknown, &FUNC!unknown);
					break;
				case "keyUp":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.key.code, event.key.alt, event.key.control, event.key.shift);
					} 
					component.addEventHandler(EventTypes.KeyUp, &FUNC!keyUp);
					break;
				case "mouseDown":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.button);
					} 
					component.addEventHandler(EventTypes.MouseDown, &FUNC!mouseDown);
					break;
				case "mouseUp":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.button);
					} 
					component.addEventHandler(EventTypes.MouseUp, &FUNC!mouseUp);
					break;
				case "mouseWheel":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.delta);
					} 
					component.addEventHandler(EventTypes.MouseWheel, &FUNC!mouseWheel);
					break;
				case "mouseMove":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely);
					} 
					component.addEventHandler(EventTypes.MouseMove, &FUNC!mouseMove);
					break;
				case "mouseEnter":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely);
					} 
					component.addEventHandler(EventTypes.MouseEnter, &FUNC!mouseEnter);
					break;
				case "mouseLeave":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y);
					} 
					component.addEventHandler(EventTypes.MouseLeave, &FUNC!mouseLeave);
					break;
				case "redraw":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d();
					} 
					component.addEventHandler(EventTypes.Draw, &FUNC!redraw);
					break;
				default:
					//ignore.
					break;
			}
		}
	}

	bool unknown(Event){return false;}
	
	bool keyDown(Keys code, bool alt, bool control, bool shift){return false;}
	bool keyUp(Keys code, bool alt, bool control, bool shift){return false;}
	
	bool mouseDown(uint x, uint y, uint relx, uint rely, MouseButtons button){return false;}
	bool mouseUp(uint x, uint y, uint relx, uint rely, MouseButtons button){return false;}
	bool mouseWheel(uint x, uint y, uint relx, uint rely, int delta){return false;}
	bool mouseMove(uint x, uint y, uint relx, uint rely){return false;}
	
	bool redraw() {return false;}
}

shared class EventClass(U : Window) : EventWindowInterface {
	protected {
		U component;
	}

	/**
	 * Don't forget to call this after you created the component.
	 * So you MUST add a constructor.
	 * By just calling super();
	 */
	this(this T)() {
		component = new shared U();
		foreach(d; [__traits(derivedMembers, T)]) {
			switch(d) {
				case "unknown":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event);
					} 
					component.addEventHandler(EventTypes.Unknown, &FUNC!unknown);
					break;
				case "keyUp":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.key.code, event.key.alt, event.key.control, event.key.shift);
					} 
					component.addEventHandler(EventTypes.KeyUp, &FUNC!keyUp);
					break;
				case "mouseDown":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.button);
					} 
					component.addEventHandler(EventTypes.MouseDown, &FUNC!mouseDown);
					break;
				case "mouseUp":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.button);
					} 
					component.addEventHandler(EventTypes.MouseUp, &FUNC!mouseUp);
					break;
				case "mouseWheel":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely, event.mouse.delta);
					} 
					component.addEventHandler(EventTypes.MouseWheel, &FUNC!mouseWheel);
					break;
				case "mouseMove":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.mouse.x, event.mouse.y, event.mouse.relx, event.mouse.rely);
					} 
					component.addEventHandler(EventTypes.MouseMove, &FUNC!mouseMove);
					break;
				case "windowClose":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d();
					} 
					component.addEventHandler(EventTypes.Close, &FUNC!windowClose);
					break;
				case "windowResize":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.window.width, event.window.height);
					} 
					component.addEventHandler(EventTypes.WindowResize, &FUNC!windowResize);
					break;
				case "windowMove":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d(event.window.x, event.window.y);
					} 
					component.addEventHandler(EventTypes.WindowMove, &FUNC!windowMove);
					break;
				case "windowFocussed":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d();
					} 
					component.addEventHandler(EventTypes.WindowFocussed, &FUNC!windowFocussed);
					break;
				case "windowBlurred":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d();
					} 
					component.addEventHandler(EventTypes.WindowBlurred, &FUNC!windowBlurred);
					break;
				case "redraw":
					bool FUNC(alias d)(shared(Event) event, shared(Component) component) {
						return d();
					} 
					component.addEventHandler(EventTypes.Draw, &FUNC!redraw);
					break;
				default:
					//ignore.
					break;
			}
		}
	}

	bool unknown(Event){return false;}
	
	bool keyDown(Keys code, bool alt, bool control, bool shift){return false;}
	bool keyUp(Keys code, bool alt, bool control, bool shift){return false;}

	bool mouseDown(uint x, uint y, uint relx, uint rely, MouseButtons button){return false;}
	bool mouseUp(uint x, uint y, uint relx, uint rely, MouseButtons button){return false;}
	bool mouseWheel(uint x, uint y, uint relx, uint rely, int delta){return false;}
	bool mouseMove(uint x, uint y, uint relx, uint rely){return false;}

	bool windowClose(){return false;}
	bool windowResize(uint width, uint height){return false;}
	bool windowMove(uint x, uint y){return false;}
	bool windowFocussed(){return false;}
	bool windowBlurred(){return false;}
	
	bool redraw() {return false;}
}