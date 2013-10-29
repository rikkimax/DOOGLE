module doogle.controls.font_def;
import doogle.controls.font;
public import doogle.drawing.image : Image;
public import doogle.util.color : Color3;

abstract shared class Font_Def {
	protected {
		string name;
		size_t size;
		size_t kerning;
	}

	this(string name, size_t size, size_t kerning = 0) {
		this.name = name;
		this.size = size;
		this.kerning = kerning;
	}

	shared(FontImageType) get(wstring text, shared(Color3) color = Color3(255, 255, 255));
}