module doogle.math.mat2;
import doogle.math.vec2;

import std.math : cos, sin;
version(unittest) {
	import std.conv : text;
}

struct Mat2 {
	union {
		struct {
			Vec2 vector1;
			Vec2 vector2;
		}
		Vec2[2] vectors;
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

	Mat2 opBinary(string s)(float v) {
		return Mat2(vectors[0].opBinary!(s)(v), vectors[1].opBinary!(s)(v));
	}

	Vec2 opBinary(string s)(Vec2 v) {
		Vec2 temp;
		Vec2 ret;
		temp = vectors[0].opBinary!(s)(v);
		ret.x = temp.x + temp.y;
		temp = vectors[1].opBinary!(s)(v);
		ret.y = temp.x + temp.y;
		return ret;
	}

	Mat2 opBinary(string s)(Mat2 v) {
		return Mat2(vector1.opBinary!(s)(v.vector1), vector2.opBinary!(s)(v.vector2));
	}

	@property {
		float determinant() {
			return
				(values[0] * values[3]) +
				(values[1] * values[2]);
		}

		void identity() {
			(this.values)[] = 0;
			values[0] = 1;
			values[3] = 1;
		}
	}
}

unittest {
	Mat2 mat2;
	mat2[0] = 1;
	mat2[1] = 2;
	mat2[2] = 3;
	mat2[3] = 4;
	
	assert(mat2.vectors[0][0] == 1);
	assert(mat2.vectors[0][1] == 2);
	assert(mat2.vectors[1][0] == 3);
	assert(mat2.vectors[1][1] == 4);
}

unittest {
	Mat2 mat2;
	mat2.identity;

	assert(mat2 == Mat2(Vec2(1f, 0f), Vec2(0f, 1f)));
	assert(mat2.determinant == 1);
}

pure Mat2 tranpose(Mat2 v) {
	return Mat2(
		Vec2(v.values[0], v.values[2]),
		Vec2(v.values[1], v.values[3]));
}

unittest {
	Mat2 mat2 = {Vec2(1f, 2f), Vec2(3f, 4f)};

	assert(mat2.tranpose() == Mat2(Vec2(1f, 3f), Vec2(2f, 4f)));
}

Mat2 inverse(Mat2 v) {
	float determinant = v.determinant;
	return Mat2(
		Vec2(v.values[3] / determinant, -v.values[1] / determinant),
		Vec2(-v.values[2] / determinant, v.values[0] / determinant));
}

unittest {
	Mat2 mat2 = {Vec2(1f, 2f), Vec2(3f, 4f)};
	assert(mat2.inverse().values == [0.4f, -0.2f, -0.3f, 0.1f]);
}

pure Mat2 rotation(Mat2 v, float angle) {
	return Mat2(
		Vec2(cos(angle), -sin(angle)),
		Vec2(sin(angle), cos(angle)))
		* v;
}

unittest {
	Mat2 mat2 = {Vec2(1f, 2f), Vec2(3f, 4f)};
	import std.stdio;
	assert(text(mat2.rotation(180f).values) == "[-0.59846, 1.60231, -2.40346, -2.39384]");
}