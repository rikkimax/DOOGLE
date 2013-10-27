module doogle.controls.defs.button;

enum ButtonState {
	Up,
	Down
}

shared interface Button_Def {
	@property {
		ButtonState state();
	}
}