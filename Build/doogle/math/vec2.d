module doogle.math.vec2;
import doogle.math.vec3;
import doogle.math.vec4;

import std.math : acos, sqrt;
version(unittest) {
	import std.conv : text;
}

struct Vec2 {
	union {
		struct {
			float x, y;
		}
		float[2] values;
	}
	
	float opIndex(size_t i)
	in {
		assert(i < values.length);
		assert(i >= 0);
	} body {
		return values[i];
	}
	
	void opIndexAssign(float val, size_t i)
	in {
		assert(i < values.length);
		assert(i >= 0);
	} body {
		values[i] = val;
	}

	Vec2 opBinary(string s)(float v) {
		return opBinary!(s)(Vec2(v.x, v.y));
	}
	
	Vec2 opBinary(string s)(Vec2 v) {
		Vec2 ret = {x, y};
		static if (s == "+") {
			ret.x += v.x;
			ret.y += v.y;
		} else static if (s == "-") {
			ret.x -= v.x;
			ret.y -= v.y;
		} else static if (s == "*") {
			ret.x *= v.x;
			ret.y *= v.y;
		} else static if (s == "/") {
			ret.x /= v.x;
			ret.y /= v.y;
		} else {
			static assert(0);
		}
		return ret;
	}

	Vec3 opCast(T : Vec3)() {
		return Vec3(x, y, 0f);
	}

	Vec4 opCast(T : Vec4)() {
		return Vec4(x, y, 0f, 0f);
	}
}

unittest {
	Vec2 vec2;
	vec2.x = 1;
	vec2.y = 2;
	assert(vec2.values == [1f, 2f]);
	
	vec2[0] = 3f;
	vec2[1] = 4f;
	assert(vec2[0] == 3f);
	assert(vec2[1] == 4f);

	assert(typeid(typeof(cast(Vec3)vec2)) == typeid(Vec3));
	assert(typeid(typeof(cast(Vec4)vec2)) == typeid(Vec4));
}

pure float dot(Vec2 v1, Vec2 v2) {
	return (v1.x * v2.x) + (v1.y * v2.y);
}

unittest {
	Vec2 v1 = {1f, 2f};
	Vec2 v2 = {2f, 1f};
	assert(v1.dot(v2) == 4);
}

pure float length(Vec2 v) {
	return sqrt((v.x * v.x) + (v.y * v.y));
}

unittest {
	Vec2 v = {1f, 2f};
	assert(text(v.length()) == "2.23607");
}

pure float lengthSqr(Vec2 v) {
	return (v.x * v.x) + (v.y * v.y);
}

unittest {
	Vec2 v = {1f, 2f};
	assert(v.lengthSqr() == 5);
}

pure float angle(Vec2 v1, Vec2 v2) {
	return acos(v1.dot(v2) / v1.length() / v2.length()); 
}

unittest {
	Vec2 v1 = {1f, 2f};
	Vec2 v2 = {2f, 1f};
	assert(text(v1.angle(v2)) == "0.643501");
}

pure float distance(Vec2 v1, Vec2 v2) {
	Vec2 ret = v1 - v2;
	return ret.length();
}

unittest {
	Vec2 v1 = {1f, 2f};
	Vec2 v2 = {2f, 1f};
	
	assert(text(v1.distance(v2)) == "1.41421");
}

pure Vec2 normal(Vec2 v) {
	float length = v.length();
	return v / Vec2(length, length);
}

unittest {
	Vec2 v = {1f, 2f};
	assert(text(v.normal().values) == "[0.447214, 0.894427]");
}