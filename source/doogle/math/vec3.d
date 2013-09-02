module doogle.math.vec3;
import doogle.math.vec2;
import doogle.math.vec4;

import std.math : acos, sqrt;
version(unittest) {
	import std.conv : text;
}

struct Vec3 {
	union {
		struct {
			float x, y, z;
		}
		float[3] values;
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

	Vec3 opBinary(string s)(float v) {
		return opBinary!(s)(Vec3(v, v, v));
	}

	Vec3 opBinary(string s)(Vec3 v) {
		Vec3 ret = {x, y, z};
		static if (s == "+") {
			ret.x += v.x;
			ret.y += v.y;
			ret.z += v.z;
		} else static if (s == "-") {
			ret.x -= v.x;
			ret.y -= v.y;
			ret.z -= v.z;
		} else static if (s == "*") {
			ret.x *= v.x;
			ret.y *= v.y;
			ret.z *= v.z;
		} else static if (s == "/") {
			ret.x /= v.x;
			ret.y /= v.y;
			ret.z /= v.z;
		} else {
			static assert(0);
		}
		return ret;
	}

	Vec2 opCast(T : Vec2)() {
		return Vec2(x, y);
	}
	
	Vec4 opCast(T : Vec4)() {
		return Vec4(x, y, z, 0f);
	}
}

unittest {
	Vec3 vec3;
	vec3.x = 1;
	vec3.y = 2;
	vec3.z = 3;
	assert(vec3.values == [1f, 2f, 3f]);
	
	vec3[0] = 4f;
	vec3[1] = 5f;
	vec3[2] = 6f;
	assert(vec3[0] == 4f);
	assert(vec3[1] == 5f);
	assert(vec3[2] == 6f);
}

pure Vec3 cross(Vec3 v1, Vec3 v2) {
	return Vec3(
		(v1.y * v2.z) - (v1.z * v2.y),
		(v1.z * v2.x) - (v1.x * v2.z),
		(v1.x * v2.y) - (v1.y * v2.x));
}

unittest {
	Vec3 v1 = {1f, 2f, 3f};
	Vec3 v2 = {3f, 2f, 1f};
	assert(v1.cross(v2) == Vec3(-4f, 8f, -4f));
}

pure float dot(Vec3 v1, Vec3 v2) {
	return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
}

unittest {
	Vec3 v1 = {1f, 2f, 3f};
	Vec3 v2 = {3f, 2f, 1f};
	assert(v1.dot(v2) == 10);
}

pure float length(Vec3 v) {
	return sqrt((v.x * v.x) + (v.y * v.y) + (v.z * v.z));
}

unittest {
	Vec3 v = {1f, 2f, 3f};
	assert(text(v.length()) == "3.74166");
}

pure float lengthSqr(Vec3 v) {
	return (v.x * v.x) + (v.y * v.y) + (v.z * v.z);
}

unittest {
	Vec3 v = {1f, 2f, 3f};
	assert(v.lengthSqr() == 14);
}

float angle(Vec3 v1, Vec3 v2) {
	return acos(v1.dot(v2) / v1.length() / v2.length()); 
}

unittest {
	Vec3 v1 = {1f, 2f, 1f};
	Vec3 v2 = {1f, 2f, 1f};
	//assert(text(v1.angle(v2)) == "0");
}

pure float distance(Vec3 v1, Vec3 v2) {
	Vec3 ret = v1 - v2;
	return ret.length();
}

unittest {
	Vec3 v1 = {1f, 2f, 3f};
	Vec3 v2 = {3f, 2f, 1f};
	
	assert(text(v1.distance(v2)) == "2.82843");
}

pure Vec3 normal(Vec3 v) {
	float length = v.length();
	return v / Vec3(length, length, length);
}

unittest {
	Vec3 v = {1f, 2f, 3f};
	assert(text(v.normal().values) == "[0.267261, 0.534522, 0.801784]");
}
