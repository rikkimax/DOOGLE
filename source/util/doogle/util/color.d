module doogle.util.color;
import doogle.util.misc : hexValue;
import std.string : toLower;

// alias Color4 as default type of color, just cos..
alias Color4 Color;

shared struct Color3 {
	union {
		struct {
			ubyte r, g, b;
		}
		ubyte[3] values;
	}

	@property float rf() {
		return r / 256f;
	}
	
	@property float gf() {
		return g / 256f;
	}
	
	@property float bf() {
		return b / 256f;
	}

	@property float[3] floats() {
		return [rf, gf, bf];
	}

	Color4 opCast(T : Color4)() {
		// generally speaking alpha should be 255 because without it you won't see it ;)
		return Color4(r, g, b, 255);
	}

	static pure shared(Color3) fromHex(string value)
	in {
		assert(value.length == 3 || value.length == 6);
	} body {
		shared Color3 color;
		if (value.length == 6) {
			color.r = hexValue(value[0]);
			color.g = hexValue(value[2]);
			color.b = hexValue(value[4]);
		}  else {
			color.r = hexValue(value[0]);
			color.g = hexValue(value[1]);
			color.b = hexValue(value[2]);
		}
		return color;
	}

	static pure shared(Color3) fromName(string value) {
		ubyte[] rgb = namedHexColor(value);
		if (rgb.length == 3) {
			return Color3(rgb[0], rgb[1], rgb[2]);
		}
		return Color3.init;
	}
}

shared struct Color4 {
	union {
		struct {
			ubyte r, g, b, a;
		}
		ubyte[4] values;
	}

	@property float rf() {
		return r / 256f;
	}

	@property float gf() {
		return g / 256f;
	}

	@property float bf() {
		return b / 256f;
	}

	@property float af() {
		return a / 256f;
	}

	@property float[4] floats() {
		return [rf, gf, bf, af];
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

pure ubyte[] namedHexColor(string s) {
	s = s.toLower();
	switch(s) {
		case "aliceblue":
			return hexValue("F0F8FF");
		case "antiquewhite":
			return hexValue("FAEBD7");
		case "aqua":
			return hexValue("00FFFF");
		case "aquamarine":
			return hexValue("7FFFD4");
		case "azure":
			return hexValue("F0FFFF");
		case "beige":
			return hexValue("F5F5DC");
		case "bisque":
			return hexValue("FFE4C4");
		case "black":
			return hexValue("000000");
		case "blanchedalmond":
			return hexValue("FFEBCD");
		case "blue":
			return hexValue("0000FF");
		case "blueviolet":
			return hexValue("8A2BE2");
		case "brown":
			return hexValue("A52A2A");
		case "burlywood":
			return hexValue("DEB887");
		case "cadetblue":
			return hexValue("5F9EA0");
		case "chartreuse":
			return hexValue("7FFF00");
		case "chocolate":
			return hexValue("D2691E");
		case "coral":
			return hexValue("FF7F50");
		case "cornflowerblue":
			return hexValue("6495ED");
		case "cornsilk":
			return hexValue("FFF8DC");
		case "crimson":
			return hexValue("DC143C");
		case "cyan":
			return hexValue("00FFFF");
		case "darkblue":
			return hexValue("00008B");
		case "darkcyan":
			return hexValue("008B8B");
		case "darkgoldenrod":
			return hexValue("B8860B");
		case "darkgray":
			return hexValue("A9A9A9");
		case "darkgreen":
			return hexValue("006400");
		case "darkkhaki":
			return hexValue("BDB76B");
		case "darkmagenta":
			return hexValue("8B008B");
		case "darkolivegreen":
			return hexValue("556B2F");
		case "darkorange":
			return hexValue("FF8C00");
		case "darkorchid":
			return hexValue("9932CC");
		case "darkred":
			return hexValue("8B0000");
		case "darksalmon":
			return hexValue("E9967A");
		case "darkseagreen":
			return hexValue("8FBC8F");
		case "darkslateblue":
			return hexValue("483D8B");
		case "darkslategray":
			return hexValue("2F4F4F");
		case "darkturquoise":
			return hexValue("00CED1");
		case "darkviolet":
			return hexValue("9400D3");
		case "deeppink":
			return hexValue("FF1493");
		case "deepskyblue":
			return hexValue("00BFFF");
		case "dimgray":
			return hexValue("696969");
		case "dodgerblue":
			return hexValue("1E90FF");
		case "firebrick":
			return hexValue("B22222");
		case "floralwhite":
			return hexValue("FFFAF0");
		case "forestgreen":
			return hexValue("228B22");
		case "fuchsia":
			return hexValue("FF00FF");
		case "gainsboro":
			return hexValue("DCDCDC");
		case "ghostwhite":
			return hexValue("F8F8FF");
		case "gold":
			return hexValue("FFD700");
		case "goldenrod":
			return hexValue("DAA520");
		case "gray":
			return hexValue("808080");
		case "green":
			return hexValue("008000");
		case "greenyellow":
			return hexValue("ADFF2F");
		case "honeydew":
			return hexValue("F0FFF0");
		case "hotpink":
			return hexValue("FF69B4");
		case "indianred ":
			return hexValue("CD5C5C");
		case "indigo  ":
			return hexValue("4B0082");
		case "ivory":
			return hexValue("FFFFF0");
		case "khaki":
			return hexValue("F0E68C");
		case "lavender":
			return hexValue("E6E6FA");
		case "lavenderblush":
			return hexValue("FFF0F5");
		case "lawngreen":
			return hexValue("7CFC00");
		case "lemonchiffon":
			return hexValue("FFFACD");
		case "lightblue":
			return hexValue("ADD8E6");
		case "lightcoral":
			return hexValue("F08080");
		case "lightcyan":
			return hexValue("E0FFFF");
		case "lightgoldenrodyellow":
			return hexValue("FAFAD2");
		case "lightgray":
			return hexValue("D3D3D3");
		case "lightgreen":
			return hexValue("90EE90");
		case "lightpink":
			return hexValue("FFB6C1");
		case "lightsalmon":
			return hexValue("FFA07A");
		case "lightseagreen":
			return hexValue("20B2AA");
		case "lightskyblue":
			return hexValue("87CEFA");
		case "lightslategray":
			return hexValue("778899");
		case "lightsteelblue":
			return hexValue("B0C4DE");
		case "lightyellow":
			return hexValue("FFFFE0");
		case "lime":
			return hexValue("00FF00");
		case "limegreen":
			return hexValue("32CD32");
		case "linen":
			return hexValue("FAF0E6");
		case "magenta":
			return hexValue("FF00FF");
		case "maroon":
			return hexValue("800000");
		case "mediumaquamarine":
			return hexValue("66CDAA");
		case "mediumblue":
			return hexValue("0000CD");
		case "mediumorchid":
			return hexValue("BA55D3");
		case "mediumpurple":
			return hexValue("9370DB");
		case "mediumseagreen":
			return hexValue("3CB371");
		case "mediumslateblue":
			return hexValue("7B68EE");
		case "mediumspringgreen":
			return hexValue("00FA9A");
		case "mediumturquoise":
			return hexValue("48D1CC");
		case "mediumvioletred":
			return hexValue("C71585");
		case "midnightblue":
			return hexValue("191970");
		case "mintcream":
			return hexValue("F5FFFA");
		case "mistyrose":
			return hexValue("FFE4E1");
		case "moccasin":
			return hexValue("FFE4B5");
		case "navajowhite":
			return hexValue("FFDEAD");
		case "navy":
			return hexValue("000080");
		case "oldlace":
			return hexValue("FDF5E6");
		case "olive":
			return hexValue("808000");
		case "olivedrab":
			return hexValue("6B8E23");
		case "orange":
			return hexValue("FFA500");
		case "orangered":
			return hexValue("FF4500");
		case "orchid":
			return hexValue("DA70D6");
		case "palegoldenrod":
			return hexValue("EEE8AA");
		case "palegreen":
			return hexValue("98FB98");
		case "paleturquoise":
			return hexValue("AFEEEE");
		case "palevioletred":
			return hexValue("DB7093");
		case "papayawhip":
			return hexValue("FFEFD5");
		case "peachpuff":
			return hexValue("FFDAB9");
		case "peru":
			return hexValue("CD853F");
		case "pink":
			return hexValue("FFC0CB");
		case "plum":
			return hexValue("DDA0DD");
		case "powderblue":
			return hexValue("B0E0E6");
		case "purple":
			return hexValue("800080");
		case "red":
			return hexValue("FF0000");
		case "rosybrown":
			return hexValue("BC8F8F");
		case "royalblue":
			return hexValue("4169E1");
		case "saddlebrown":
			return hexValue("8B4513");
		case "salmon":
			return hexValue("FA8072");
		case "sandybrown":
			return hexValue("F4A460");
		case "seagreen":
			return hexValue("2E8B57");
		case "seashell":
			return hexValue("FFF5EE");
		case "sienna":
			return hexValue("A0522D");
		case "silver":
			return hexValue("C0C0C0");
		case "skyblue":
			return hexValue("87CEEB");
		case "slateblue":
			return hexValue("6A5ACD");
		case "slategray":
			return hexValue("708090");
		case "snow":
			return hexValue("FFFAFA");
		case "springgreen":
			return hexValue("00FF7F");
		case "steelblue":
			return hexValue("4682B4");
		case "tan":
			return hexValue("D2B48C");
		case "teal":
			return hexValue("008080");
		case "thistle":
			return hexValue("D8BFD8");
		case "tomato":
			return hexValue("FF6347");
		case "turquoise":
			return hexValue("40E0D0");
		case "violet":
			return hexValue("EE82EE");
		case "wheat":
			return hexValue("F5DEB3");
		case "white":
			return hexValue("FFFFFF");
		case "whitesmoke":
			return hexValue("F5F5F5");
		case "yellow":
			return hexValue("FFFF00");
		case "yellowgreen":
			return hexValue("9ACD32");
		default:
			return [];
	}
}