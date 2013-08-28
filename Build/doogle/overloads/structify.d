module doogle.overloads.structify;
import gl3 = derelict.opengl3.gl3;

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