module doogle.gl.texture;
import doogle.platform;
public import doogle.gl.buffers;
public import doogle.overloads.wrappers : InternalFormat, BindTextureTarget;
import doogle.util.color;

shared class Texture {
	protected {
		size_t width_;
		size_t height_;
		size_t depth_;
		
		union {
			Color[][] colors_;
			Color[] values_;
			ubyte[] data_;
		}
		
		BindTextureTarget target_;
		InternalFormat format_;
		uint id_;
	}
	
	
	this(shared(ubyte[]) _colors, size_t _width, size_t _height = 1, size_t _depth=1, BindTextureTarget _target = BindTextureTarget.Texture2D, InternalFormat _format = InternalFormat.RGBA) {
		width_ = _width;
		height_ = _height;
		target_ = _target;
		depth_ = _depth;
		format_ = _format;
		
		if (_format == InternalFormat.RGB) {
			ubyte i = 0;
			foreach(b; _colors) {
				data_ ~= b;
				if (i < 2) {
					i++;
				} else {
					data_ ~= 1;
					i = 0;
				}
			}
		} else {
			data_ = _colors;
		}
		setup();
	}
	
	this(shared(Color[]) _colors, size_t _width, size_t _height = 1, size_t _depth=1, BindTextureTarget _target = BindTextureTarget.Texture2D, InternalFormat _format = InternalFormat.RGBA) {
		width_ = _width;
		height_ = _height;
		target_ = _target;
		depth_ = _depth;
		format_ = _format;
		
		values_ = _colors;
		setup();
	}
	
	this(shared(Color[][]) _colors, size_t _width, size_t _height = 1, size_t _depth=1, BindTextureTarget _target = BindTextureTarget.Texture2D, InternalFormat _format = InternalFormat.RGBA) {
		width_ = _width;
		height_ = _height;
		target_ = _target;
		depth_ = _depth;
		format_ = _format;
		
		colors_ = _colors;
		setup();
	}
	
	~this() {
		synchronized {
			// destroy obj
			gl.glDeleteTextures(1, cast(uint*)&id_);
		}
	}
	
	glstruct.TextureObj opCast(T : glstruct.TextureObj)() {
		synchronized {
			return cast(glstruct.TextureObj)id_;
		}
	}
	
	uint opCast(T : uint)() {
		synchronized {
			return cast(uint)id_;
		}
	}
	
	void bind() {
		synchronized {
			//currentTexture = this;
			gl.glActiveTexture(gl.GL_TEXTURE0);
			glwrap.glBindTexture(target_, id_);
			gl.glTexParameteri(target_, gl.GL_TEXTURE_MIN_FILTER, gl.GL_NEAREST_MIPMAP_NEAREST);
			gl.glTexParameteri(target_, gl.GL_TEXTURE_MAG_FILTER, gl.GL_NEAREST);
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
		
		shared(Color[][]) colors() {
			synchronized {
				return colors_;
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
			assert(v.length == height_);
			foreach (v2; v) {
				assert(v2.length == width_);
			}
		} body {
			synchronized {
				colors_ = v;
				update();
			}
		}
		
		void values(shared(Color[]) v)
		in {
			assert(v.length == height_ * width_);
		} body {
			synchronized {
				values_ = v;
				update();
			}
		}
		
		void data(shared(ubyte[]) v)
		in {
			assert(v.length == height_ * width_ * Color.sizeof);
		} body {
			synchronized {
				data_ = v;
				update();
			}
		}
	}
	
	protected {
		void setup() {
			gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1);
			gl.glGenTextures(1, cast(uint*)&id_);
			bind();
			update();
			gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 4);
		}
	
		void update() {
			synchronized {
				if (target_ == BindTextureTarget.Texture3D) {
					glwrap.glTexImage3D(target_, 0, cast(InternalFormat)format_, cast(uint)width_, cast(uint)height_, cast(uint)depth_, glwrap.PixelFormat.RGB, glwrap.PixelDataType.UByte, cast(void[])data_);
				} else if (target_ == BindTextureTarget.Texture2D) {
					glwrap.glTexImage2D(target_, 0, cast(InternalFormat)format_, cast(uint)width_, cast(uint)height_, glwrap.PixelFormat.RGB, glwrap.PixelDataType.UByte, cast(void[])data_);
				}
				gl.glGenerateMipmap(target_);
			}
		}
	}
}