module doogle.controls.defs.label;

enum TextAlign {
	Left,
	Right,
	Center
}

interface Label_Def {
	@property {
		wstring text();
		void text(wstring value);
		TextAlign alignment();
		void alignment(TextAlign value);
	}
}