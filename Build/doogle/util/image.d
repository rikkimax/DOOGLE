module doogle.util.image;
public import doogle.util.color : Color;
import doogle.overloads.structify;
import doogle.gl.texture;
public import doogle.overloads.wrappers : InternalFormat;

struct RawImage {
	size_t width;
	size_t height;
	size_t depth;
	InternalFormat format;
	union {
		ubyte[] data;
		Color[] colors;
	}
	private {
		shared(Image) imageData;
	}

	void opAssign(shared(Image) id) {
		imageData = id;
	}

	shared(Image) opCast(T : Image)() {
		if (imageData is null) {
			imageData = new shared RawTexture!(width, height, depth)(colors);
		}
		imageData.data = data;
		return imageData;
	}
}

shared interface Image {
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
	}
}