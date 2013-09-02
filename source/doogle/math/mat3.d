module doogle.math.mat3;
import doogle.math.vec2;
import doogle.math.vec3;

import std.math : cos, sin;
version(unittest) {
	import std.conv : text;
}

struct Mat3 {
	union {
		struct {
			Vec3 vector1;
			Vec3 vector2;
			Vec3 vector3;
		}
		Vec3[3] vectors;
		float[9] values;
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
	
	Mat3 opBinary(string s)(float v) {
		return Mat3(vectors[0].opBinary!(s)(v), vectors[1].opBinary!(s)(v), vectors[2].opBinary!(s)(v));
	}
	
	Vec3 opBinary(string s)(Vec3 v) {
		Vec3 temp;
		Vec3 ret;
		temp = vectors[0].opBinary!(s)(v);
		ret.x = temp.x + temp.y + temp.z;
		temp = vectors[1].opBinary!(s)(v);
		ret.y = temp.x + temp.y + temp.z;
		temp = vectors[2].opBinary!(s)(v);
		ret.z = temp.x + temp.y + temp.z;
		return ret;
	}
	
	Mat3 opBinary(string s)(Mat3 v) {
		return Mat3(vector1.opBinary!(s)(v.vector1), vector2.opBinary!(s)(v.vector2), vector3.opBinary!(s)(v.vector3));
	}

	@property {
		float determinant() {
			return
				(values[0] * ((values[8] * values[4]) - (values[5] * values[7]))) +
				(values[1] * (-(values[8] * values[3]) + (values[5] * values[6]))) +
				(values[2] * ((values[7] * values[3]) - (values[4] * values[6])));
		}
		
		void identity() {
			(this.values)[] = 0;
			values[0] = 1;
			values[4] = 1;
			values[8] = 1;
		}
	}
}

unittest {
	Mat3 mat3;
	mat3[0] = 1;
	mat3[1] = 2;
	mat3[2] = 3;
	mat3[3] = 4;
	mat3[4] = 5;
	mat3[5] = 6;
	mat3[6] = 7;
	mat3[7] = 8;
	mat3[8] = 9;
	
	assert(mat3.vectors[0][0] == 1);
	assert(mat3.vectors[0][1] == 2);
	assert(mat3.vectors[0][2] == 3);
	assert(mat3.vectors[1][0] == 4);
	assert(mat3.vectors[1][1] == 5);
	assert(mat3.vectors[1][2] == 6);
	assert(mat3.vectors[2][0] == 7);
	assert(mat3.vectors[2][1] == 8);
	assert(mat3.vectors[2][2] == 9);
}

unittest {
	Mat3 mat3;
	mat3.identity;
	
	assert(mat3 == Mat3(Vec3(1f, 0f, 0f), Vec3(0f, 1f, 0f), Vec3(0f, 0f, 1f)));
	assert(mat3.determinant == 1);
}

pure Mat3 translate(Mat3 m, Vec2 v) {
	return Mat3(
		Vec3(1, 0, v.x),
		Vec3(0, 1, v.y),
		Vec3(0, 0, 1))
		* m;
}

unittest {
	Mat3 m = {Vec3(1, 2, 3), Vec3(4, 5, 6), Vec3(7, 8, 9)};
	Vec2 v = {1, 2};
	assert(m.translate(v).values == [1, 0, 3, 0, 5, 12, 0, 0, 9]);
}

pure Mat3 scale(Mat3 m, Vec2 v) {
	return Mat3(
		Vec3(v.x, 0, 0),
		Vec3(0, v.y, 0),
		Vec3(0, 0, 1)) * m;
}

unittest {
	Mat3 m = {Vec3(1, 2, 3), Vec3(4, 5, 6), Vec3(7, 8, 9)};
	Vec2 v = {1, 2};
	assert(m.scale(v).values == [1, 0, 0, 0, 10, 0, 0, 0, 9]);
}

Mat3 tranpose(Mat3 v) {
	return Mat3(
		Vec3(v[0], v[3], v[6]),
		Vec3(v[1], v[4], v[7]),
		Vec3(v[2], v[5], v[8]));
}

unittest {
	Mat3 m = {Vec3(1, 2, 3), Vec3(4, 5, 6), Vec3(7, 8, 9)};
	assert(m.tranpose().values == [1, 4, 7, 2, 5, 8, 3, 6, 9]);
}

Mat3 inverse(Mat3 v) {
	float determinant = v.determinant;
	return Mat3(
		Vec3(
			((v[8] * v[4]) - (v[5] * v[7])) / determinant,
			((-v[8] * v[1]) + (v[2] * v[7])) / determinant,
			((v[5] * v[1]) - (v[2] * v[4])) / determinant,
		),
		Vec3(
			((-v[8] * v[3]) + (v[5] * v[6])) / determinant,
			((v[8] * v[0]) - (v[2] * v[6])) / determinant,
			((-v[5] * v[0]) + (v[2] * v[3])) / determinant,
		),
		Vec3(
			((v[7] * v[3]) - (v[4] * v[6])) / determinant,
			((-v[7] * v[0]) + (v[1] * v[6])) / determinant,
			((v[4] * v[0]) - (v[1] * v[3])) / determinant,
		));
}

unittest {
	Mat3 m = {Vec3(9, 8, 7), Vec3(6, 5, 6), Vec3(7, 8, 9)};
	assert(text(m.inverse().values) == "[0.09375, 0.5, -0.40625, 0.375, -1, 0.375, -0.40625, 0.5, 0.09375]");
}

Mat3 rotation(Mat3 v, float angle) {
	return Mat3(
		Vec3(cos(angle), -sin(angle), 0),
		Vec3(sin(angle), cos(angle), 0),
		Vec3(0, 0, 1))
		* v;
}

unittest {
	Mat3 m = Mat3(Vec3(1f, 2f, 3f), Vec3(4f, 5f, 6f), Vec3(7f, 8f, 9f));
	assert(text(m.rotation(180).values) == "[-0.59846, 1.60231, 0, -3.20461, -2.9923, 0, 0, 0, 9]");
}