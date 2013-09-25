module doogle.controls.font;
public import doogle.gl.texture : RawTexture, Texture;

/**
 * Loading order of different global font definitions
 * Allows for non supported implementations to be supplied
 */
static if (__traits(compiles, {import doogle.controls.font_impl;})) {
	public import doogle.controls.font_impl;
	alias Font_Impl Font;
} else static if (__traits(compiles, {import doogle.controls.font_freetype;})) {
	public import doogle.controls.font_freetype;
	alias Font_FreeType Font;
} else {
	pragma(msg, "Font implementation is not implemented");
	static assert(0);
}

abstract shared class Font_Def {
	this(string name, ubyte size, float kerning) {

	}

	Texture get(wstring text);
}