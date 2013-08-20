module doogle.util.image;
import doogle.util.color;
import doogle.util.misc;

interface Image{
	@property {
		size_t width();
		size_t height();
		Color[][] colors();
		Color[] values();
		ubyte[] data();
		void colors(Color[][]);
		void values(Color[]);
		void data(ubyte[]);
	}
}

class ImageData(size_t _width, size_t _height) : Image {
	union {
		Color[_width][_height] colors_;
		Color[_height * _width] values_;
		ubyte[_height * _width * Color.sizeof] data_;
	}
	size_t height_ = _height;
	size_t width_ = _width;

	@property {
		size_t width() {
			return width_;
		}

		size_t height() {
			return height_;
		}

		Color[][] colors() {
			return cast(Color[][])cast(Color[_width][])colors_;
		}

		Color[] values() {
			return cast(Color[])values_;
		}

		ubyte[] data() {
			return cast(ubyte[])data_;
		}

		void colors(Color[][] v)
		in {
			static assert(v.length == height);
			foreach (v2; v) {
				static assert(v2.length == width);
			}
		} body {
			colors_ = cast(Color[_width][])v;
		}
		void values(Color[] v)
		in {
			static assert(v.length == _height * _width);
		} body {
			values_ = v;
		}

		void data(ubyte[] v)
		in {
			static assert(v.length == _height * _width * 3);
		} body {
			data_ = v;
		}
	}
}

unittest {
	Image image = new ImageData!(2, 1);
	image.values = [
		Color(1, 2, 3, 4),
		Color(5, 6, 7, 8)];

	assert(image.data == [1, 2, 3, 4, 5, 6, 7, 8]);
	assertFailed({image.values = [
		Color(1, 2, 3, 4),
		Color(5, 6, 7, 8),
		Color(9, 10, 11, 12)];});
}