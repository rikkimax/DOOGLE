module doogle.controls.font_def;
public import doogle.util.image : Image;

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

	shared(Image) get(wstring text);
}