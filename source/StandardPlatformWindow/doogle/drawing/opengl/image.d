module doogle.drawing.opengl.image;
import doogle.drawing.image_def;
public import doogle.gl.texture : Texture;
import doogle.overloads.structify;
public import doogle.overloads.wrappers : PixelFormat;

shared class Image_OpenGL : Image_Def {
	PixelFormat pformat_;

	this() {
	}
	
	this(size_t _width, size_t _height, size_t _depth, InternalFormat _format, shared(ubyte[]) _data) {
		super(_width, _height, _depth, _format, _data);
		if (_format == InternalFormat.RGB8) {
			pformat_ = PixelFormat.RGB;
		} else {
			pformat_ = cast(PixelFormat)_format;
		}
	}

	@property shared(Texture) texture() {
		synchronized {
			return new shared Texture(data_, cast(uint)width_, cast(uint)height_, cast(uint)depth_, BindTextureTarget.Texture2D, cast(InternalFormat)format_, pformat_);
		}
	}

	@property {
		ref PixelFormat pformat() {
			synchronized {
				return pformat_;
			}
		}

		void pformat(PixelFormat _pformat) {
			synchronized {
				pformat_ = _pformat;
			}
		}
	}
}