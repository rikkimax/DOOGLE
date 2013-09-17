module test;
import doogle.platform;
import doogle.window.window;
import doogle.window.context;
import doogle.window.component;
import doogle.events.event;
import doogle.events.types;
import doogle.events.oop;

import std.stdio;

void main() {
	shared Window window = new shared Window(800, 600, "Window"w, WindowStyle.Close);
	shared Window w2 = new shared Window(800, 600, "Window2"w, WindowStyle.Close);
	shared Context gl = window.getContext;
	shared Context gl2 = w2.getContext;

	shared EventClassTest tc = new shared EventClassTest();

	window.addChild(tc.component);
	window.selectChild = tc.component;

	shared(Event) ev;
L1: while(window.isOpen && w2.isOpen) {
		while(window.getEvent(ev) && window.isOpen) {
			if (ev.type == EventTypes.Close)
				break L1;
		}
		window.redraw();
		while(w2.getEvent(ev) && w2.isOpen) {
			if (ev.type == EventTypes.Close)
			break L1;
		}
		w2.redraw();
	}
}

class TestChild : ComponentChild {
	override void redraw(shared(Window) window) {/* writeln("redraw called"); */super.redraw(window);}

	@property {
		override void resize() {/*writeln("resize called");*/}
		override void relocate() {/*writeln("relocated called");*/}
	}
}

shared class EventClassTest : EventClass!TestChild {
	this() {
		super();
		component.x = 100;
		component.y = 100;
		component.width = 700;
		component.height = 500;
	};

	override bool unknown(Event){writeln("===========GOT UNKNOWN==============");return false;}

	override bool keyDown(Keys code, bool alt, bool control, bool shift){writeln("===========GOT KEYDOWN==============", code);return false;}
	override bool keyUp(Keys code, bool alt, bool control, bool shift){writeln("===========GOT KEYUP==============", code);return false;}

	override bool mouseDown(uint x, uint y, uint relx, uint rely, MouseButtons button){writeln("===========GOT MOUSEDOWN==============", button);return false;}
	override bool mouseUp(uint x, uint y, uint relx, uint rely, MouseButtons button){writeln("===========GOT MOUSEUP==============", button);return false;}
	override bool mouseMove(uint x, uint y, uint relx, uint rely){writeln("===========GOT MOUSEMOVE==============");return false;}
	override bool mouseWheel(uint x, uint y, uint relx, uint rely, int delta){writeln("===========GOT MOUSEWHEEL==============");return false;}
	
	override bool redraw(){return false;}
}