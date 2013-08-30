module doogle.overloads.structify;
import gl3 = derelict.opengl3.gl3;
import doogle.util.color;

void glBlendColor(Color c) {
	gl3.glBlendColor(c.r / 255f, c.g / 255f, c.b / 255f, c.a / 255f);
}


struct ProgramObj {
	gl3.GLuint id;

	gl3.GLuint opCast() {
		return id;
	}
}

unittest {
	ProgramObj po = {1};
	assert(cast(gl3.GLuint)po == 1);
}

struct ShaderObj {
	gl3.GLuint id;

	gl3.GLuint opCast() {
		return id;
	}
}

unittest {
	ShaderObj so = {1};
	assert(cast(gl3.GLuint)so == 1);
}