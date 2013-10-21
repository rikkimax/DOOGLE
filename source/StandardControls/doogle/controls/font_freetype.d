module doogle.controls.font_freetype;
import doogle.controls.font;
import doogle.util.image;
import storage = doogle.util.storage;
import glwrap = doogle.overloads.wrappers;

import derelict.freetype.ft;

import std.conv;

private {
	__gshared FT_Library ftlibrary;
}

shared class Font_FreeType : Font_Def {
	protected {
		FT_Face ftface;
		ubyte[] fontvalue;
	}

	this(string name, size_t size=50, size_t kerning = 3) {
		size *= 64; // FreeType pt conversion
		super(name, size, kerning);

		FT_Error error;

		if (ftlibrary == FT_Library.init) {
			error = FT_Init_FreeType(&ftlibrary);
			if (error) {
				throw new Exception("ERROR libfreetype2 " ~ to!string(error));
			}
		}

		fontvalue = cast(shared)storage.fonts.get(name);
		error = FT_New_Memory_Face(ftlibrary, cast(ubyte*)fontvalue.ptr, cast(uint)fontvalue.length, 0, cast(FT_Face*)&ftface);
		if (error == FT_Err_Unknown_File_Format) {
			throw new Exception("Font file format unrecognised " ~ name);
		} else if (error) {
			throw new Exception("Could not use font " ~ name ~ " with error " ~ to!string(error));
		}

		error = FT_Set_Char_Size(cast(FT_Face)ftface, 0, cast(int)size, 300, 300);
		if (error) {
			throw new Exception("Could not use font " ~ name ~ " with size " ~ to!string(size) ~ " error " ~ to!string(error));
		}
	}

	~this() {
		synchronized {
			FT_Done_Face(cast(FT_Face)ftface);
		}
	}

	override shared(Image) get(wstring text) {
		synchronized {
			shared(Image) ret = new shared Image();
			ret.format = InternalFormat.RGB8;
			ret.pformat = glwrap.PixelFormat.RGB;
			ret.depth = 0;

			FT_Error error;
			FT_GlyphSlot slot = cast(FT_GlyphSlot)ftface.glyph;

			ubyte[][] data;
			size_t x;
			size_t maxWidth = 0;
			size_t width;
			size_t height;

			foreach(wchar c; text) {
				FT_UInt glyph_index;

				error = FT_Load_Char(cast(FT_Face)ftface, c, FT_LOAD_RENDER);
				if (error) throw new Exception("Could not load glpyh for " ~ cast(char)c ~ " error " ~ to!string(error));

				ubyte* buffer = cast(ubyte*)(*slot).bitmap.buffer;
				height = (*slot).bitmap.rows;
				width = (*slot).bitmap.width;
				if (data.length < height) {
					data.length = height;
				}

				for (size_t i = 0; i < width * height; i++) {
					data[(i / width) % height].length = width + x;
					data[(i / width) % height][(i % width) + x] = *(buffer + i);
				}

				ubyte[] kerningAdd;
				for(uint i = 0; i < kerning; i++) {
					kerningAdd ~= 0;
				}

				foreach(ub; data) {
					ub ~= kerningAdd;
				}

				x += width + kerning;

				if (maxWidth < x) {
					maxWidth = x;
				}
			}

			foreach(ubyte[] ub; data) {
				size_t need = maxWidth - ub.length;
				foreach(u; ub) {
					ret ~= u;
					ret ~= u;
					ret ~= u;
				}

				for(uint i; i < need; i++) {
					ret ~= 0;
					ret ~= 0;
					ret ~= 0;
				}
			}
			ret.width = maxWidth;
			ret.height = data.length;

			return ret;
		}
	}
}