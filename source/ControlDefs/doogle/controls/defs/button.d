module doogle.controls.defs.button;
import doogle.window.component;

enum ButtonState {
	Up,
	Down
}

shared interface Button_Def : ComponentChildable {
	@property {
		ButtonState state();
	}
}