module doogle.gl.texture;
import doogle.util.image;
import doogle.util.color;
import doogle.util.misc;
public import doogle.overloads.wrappers : InternalFormat;
import doogle.overloads.structify;
public import doogle.overloads.structify : TextureObj;

shared interface Texture {
	void activate();

	@property {
		TextureObj opCast(T : TextureObj)();
	}
}

private {
	pure size_t bitdepth(size_t depth) { return depth / 8; }

	shared Texture currentTexture;
}

shared class RawTexture(size_t _width, size_t _height = 1, size_t _depth = 8) : Image, Texture {
	protected {
		union {
			Color[_width * bitdepth(_depth)][_height * bitdepth(_depth)] colors_;
			Color[_height * _width * bitdepth(_depth)] values_;
			ubyte[_height * _width * Color.sizeof * bitdepth(_depth)] data_;
		}
		size_t height_ = _height;
		size_t width_ = _width;
		size_t depth_ = _depth;
		InternalFormat format_;
		TextureObj id_;
	}

	this(shared(ubyte[]) colors)
	in {
		assert(colors.length == data_.length);
	} body {
		this(cast(shared(Color[])) colors);
	}

	this(shared(Color[]) colors)
	in {
		assert(colors.length == values_.length);
	} body {
		values_ = colors;
		glGenTextures(id_);
	}

	~this() {
		synchronized {
			// destroy obj
			glDeleteTextures(id_);
		}
	}
	
	RawImage opCast(T : RawImage)() {
		synchronized {
			return RawImage(width, height, format_, values_);
		}
	}

	TextureObj opCast(T : TextureObj)() {
		synchronized {
			return id_;
		}
	}

	void activate() {
		synchronized {
			currentTexture = this;
		}
	}
	
	@property {
		size_t width() {
			synchronized {
				return width_;
			}
		}

		size_t height() {
			synchronized {
				return height_;
			}
		}
		
		size_t depth() {
			synchronized {
				return depth_;
			}
		}
		
		shared(Color[][]) colors() {
			synchronized {
				return cast(shared(Color[][]))cast(shared(Color[_width][]))colors_;
			}
		}
		
		shared(Color[]) values() {
			synchronized {
				return cast(shared(Color[]))values_;
			}
		}
		
		shared(ubyte[]) data() {
			synchronized {
				return cast(shared(ubyte[]))data_;
			}
		}
		
		InternalFormat format() {
			synchronized {
				return format_;
			}
		}
		
		void format(InternalFormat format) {
			synchronized {
				format_ = format;
			}
		}
		
		void colors(shared(Color[][]) v)
		in {
			static assert(v.length == _height * bitdepth(_depth));
			foreach (v2; v) {
				static assert(v2.length == _width * bitdepth(_depth));
			}
		} body {
			synchronized {
				colors_ = cast(shared(Color[_width][]))v;
			}
		}
		
		void values(shared(Color[]) v)
		in {
			static assert(v.length == _height * _width * bitdepth(_depth));
		} body {
			synchronized {
				values_ = v;
			}
		}
		
		void data(shared(ubyte[]) v)
		in {
			static assert(v.length == _height * _width * Color.sizeof * bitdepth(_depth));
		} body {
			synchronized {
				data_ = v;
			}
		}
	}
}

unittest {
	shared(Image) image = new shared RawTexture!(2, 1)([0, 0, 0, 0,
														0, 0, 0, 0]);
	image.values = [
		Color(1, 2, 3, 4),
		Color(5, 6, 7, 8)];
	
	assert(image.data == [1, 2, 3, 4, 5, 6, 7, 8]);
	assertFailed({image.values = [
			Color(1, 2, 3, 4),
			Color(5, 6, 7, 8),
			Color(9, 10, 11, 12)];});

	pragma(msg, Color.sizeof);
}