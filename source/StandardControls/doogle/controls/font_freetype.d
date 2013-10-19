module doogle.controls.font_freetype;
import doogle.controls.font;
import doogle.platform;
import doogle.util.image;

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

	this(string name, float size, float kerning = float.nan) {
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

		error = FT_Set_Pixel_Sizes(cast(FT_Face)ftface, 0, cast(int)size);
		if (error) {
			throw new Exception("Could not use font " ~ name ~ " with size " ~ to!string(size) ~ " error " ~ to!string(error));
		}
	}

	override shared(Image) get(wstring text) {
		synchronized {
			shared(Image) ret = new shared Image();
			ret.format = InternalFormat.RGB;
			FT_Error error;

			FT_GlyphSlot slot = cast(FT_GlyphSlot)ftface.glyph;
			int pen_x, pen_y;

			foreach(wchar c; text) {
				FT_UInt glyph_index;

				glyph_index = FT_Get_Char_Index(cast(FT_Face)ftface, c);

				error = FT_Load_Glyph(cast(FT_Face)ftface, glyph_index, FT_LOAD_DEFAULT);
				if (error) continue;

				error = FT_Render_Glyph(slot, FT_RENDER_MODE_NORMAL);
				if (error) continue;

				ubyte* buffer = cast(ubyte*)(*slot).bitmap.buffer;
				ret.width = (*slot).bitmap.width;
				ret.height = (*slot).bitmap.rows;

				for (uint i = 0; i < ret.width + ret.height; i++) {
					ret.data() ~= *(buffer + i);
				}
			}

			return ret;
		}
	}
}