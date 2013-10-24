module doogle.controls.font;

version(Windows) {
	public import doogle.controls.font_def;
	public import doogle.controls.font_freetype;
	alias Font_FreeType Font;
	alias Image FontImageType;
}