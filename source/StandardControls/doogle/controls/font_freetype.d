module doogle.controls.font_freetype;
import doogle.controls.font;

import doogle.util.image;
import doogle.gl.texture;

shared class Font_FreeType : Font_Def {
	this(string name, ubyte size, float kerning) {
		super(name, size, kerning);
	}

	override Texture get(wstring text) {return null;}
}