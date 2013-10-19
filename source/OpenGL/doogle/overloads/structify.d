module doogle.overloads.structify;
public import doogle.overloads.wrappers :
	TextureTargets, SubTextureTargets, BindTextureTarget, // 1.1
	TextureTargets2D, TextureTargets1D, CompressedTextureTargets, CompressedTextureTargets2D, // 1.2
	ShaderTypes, AttribDataTypes, ProgramObjects, ShaderObjects //2.0
	;
import doogle.util.color;
import doogle.util.image;
import doogle.platform;

/*
 * OpenGL 1.0
 */

void glTexImage2D(TextureTargets target, gl.GLint level, shared(Image) image) {
	gl.glTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, 0, cast(gl.GLenum)image.format, cast(gl.GLenum)image.format, cast(void*)image.data.ptr);
}

/**
 * OpenGL 1.1
 */

shared struct TextureObj {
	gl.GLuint id;

	gl.GLuint opCast(T : gl.GLuint)() {
		return id;
	}
}

void glBindTexture(BindTextureTarget target, shared(TextureObj) texture) {
	gl.glBindTexture(cast(gl.GLenum)target, cast(uint)texture);
}

void glDeleteTextures(shared(TextureObj[]) textures) {
	gl.glDeleteTextures(cast(uint)textures.length, cast(gl.GLuint*)textures.ptr);
}

void glDeleteTextures(shared(TextureObj) texture) {
	gl.glDeleteTextures(1, cast(gl.GLuint*)&texture);
}

void glGenTextures(out shared(TextureObj) texture) {
	gl.glGenTextures(1, cast(gl.GLuint*)&texture);
}

void glGenTextures(gl.GLsizei n, out shared(TextureObj[]) textures) {
	gl.glGenTextures(n, cast(gl.GLuint*)textures.ptr);
}

bool glIsTexture(shared(TextureObj) texture) {
	return cast(bool)gl.glIsTexture(cast(gl.GLuint)texture);
}

/*
 * OpenGL 1.2
 */

void glBlendColor(Color c) {
	gl.glBlendColor(c.r / 255f, c.g / 255f, c.b / 255f, c.a / 255f);
}

void glTexImage3D(TextureTargets target, gl.GLint level, shared(Image) image) {
	gl.glTexImage3D(cast(gl.GLenum)target, level, cast(gl.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, 0, cast(gl.GLenum)image.format, cast(gl.GLenum)image.format, cast(void*)image.data.ptr);
}

void glTexSubImage3D(SubTextureTargets target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint zoffset, shared(Image) image) {
	gl.glTexSubImage3D(cast(gl.GLenum)target, level, xoffset, yoffset, zoffset, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, cast(gl.GLenum)image.format, cast(gl.GLenum)image.format, cast(void*)image.data.ptr);
}

/*
 * OpenGL 1.3
 */

void glCompressedTexImage3D(TextureTargets target, gl.GLint level, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage3D(cast(gl.GLenum)target, level, cast(gl.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexImage2D(TextureTargets2D target, gl.GLint level, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)image.format, cast(uint)image.width, cast(uint)image.height, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexImage1D(TextureTargets1D target, gl.GLint level, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage1D(cast(gl.GLenum)target, level, cast(gl.GLenum)image.format, cast(uint)image.width, 0, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage3D(gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint zoffset, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage3D(gl.GL_TEXTURE_3D, level, xoffset, yoffset, zoffset, cast(uint)image.width, cast(uint)image.height, cast(uint)image.depth, cast(gl.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage2D(CompressedTextureTargets2D target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage2D(cast(gl.GLenum)target, level, xoffset, yoffset, cast(uint)image.width, cast(uint)image.height, cast(gl.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
}

void glCompressedTexSubImage1D(gl.GLint level, gl.GLint xoffset, shared(Image) image)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage1D(gl.GL_TEXTURE_1D, level, xoffset, cast(uint)image.width, cast(gl.GLenum)image.format, cast(uint)image.data.length, cast(void*)image.data.ptr);
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

shared struct ProgramObj {
	gl.GLuint id;

	gl.GLuint opCast(T:gl.GLuint)() {
		return id;
	}
}

unittest {
	ProgramObj po = {1};
	assert(cast(gl.GLuint)po == 1);
}

shared struct ShaderObj {
	gl.GLuint id;

	gl.GLuint opCast(T:gl.GLuint)() {
		return id;
	}
}

unittest {
	ShaderObj so = {1};
	assert(cast(gl.GLuint)so == 1);
}

void glAttachShader(ProgramObj program, ShaderObj shader) {
	gl.glAttachShader(program.id, shader.id);
}

void glBindAttribLocation(ProgramObj program, gl.GLuint index, string name) {
	gl.glBindAttribLocation(program.id, index, (name ~ 0).ptr);
}

void glCompileShader(ShaderObj shader) {
	gl.glCompileShader(shader.id);
}

void glCreateProgram(out ProgramObj ret) {
	ret = ProgramObj(gl.glCreateProgram());
}

ShaderObj glCreateShader(ShaderTypes shaderType) {
	return ShaderObj(gl.glCreateShader(cast(gl.GLenum)shaderType));
}

void glDeleteProgram(ProgramObj program) {
	gl.glDeleteProgram(program.id);
}

void glDeleteShader(ShaderObj shader) {
	gl.glDeleteShader(shader.id);
}

void glDetachShader(ProgramObj program, ShaderObj shader) {
	gl.glDetachShader(program.id, shader.id);
}

void glGetActiveAttrib(ProgramObj program, gl.GLuint index, out gl.GLint* size, out AttribDataTypes type, out string name) {
	gl.glGetActiveAttrib(program.id, index, int.max,  cast(int*)null, size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetActiveUniform(ProgramObj program, gl.GLuint index, out gl.GLint size, out AttribDataTypes type, out string name) {
	gl.glGetActiveUniform(program.id, index, int.max,  cast(int*)null, &size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetAttachedShaders(ProgramObj program, out ShaderObj[] shaders) {
	gl.GLsizei* count;
	gl.glGetAttachedShaders(program.id, int.max, count, cast(gl.GLuint*)shaders.ptr);
}

gl.GLint glGetAttribLocation(ProgramObj program, string name) {
	return gl.glGetAttribLocation(program.id, (name ~ 0).ptr);
}

void glGetProgramiv(ProgramObj program, ProgramObjects pname, out gl.GLint[] params) {
	gl.glGetProgramiv(program.id, cast(gl.GLenum)pname, params.ptr);
}

void glGetProgramInfoLog(ProgramObj program, out string infoLog) {
	gl.GLsizei* length;
	gl.glGetProgramInfoLog(program.id, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderiv(ShaderObj shader, ShaderObjects pname, out gl.GLint[] params) {
	gl.glGetShaderiv(shader.id, cast(gl.GLenum)pname, params.ptr);
}

void glGetShaderInfoLog(ShaderObj shader, string infoLog) {
	gl.GLsizei* length;
	gl.glGetShaderInfoLog(shader.id, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderSource(ShaderObj shader, out string source) {
	gl.GLsizei* length;
	gl.glGetShaderInfoLog(shader.id, int.max, length, cast(char*)source.ptr);
	source = source[0 .. $-1];
}

gl.GLint glGetUniformLocation(ProgramObj program, string name) {
	return gl.glGetUniformLocation(program.id, cast(char*)(name ~ 0).ptr);
}

void glGetUniformfv(ProgramObj program, gl.GLint location, gl.GLfloat[] params) {
	gl.glGetUniformfv(program.id, location, params.ptr);
}

void glGetUniformiv(ProgramObj program, gl.GLint location, gl.GLint[] params) {
	gl.glGetUniformiv(program.id, location, params.ptr);
}

bool glIsProgram(ProgramObj program) {
	return cast(bool)gl.glIsProgram(program.id);
}

bool glIsShader(ShaderObj shader) {
	return cast(bool)gl.glIsShader(shader.id);
}

void glLinkProgram(ProgramObj program) {
	gl.glLinkProgram(program.id);
}

void glShaderSource(ShaderObj shader, string _string) {
	size_t length = _string.length;
	gl.glShaderSource(shader.id, 1, cast(const(gl.GLchar*)*)_string.ptr, cast(const(gl.GLint)*)&length);
}

void glUseProgram(ProgramObj program) {
	gl.glUseProgram(program.id);
}

void glValidateProgram(ProgramObj program) {
	gl.glValidateProgram(program.id);
}

/**
 * Opengl 2.1
 */
