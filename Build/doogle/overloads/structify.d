module doogle.overloads.structify;
public import doogle.overloads.wrappers :
	TextureTargets, SubTextureTargets, BindTextureTarget, // 1.1
	TextureTargets2D, TextureTargets1D, CompressedTextureTargets, CompressedTextureTargets2D, // 1.2
	ShaderTypes, AttribDataTypes, ProgramObjects, ShaderObjects //2.0
	;
import gl3 = derelict.opengl3.gl3;
import doogle.util.color;
import doogle.util.image;

/**
 * OpenGL 1.1
 */

struct TextureObj {
	gl3.GLuint id;

	gl3.GLuint opCast(T : gl3.GLuint)() {
		return id;
	}
}

void glBindTexture(BindTextureTarget target, TextureObj texture) {
	gl3.glBindTexture(cast(gl3.GLenum)target, cast(uint)texture);
}

void glDeleteTextures(TextureObj[] textures) {
	gl3.glDeleteTextures(cast(uint)textures.length, cast(gl3.GLuint*)textures.ptr);
}

void glDeleteTextures(TextureObj texture) {
	gl3.glDeleteTextures(1, cast(gl3.GLuint*)&texture);
}

void glGenTextures(out TextureObj texture) {
	gl3.glGenTextures(1, cast(gl3.GLuint*)&texture);
}

void glGenTextures(gl3.GLsizei n, out TextureObj[] textures) {
	gl3.glGenTextures(n, cast(gl3.GLuint*)textures.ptr);
}

bool glIsTexture(TextureObj texture) {
	return cast(bool)gl3.glIsTexture(cast(gl3.GLuint)texture);
}

/*
 * OpenGL 1.2
 */

void glBlendColor(Color c) {
	gl3.glBlendColor(c.r / 255f, c.g / 255f, c.b / 255f, c.a / 255f);
}

void glTexImage3D(TextureTargets target, gl3.GLint level, RawImage image) {
	gl3.glTexImage3D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, 0, cast(gl3.GLenum)image.format, cast(gl3.GLenum)image.format, cast(void*)image.data.ptr);
}

void glTexSubImage3D(SubTextureTargets target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, RawImage image) {
	gl3.glTexSubImage3D(cast(gl3.GLenum)target, level, xoffset, yoffset, zoffset, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, cast(gl3.GLenum)image.format, cast(gl3.GLenum)image.format, cast(void*)image.data.ptr);
}

/*
 * OpenGL 1.3
 */

void glCompressedTexImage3D(TextureTargets target, gl3.GLint level, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage3D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexImage2D(TextureTargets2D target, gl3.GLint level, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage2D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexImage1D(TextureTargets1D target, gl3.GLint level, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage1D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)image.format, cast(uint)image.width, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage3D(gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage3D(gl3.GL_TEXTURE_3D, level, xoffset, yoffset, zoffset, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, cast(gl3.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage2D(CompressedTextureTargets2D target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage2D(cast(gl3.GLenum)target, level, xoffset, yoffset, cast(uint)image.width, cast(uint)image.height, cast(gl3.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage1D(gl3.GLint level, gl3.GLint xoffset, RawImage image)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage1D(gl3.GL_TEXTURE_1D, level, xoffset, cast(uint)image.width, cast(gl3.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

/**
 * Opengl 1.4
 */

/**
 * Opengl 1.5
 */

/**
 * Opengl 2.0
 */

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

void glAttachShader(ProgramObj program, ShaderObj shader) {
	gl3.glAttachShader(program.id, shader.id);
}

void glBindAttribLocation(ProgramObj program, gl3.GLuint index, string name) {
	gl3.glBindAttribLocation(program.id, index, (name ~ 0).ptr);
}

void glCompileShader(ShaderObj shader) {
	gl3.glCompileShader(shader.id);
}

void glCreateProgram(out ProgramObj ret) {
	ret = ProgramObj(gl3.glCreateProgram());
}

void glCreateShader(ShaderTypes shaderType, out ShaderObj ret) {
	ret = ShaderObj(gl3.glCreateShader(cast(gl3.GLenum)shaderType));
}

void glDeleteProgram(ProgramObj program) {
	gl3.glDeleteProgram(program.id);
}

void glDeleteShader(ShaderObj shader) {
	gl3.glDeleteShader(shader.id);
}

void glDetachShader(ProgramObj program, ShaderObj shader) {
	gl3.glDetachShader(program.id, shader.id);
}

void glGetActiveAttrib(ProgramObj program, gl3.GLuint index, out gl3.GLint* size, out AttribDataTypes type, out string name) {
	gl3.glGetActiveAttrib(program.id, index, int.max,  cast(int*)null, size, cast(gl3.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetActiveUniform(ProgramObj program, gl3.GLuint index, out gl3.GLint size, out AttribDataTypes type, out string name) {
	gl3.glGetActiveUniform(program.id, index, int.max,  cast(int*)null, &size, cast(gl3.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetAttachedShaders(ProgramObj program, out ShaderObj[] shaders) {
	gl3.GLsizei* count;
	gl3.glGetAttachedShaders(program.id, int.max, count, cast(gl3.GLuint*)shaders.ptr);
}

gl3.GLint glGetAttribLocation(ProgramObj program, string name) {
	return gl3.glGetAttribLocation(program.id, (name ~ 0).ptr);
}

void glGetProgramiv(ProgramObj program, ProgramObjects pname, out gl3.GLint[] params) {
	gl3.glGetProgramiv(program.id, cast(gl3.GLenum)pname, params.ptr);
}

void glGetProgramInfoLog(ProgramObj program, out string infoLog) {
	gl3.GLsizei* length;
	gl3.glGetProgramInfoLog(program.id, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderiv(ShaderObj shader, ShaderObjects pname, out gl3.GLint[] params) {
	gl3.glGetShaderiv(shader.id, cast(gl3.GLenum)pname, params.ptr);
}

void glGetShaderInfoLog(ShaderObj shader, string infoLog) {
	gl3.GLsizei* length;
	gl3.glGetShaderInfoLog(shader.id, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderSource(ShaderObj shader, out string source) {
	gl3.GLsizei* length;
	gl3.glGetShaderInfoLog(shader.id, int.max, length, cast(char*)source.ptr);
	source = source[0 .. $-1];
}

gl3.GLint glGetUniformLocation(ProgramObj program, string name) {
	return gl3.glGetUniformLocation(program.id, cast(char*)(name ~ 0).ptr);
}

void glGetUniformfv(ProgramObj program, gl3.GLint location, gl3.GLfloat[] params) {
	gl3.glGetUniformfv(program.id, location, params.ptr);
}

void glGetUniformiv(ProgramObj program, gl3.GLint location, gl3.GLint[] params) {
	gl3.glGetUniformiv(program.id, location, params.ptr);
}

bool glIsProgram(ProgramObj program) {
	return cast(bool)gl3.glIsProgram(program.id);
}

bool glIsShader(ShaderObj shader) {
	return cast(bool)gl3.glIsShader(shader.id);
}

void glLinkProgram(ProgramObj program) {
	gl3.glLinkProgram(program.id);
}

void glShaderSource(ShaderObj shader, string _string) {
	size_t length = _string.length;
	gl3.glShaderSource(shader.id, 1, cast(const(gl3.GLchar*)*)_string.ptr, cast(const(gl3.GLint)*)&length);
}

void glUseProgram(ProgramObj program) {
	gl3.glUseProgram(program.id);
}

void glValidateProgram(ProgramObj program) {
	gl3.glValidateProgram(program.id);
}

/**
 * Opengl 2.1
 */
