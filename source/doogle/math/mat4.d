module doogle.math.mat4;
import doogle.math.vec3;
import doogle.math.vec4;

import std.math : cos, sin;
version(unittest) {
	import std.conv : text;
}

struct Mat4 {
	union {
		struct {
			Vec4 vector1;
			Vec4 vector2;
			Vec4 vector3;
			Vec4 vector4;
		}
		Vec4[4] vectors;
		float[16] values;
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

	Mat4 opBinary(string s)(float v) {
		return Mat4(vectors[0].opBinary!(s)(v), vectors[1].opBinary!(s)(v), vectors[2].opBinary!(s)(v), vectors[3].opBinary!(s)(v));
	}
	
	Vec4 opBinary(string s)(Vec4 v) {
		Vec4 temp;
		Vec4 ret;
		temp = vectors[0].opBinary!(s)(v);
		ret.x = temp.x + temp.y + temp.z + temp.w;
		temp = vectors[1].opBinary!(s)(v);
		ret.y = temp.x + temp.y + temp.z + temp.w;
		temp = vectors[2].opBinary!(s)(v);
		ret.z = temp.x + temp.y + temp.z + temp.w;
		temp = vectors[3].opBinary!(s)(v);
		ret.w = temp.x + temp.y + temp.z + temp.w;
		return ret;
	}
	
	Mat4 opBinary(string s)(Mat4 v) {
		return Mat4(vector1.opBinary!(s)(v.vector1), vector2.opBinary!(s)(v.vector2), vector3.opBinary!(s)(v.vector3), vector4.opBinary!(s)(v.vector4));
	}

	@property {
		float determinant() {
			return 
				(values[03] * values[6] * values[9] * values[12]) - (values[02] * values[7] * values[9] * values[12]) -
				(values[03] * values[5] * values[10] * values[12]) + (values[01] * values[7] * values[10] * values[12]) +
				(values[02] * values[5] * values[11] * values[12]) - (values[01] * values[6] * values[11] * values[12]) -
				(values[03] * values[6] * values[8] * values[13]) + (values[02] * values[7] * values[8] * values[13]) +
				(values[03] * values[4] * values[10] * values[13]) - (values[00] * values[7] * values[10] * values[13]) -
				(values[02] * values[4] * values[11] * values[13]) + (values[00] * values[6] * values[11] * values[13]) +
				(values[03] * values[5] * values[8] * values[14]) - (values[01] * values[7] * values[8] * values[14]) -
				(values[03] * values[4] * values[9] * values[14]) + (values[00] * values[7] * values[9] * values[14]) +
				(values[01] * values[4] * values[11] * values[14]) - (values[00] * values[5] * values[11] * values[14]) -
				(values[02] * values[5] * values[8] * values[15]) + (values[01] * values[6] * values[8] * values[15]) +
				(values[02] * values[4] * values[9] * values[15]) - (values[00] * values[6] * values[9] * values[15]) -
				(values[01] * values[4] * values[10] * values[15]) + (values[00] * values[5] * values[10] * values[15]);
		}
		
		void identity() {
			(this.values)[] = 0;
			values[0] = 1;
			values[5] = 1;
			values[11] = 1;
			values[15] = 1;
		}
	}
}

unittest {
	Mat4 mat4;
	mat4[0] = 1;
	mat4[1] = 2;
	mat4[2] = 3;
	mat4[3] = 4;
	mat4[4] = 5;
	mat4[5] = 6;
	mat4[6] = 7;
	mat4[7] = 8;
	mat4[8] = 9;
	mat4[9] = 10;
	mat4[10] = 11;
	mat4[11] = 12;
	mat4[12] = 13;
	mat4[13] = 14;
	mat4[14] = 15;
	mat4[15] = 16;
	
	assert(mat4.vectors[0][0] == 1);
	assert(mat4.vectors[0][1] == 2);
	assert(mat4.vectors[0][2] == 3);
	assert(mat4.vectors[0][3] == 4);
	assert(mat4.vectors[1][0] == 5);
	assert(mat4.vectors[1][1] == 6);
	assert(mat4.vectors[1][2] == 7);
	assert(mat4.vectors[1][3] == 8);
	assert(mat4.vectors[2][0] == 9);
	assert(mat4.vectors[2][1] == 10);
	assert(mat4.vectors[2][2] == 11);
	assert(mat4.vectors[2][3] == 12);
	assert(mat4.vectors[3][0] == 13);
	assert(mat4.vectors[3][1] == 14);
	assert(mat4.vectors[3][2] == 15);
	assert(mat4.vectors[3][3] == 16);
}

unittest {
	Mat4 m = {Vec4(10f, 9f, 8f, 7f), Vec4(6f, 5f, 10f, 3f), Vec4(6f, 7f, 8f, 9f), Vec4(10f, 11f, 12f, 23f)};
	assert(m.determinant == -960);
}

pure Mat4 translate(Mat4 m, Vec3 v) {
	return Mat4(Vec4(1, 0, 0, v.x),
	            Vec4(0, 1, 0, v.y),
	            Vec4(0, 0, 1, v.z),
	            Vec4(0, 0, 0, 1)) * m;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	Vec3 v = {1f, 2f, 3f};

	assert(m.translate(v).values == [1, 0, 0, 4, 0, 6, 0, 16, 0, 0, 11, 36, 0, 0, 0, 16]);
}

pure Mat4 scale(Mat4 m, Vec3 v) {
	return Mat4(Vec4(v.x, 0, 0, 0),
	            Vec4(0, v.y, 0, 0),
	            Vec4(0, 0, v.z, 0),
	            Vec4(0, 0, 0, 1)) * m;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	Vec3 v = {1f, 2f, 3f};

	assert(m.scale(v).values == [1, 0, 0, 0, 0, 12, 0, 0, 0, 0, 33, 0, 0, 0, 0, 16]);
}

pure Mat4 rotateX(Mat4 v, float angle) {
	return Mat4(
		Vec4(1, 0, 0, 0),
		Vec4(0, cos(angle), -sin(angle), 0),
		Vec4(0, sin(angle), cos(angle), 0),
		Vec4(0, 0, 0, 1)) * v;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	assert(text(m.rotateX(20).values) == "[1, 0, 0, 0, 0, 2.44849, -6.39062, 0, 0, 9.12945, 4.4889, 0, 0, 0, 0, 16]");
}

pure Mat4 rotateY(Mat4 v, float angle) {
	return Mat4(
		Vec4(cos(angle), 0, sin(angle), 0),
		Vec4(0, 1, 0, 0),
		Vec4(-sin(angle), 0, cos(angle), 0),
		Vec4(0, 0, 0, 1)) * v;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	assert(text(m.rotateY(20).values) == "[0.408082, 0, 2.73884, 0, 0, 6, 0, 0, -8.21651, 0, 4.4889, 0, 0, 0, 0, 16]");
}

pure Mat4 rotateZ(Mat4 v, float angle) {
	return Mat4(
		Vec4(cos(angle), -sin(angle), 0, 0),
		Vec4(sin(angle), cos(angle), 0, 0),
		Vec4(0, 0, 1, 0),
		Vec4(0, 0, 0, 1)) * v;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	assert(text(m.rotateZ(20).values) == "[0.408082, -1.82589, 0, 0, 4.56473, 2.44849, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16]");
}

pure Mat4 rotate(Mat4 m, Vec3 axis, float angle) {
	float s = sin(angle);
	float c = cos(angle);
	float t = 1 - c;
	Vec3 a = axis.normal();

	with(a)
		return Mat4(
			Vec4(x * x * t + c, x * y * t - z * s, x * z * t + y * s, 0),
			Vec4(y * x * t + z * s, y * y * t + c, y * z * t - x * s, 0),
			Vec4(z * x * t - y * s, z * y * t * x * s, z * z * t + c, 0),
			Vec4(0, 0, 0, 1)
			) * m;
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	Vec3 axis = Vec3(1, 1, 1);

	assert(text(m.rotate(axis, 20).values) == "[0.605388, -0.659566, 2.17319, 0, 3.62198, 3.63233, -2.30848, 0, -2.96805, 1.03998, 6.65927, 0, 0, 0, 0, 16]");
}

Mat4 tranpose(Mat4 v) {
	return Mat4(
		Vec4(v[0], v[4], v[8], v[12]),
		Vec4(v[1], v[5], v[9], v[13]),
		Vec4(v[2], v[6], v[10], v[14]),
		Vec4(v[3], v[7], v[11], v[15]));
}

unittest {
	Mat4 m = {Vec4(1f, 2f, 3f, 4f), Vec4(5f, 6f, 7f, 8f), Vec4(9f, 10f, 11f, 12f), Vec4(13f, 14f, 15f, 16f)};
	assert(m.tranpose().values == [
		1, 5, 9, 13,
		2, 6, 10, 14,
		3, 7, 11, 15,
		4, 8, 12, 16]);
}

Mat4 inverse(Mat4 v) {
	with(v) {
		float det = determinant;
		Mat4 ret;

		float t0 = values[0] * values[5] - values[1] * values[4];
		float t1 = values[0] * values[6] - values[2] * values[4];
		float t2 = values[0] * values[7] - values[3] * values[4];
		float t3 = values[1] * values[6] - values[2] * values[5];
		float t4 = values[1] * values[7] - values[3] * values[5];
		float t5 = values[2] * values[7] - values[3] * values[6];
		float t6 = values[8] * values[13] - values[9] * values[12];
		float t7 = values[8] * values[14] - values[10] * values[12];
		float t8 = values[8] * values[15] - values[11] * values[12];
		float t9 = values[9] * values[14] - values[10] * values[13];
		float t10 = values[9] * values[15] - values[11] * values[13];
		float t11 = values[10] * values[15] - values[11] * values[14];
		
		ret = Mat4(
			Vec4((values[5] * t11 - values[6] * t10 + values[7] * t9) / det,
		         (-values[1] * t11 + values[2] * t10 - values[3] * t9) / det,
		         (values[13] * t5 - values[14] * t4 + values[15] * t3) / det,
		         (-values[9] * t5 + values[10] * t4 - values[11] * t3) / det),
		    Vec4((-values[4] * t11 + values[6] * t8 - values[7] * t7) / det,
		         (values[0] * t11 - values[2] * t8 + values[3] * t7) / det,
		         (-values[12] * t5 + values[14] * t2 - values[15] * t1) / det,
		         (values[8] * t5 - values[10] * t2 + values[11] * t1) / det),
		    Vec4((values[4] * t10 - values[5] * t8 + values[7] * t6) / det,
		         (-values[0] * t10 + values[1] * t8 - values[3] * t6) / det,
		         (values[12] * t4 - values[13] * t2 + values[15] * t0) / det,
		         (-values[8] * t4 + values[9] * t2 - values[11] * t0) / det),
		    Vec4((-values[4] * t9 + values[5] * t7 - values[6] * t6) / det,
		         (values[0] * t9 - values[1] * t7 + values[2] * t6) / det,
		         (-values[12] * t3 + values[13] * t1 - values[14] * t0) / det,
		         (values[8] * t3 - values[9] * t1 + values[10] * t0 ) / det));
		return ret;
	}
}

unittest {
	Mat4 mat = Mat4(Vec4(10f, 9f, 8f, 7f), Vec4(6f, 5f, 10f, 3f), Vec4(6f, 7f, 8f, 9f), Vec4(10f, 11f, 12f, 23f));
	
	//assert(text(mat.inverse().values) == "[0.2625, 0.166667, -0.770833, 0.2, -0.05, -0.333333, 0.916667, -0.3, -0.125, 0.166667, 0.0416667, -0, -0.025, -0, -0.125, 0.1]");
}