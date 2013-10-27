module doogle.controls.font_freetype;
import doogle.controls.font_def;
import doogle.drawing.image;
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

		error = FT_Set_Char_Size(cast(FT_Face)ftface, 0, cast(int)size, 72, 72);
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
				import std.stdio;writeln(width);
				import std.stdio;writeln(height);

				ptrdiff_t mult = width * height;
				for (ptrdiff_t i = mult - 1; i >= 0; i--) {
					ptrdiff_t idiff = mult - i;
					uint y = (idiff / width) % height;

					data[y].length = width + x;
					data[y][(i % width) + x] = *(buffer + i);
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

			for(ptrdiff_t i = data.length - 1; i >= 0; i--) {
				ubyte[] ub = data[i];
				size_t need = maxWidth - ub.length;

				foreach(u; ub) {
					ret ~= u;
					ret ~= u;
					ret ~= u;
				}

				for(uint j; j < need; j++) {
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