module doogle.math.vec4;
import doogle.math.vec2;
import doogle.math.vec3;

import std.math : acos, sqrt;
version(unittest) {
	import std.conv : text;
}

struct Vec4 {
	union {
		struct {
			float x, y, z, w;
		}
		float[4] values;
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

	Vec4 opBinary(string s)(float v) {
		return opBinary!(s)(Vec4(v, v, v, v));
	}

	Vec4 opBinary(string s)(Vec4 v) {
		Vec4 ret = {x, y, z, w};
		static if (s == "+") {
			ret.x += v.x;
			ret.y += v.y;
			ret.z += v.z;
			ret.w += v.w;
		} else static if (s == "-") {
			ret.x -= v.x;
			ret.y -= v.y;
			ret.z -= v.z;
			ret.w -= v.w;
		} else static if (s == "*") {
			ret.x *= v.x;
			ret.y *= v.y;
			ret.z *= v.z;
			ret.w *= v.w;
		} else static if (s == "/") {
			ret.x /= v.x;
			ret.y /= v.y;
			ret.z /= v.z;
			ret.w /= v.w;
		} else {
			static assert(0);
		}
		return ret;
	}

	Vec2 opCast(T : Vec2)() {
		return Vec2(x, y);
	}
	
	Vec3 opCast(T : Vec3)() {
		return Vec3(x, y, z);
	}
}

unittest {
	Vec4 vec4;
	vec4.x = 1;
	vec4.y = 2;
	vec4.z = 3;
	vec4.w = 4;
	assert(vec4.values == [1f, 2f, 3f, 4f]);
	
	vec4[0] = 5f;
	vec4[1] = 6f;
	vec4[2] = 7f;
	vec4[3] = 8f;
	assert(vec4[0] == 5f);
	assert(vec4[1] == 6f);
	assert(vec4[2] == 7f);
	assert(vec4[3] == 8f);
}