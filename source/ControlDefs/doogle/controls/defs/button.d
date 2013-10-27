module doogle.controls.defs.button;

enum ButtonState {
	Up,
	Down
}

interface Button_Def {
	@property {
		ButtonState state();
	}
}