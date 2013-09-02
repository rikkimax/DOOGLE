module doogle.events.event;
import doogle.events.types;

shared struct MouseEvent {
	uint x, y;
	uint relx, rely; // only applicable to ComponentChild.
	union {
		int delta;
		MouseButtons button;
	}
}

shared struct KeyEvent {
	Keys code;
	bool alt;
	bool control;
	bool shift;
}

shared struct WindowEvent {
	union {
		int x;
		uint width;
	}
	union {
		int y;
		uint height;
	}
}

shared struct Event {
	EventTypes type;

	union {
		MouseEvent mouse;
		KeyEvent key;
		WindowEvent window;
	}
}