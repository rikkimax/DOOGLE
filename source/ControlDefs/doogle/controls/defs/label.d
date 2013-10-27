module doogle.controls.defs.label;

shared interface Label_Def {
	@property {
		wstring text();
		void text(wstring value);
	}
}