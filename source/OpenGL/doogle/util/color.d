module doogle.util.color;

// alias Color4 as default type of color, just cos..
alias Color4 Color;

struct Color3 {
	union {
		struct {
			ubyte r, g, b;
		}
		ubyte[3] values;
	}

	Color4 opCast(T : Color4)() {
		// generally speaking alpha should be 255 because without it you won't see it ;)
		return Color4(r, g, b, 255);
	}
}

struct Color4 {
	union {
		struct {
			ubyte r, g, b, a;
		}
		ubyte[4] values;
	}

	Color3 opCast(T : Color3)() {
		return Color3(r, g, b);
	}
}

unittest {
	Color4 c = {1, 2, 3, 4};
	Color3 c2 = cast(Color3)c;
	Color4 c3 = cast(Color4)c2;

	assert(c2.values == [1, 2, 3]);
	assert(c3.values == [1, 2, 3, 255]);
}