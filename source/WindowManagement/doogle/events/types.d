module doogle.events.types;

enum MouseButtons {
	Left,
	Right,
	Middle
}

enum Keys {
	Unknown,
	F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
	A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
	Num0, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9,
	LeftBracket, RightBracket, Semicolon, Comma, Period, Quote, Slash, Backslash, Tilde, Equals, Hyphen,
	Escape, Control, Shift, Alt, Space, Enter, Backspace, Tab, PageUp, PageDown, End, Home, Insert, Delete, Pause,
	Left, Right, Up, Down,
	Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6, Numpad7, Numpad8, Numpad9,
	Add, Subtract, Multiply, Divide
}

enum EventTypes {
	Unknown,
	Close,
	Resize,
	Move,
	Focus,
	Blur,
	KeyDown,
	KeyUp,
	MouseDown,
	MouseUp,
	MouseWheel,
	MouseMove,
	MouseEnter,
	MouseLeave,
	Draw,
	Creation
}

enum EventCatagories {
	Mouse,
	Keyboard,
	Window
}

pure bool isEventCatagory(EventCatagories ec, EventTypes type) {
	if (ec == EventCatagories.Mouse) {
		return type == EventTypes.MouseMove ||
			type == EventTypes.MouseWheel ||
			type == EventTypes.MouseUp ||
			type == EventTypes.MouseDown;
	} else if (ec == EventCatagories.Keyboard) {
		return type == EventTypes.KeyUp ||
			type == EventTypes.KeyDown;
	} else if (ec == EventCatagories.Window) {
		return type == EventTypes.Close ||
			type == EventTypes.Resize ||
			type == EventTypes.Move ||
			type == EventTypes.Focus ||
			type == EventTypes.Blur ||
			type == EventTypes.Draw ||
			type == EventTypes.Creation;
	}
	return false;
}
