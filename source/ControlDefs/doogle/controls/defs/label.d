module doogle.controls.defs.label;
public import doogle.util.color : Color3, Color, Color4;

shared interface Label_Def {
	@property {
		wstring text();
		void text(wstring value);

		Color3 color();
		void color(Color3 value);

		Color background();
		void background(Color value);
	}
}