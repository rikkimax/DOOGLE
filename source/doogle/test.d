module test;
import doogle.controls.font;
import doogle.platform;
import doogle.window.window;
import doogle.controls.all;
import doogle.events.oop;
import doogle.events.types;
import doogle.events.event;

import core.thread;

void main() {
	// make sure all the files were loaded.
	assert(storage.fonts.local.length == 1);
	assert(storage.shaders.local.length == 6);
	assert(storage.models.local.length == 2);

	shared Window1 window = new shared Window1();

	while (window.isOpen) {
		window.redraw();
	}
}

shared class Window1 : EventClass!Window {
	alias component this;
	
	shared(Label) boo1;
	shared(Label) boo2;
	shared(Picture) hi;

	this() {
		super(800, 600, "OpenGL Window"w, WindowStyle.Close);
		boo1 = new shared BooLabel1(cast(shared(Window))this);
		boo2 = new shared BooLabel2(cast(shared(Window))this);
		hi = new shared HiPicture(cast(shared(Window))this);
	}
	
	@OOPEvent(EventTypes.Draw) void onDraw() {
		if (!whileOpenEvent()) return;
		gl.glClearColor(0.4f, 0.4f, 0.4f, 1f);
		glwrap.glClear(true, true);
		Thread.sleep(dur!"msecs"(75));
	}
}

shared class BooLabel1 : EventClass!Label {
	alias component this;

	this(shared(Window) window) {
		super(window, 400, 300, "boo"w, new shared Font("Anonymous_Pro.ttf", 20, 3), Color3.fromHex("FF3300"));
		background = Color4.opaque;
		runEvent("test");
	}

	@OOPEvent("test") bool func() {
		import std.stdio;writeln("hi from test func");
		return false;
	}

	@OOPEvent(EventTypes.Draw) void onDraw() {
		import std.stdio;writeln("on draw");
	}
}

shared class BooLabel2 : EventClass!Label {
	alias component this;

	this(shared(Window) window) {
		super(window, 400, 320, "boo"w, new shared Font("Anonymous_Pro.ttf", 20, 3), Color3.fromHex("FF3300"));
		background = cast(Color4)(Color3.fromName("MintCream"));
		runEvent("test");
	}

	@OOPEvent("test") bool func() {
		import std.stdio;writeln("hi from test func");
		return false;
	}

	@OOPEvent(EventTypes.Draw) void onDraw() {
		import std.stdio;writeln("on draw");
	}
}

shared class HiPicture : EventClass!Picture {
	alias component this;
	
	this(shared(Window) window) {
		shared Font font = new shared Font("Anonymous_Pro.ttf", 20, 3);
		auto text_hi = font.get("Hi", Color3.fromName("Red"));
		super(window, 750, 550, 50, 50, text_hi);
		
		this.font = font;
		caption = "hi"w;
	}
}