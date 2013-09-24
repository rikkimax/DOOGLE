module doogle.controls.font;
import doogle.util.image;
import doogle.gl.texture;

static if (__traits(compiles, {import doogle.controls.font_freetype;})) {
	public import doogle.controls.font_freetype;
	alias Font_FreeType Font;
} else {
	pragma(msg, "Font implementation is not implemented");
	static assert(0);
}

shared class Font_Def {
	/*this(string name, ubyte size, float kerning) {

	}*/

	//FontImage get(wstring text);
}

/*shared class FontImage : Image {
	@property {
		size_t width();
		size_t height();
		size_t depth();
		shared(Color[][]) colors();
		shared(Color[]) values();
		shared(ubyte[]) data();
		InternalFormat format();
		void colors(shared(Color[][]));
		void values(shared(Color[]));
		void data(shared(ubyte[]));
		void format(InternalFormat);
		RawImage opCast(T : RawImage)();
		RawImage opCast(T : RawTexture)();
	}
}*/