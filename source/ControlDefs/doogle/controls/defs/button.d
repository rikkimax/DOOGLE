module doogle.controls.defs.button;
import doogle.window.component;

enum ButtonState {
	Up,
	Down
}

enum ButtonBorder {
	Flat,
	Popup,
	Standard
}

shared interface Button_Def : ComponentChildable {
	@property {
		ButtonState state();
		
		ButtonBorder border();
		void border(ButtonBorder value);
	}
}