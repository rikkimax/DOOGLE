module doogle.overloads;
import doogle.util.color;
import gl3 = derelict.opengl3.gl3;

/*
 * OpenGL 1.2
 */

enum BlendMode {
	FuncAdd = gl3.GL_FUNC_ADD,
	FuncSubtract = gl3.GL_FUNC_SUBTRACT,
	FuncReverseSubtract = gl3.GL_FUNC_REVERSE_SUBTRACT,
	Min = gl3.GL_MIN,
	Max = gl3.GL_MAX
}

enum Primitives {
	Points = gl3.GL_POINTS,
	LineStrip = gl3.GL_LINE_STRIP,
	LineLoop = gl3.GL_LINE_LOOP,
	Lines = gl3.GL_LINES,
	LineStripAdjacency = gl3.GL_LINE_STRIP_ADJACENCY,
	LinesAdjacency = gl3.GL_LINES_ADJACENCY,
	TriangleStrip = gl3.GL_TRIANGLE_STRIP,
	TriangleFan = gl3.GL_TRIANGLE_FAN,
	Triangles = gl3.GL_TRIANGLES,
	TriangleStripAdjacency = gl3.GL_TRIANGLE_STRIP_ADJACENCY,
	TrianglesAdjacency = gl3.GL_TRIANGLES_ADJACENCY,
	Patches = gl3.GL_PATCHES
}

enum TextureTargets {
	Texture3D = gl3.GL_TEXTURE_3D,
	ProxyTexture3D = gl3.GL_PROXY_TEXTURE_3D,
	Texture2DArray = gl3.GL_TEXTURE_2D_ARRAY,
	ProxyTexture2DArray = gl3.GL_PROXY_TEXTURE_2D_ARRAY
}

enum SubTextureTargets {
	Texture3D = gl3.GL_TEXTURE_3D,
	Texture2DArray = gl3.GL_TEXTURE_2D_ARRAY,
}

enum InternalFormat {
	DepthComponent = gl3.GL_DEPTH_COMPONENT,
	DepthStencil = gl3.GL_DEPTH_STENCIL,
	Red = gl3.GL_RED,
	RG = gl3.GL_RG,
	RGB = gl3.GL_RGB,
	RGBA = gl3.GL_RGBA
}

enum PixelFormat {
	Red = gl3.GL_RED,
	RG = gl3.GL_RG,
	RGB = gl3.GL_RGB,
	BGR = gl3.GL_BGR,
	RGBA = gl3.GL_RGBA,
	BGRA = gl3.GL_BGRA,
	RedInteger = gl3.GL_RED_INTEGER,
	RG_Integer = gl3.GL_RG_INTEGER,
	RGB_Integer = gl3.GL_RGB_INTEGER,
	BGR_Integer = gl3.GL_BGR_INTEGER,
	RGBA_Integer = gl3.GL_RGBA_INTEGER,
	BGRA_Integer = gl3.GL_BGRA_INTEGER,
	StencilIndex = gl3.GL_STENCIL_INDEX,
	DepthComponent = gl3.GL_DEPTH_COMPONENT,
	DepthStencil = gl3.GL_DEPTH_STENCIL
}

enum PixelSubTextureFormat {
	Red = gl3.GL_RED,
	RG = gl3.GL_RG,
	RGB = gl3.GL_RGB,
	BGR = gl3.GL_BGR,
	RGBA = gl3.GL_RGBA,
	StencilIndex = gl3.GL_STENCIL_INDEX,
	DepthComponent = gl3.GL_DEPTH_COMPONENT
}

enum PixelDataType {
	UByte = gl3.GL_UNSIGNED_BYTE,
	Byte = gl3.GL_BYTE,
	UShort = gl3.GL_UNSIGNED_SHORT,
	Short = gl3.GL_SHORT,
	UInt = gl3.GL_UNSIGNED_INT,
	Int = gl3.GL_INT,
	Float = gl3.GL_FLOAT,
	UByte332 = gl3.GL_UNSIGNED_BYTE_3_3_2,
	UByte233Rev = gl3.GL_UNSIGNED_BYTE_2_3_3_REV,
	UShort565 = gl3.GL_UNSIGNED_SHORT_5_6_5,
	UShort565Rev = gl3.GL_UNSIGNED_SHORT_5_6_5,
	UShort4444 = gl3.GL_UNSIGNED_SHORT_4_4_4_4,
	UShort4444Rev = gl3.GL_UNSIGNED_SHORT_4_4_4_4_REV,
	UShort5551 = gl3.GL_UNSIGNED_SHORT_5_5_5_1,
	UShort1555Rev = gl3.GL_UNSIGNED_SHORT_1_5_5_5_REV,
	UInt8888 = gl3.GL_UNSIGNED_INT_8_8_8_8,
	UInt8888Rev = gl3.GL_UNSIGNED_INT_8_8_8_8_REV,
	UInt101010102 = gl3.GL_UNSIGNED_INT_10_10_10_2,
	UINT2101010REV = gl3.GL_UNSIGNED_INT_2_10_10_10_REV
}

void glBlendColor(Color c) {
	gl3.glBlendColor(c.r / 255f, c.g / 255f, c.b / 255f, c.a / 255f);
}

void glBlendEquation(BlendMode mode) {
	gl3.glBlendEquation(cast(gl3.GLenum)mode);
}

void glBlendEquationi(gl3.GLuint buf, BlendMode mode) {
	gl3.glBlendEquationi(buf, cast(gl3.GLenum)mode);
}

void glDrawRangeElements(Primitives mode, gl3.GLuint start, gl3.GLuint end, ubyte[] data) {
	gl3.glDrawRangeElements(cast(gl3.GLenum)mode, start, end, cast(uint)data.length, gl3.GL_UNSIGNED_BYTE, data.ptr);
}

void glDrawRangeElements(Primitives mode, gl3.GLuint start, gl3.GLuint end, ushort[] data) {
	gl3.glDrawRangeElements(cast(gl3.GLenum)mode, start, end, cast(uint)data.length, gl3.GL_UNSIGNED_SHORT, data.ptr);
}

void glDrawRangeElements(Primitives mode, gl3.GLuint start, gl3.GLuint end, uint[] data) {
	gl3.glDrawRangeElements(cast(gl3.GLenum)mode, start, end, cast(uint)data.length, gl3.GL_UNSIGNED_INT, data.ptr);
}

void glTexImage3D(TextureTargets target, gl3.GLint level, InternalFormat internalFormat, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, PixelFormat format, PixelDataType type, void* data) {
	gl3.glTexImage3D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, width, height, depth, 0, cast(gl3.GLenum)format, cast(gl3.GLenum)type, data);
}

void glTexSubImage3D(SubTextureTargets target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, PixelSubTextureFormat format, PixelDataType type, void* data) {
	gl3.glTexSubImage3D(cast(gl3.GLenum)target, level, xoffset, yoffset, zoffset, width, height, depth, cast(gl3.GLenum)format, cast(gl3.GLenum)type, data);
}

void glCopyTexSubImage3D(SubTextureTargets target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, gl3.GLint x, gl3.GLint y, gl3.GLsizei width, gl3.GLsizei height) {
	gl3.glCopyTexSubImage3D(cast(gl3.GLenum)target, level, xoffset, yoffset, zoffset, x, y, width, height);
}

/*
 * OpenGL 1.3
 */

enum TextureTargets2D {
	Texture2D = gl3.GL_TEXTURE_2D,
	ProxyTexture2D = gl3.GL_PROXY_TEXTURE_2D,
	Texture1DArray = gl3.GL_TEXTURE_1D_ARRAY,
	ProxyTexture1DArray = gl3.GL_PROXY_TEXTURE_1D_ARRAY,
	TextureCubeMapPositiveX = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapNegativeY = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
	ProxyTextureCubeMap = gl3.GL_PROXY_TEXTURE_CUBE_MAP
}

enum CompressedTextureTargets2D {
	Texture2D = gl3.GL_TEXTURE_2D,
	TextureCubeMapPositiveX = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapNegativeY = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

enum TextureTargets1D {
	Texture1D = gl3.GL_TEXTURE_1D,
	ProxyTexture1D = gl3.GL_PROXY_TEXTURE_1D
}

enum CompressedTextureTargets {
	Texture1D = gl3.GL_TEXTURE_1D,
	Texture2D = gl3.GL_TEXTURE_2D,
	Texture3D = gl3.GL_TEXTURE_3D,
	TextureCubeMapPositiveX = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapnegativeY = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl3.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl3.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

void glActiveTexture(gl3.GLenum texture) {
	gl3.glActiveTexture(texture);
}

void glSampleCoverage(gl3.GLfloat value, bool invert)
in {
	assert(value <= 1);
	assert(value >= 0);
} body {
	gl3.glSampleCoverage(value, cast(gl3.GLboolean)invert);
}

void glCompressedTexImage3D(TextureTargets target, gl3.GLint level, InternalFormat internalFormat, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage3D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, width, height, depth, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage2D(TextureTargets2D target, gl3.GLint level, InternalFormat internalFormat, gl3.GLsizei width, gl3.GLsizei height, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage2D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, width, height, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage1D(TextureTargets1D target, gl3.GLint level, InternalFormat internalFormat, gl3.GLsizei width, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexImage1D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, width, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage3D(gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage3D(gl3.GL_TEXTURE_3D, level, xoffset, yoffset, zoffset, width, height, depth, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage2D(CompressedTextureTargets2D target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLsizei width, gl3.GLsizei height, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage2D(cast(gl3.GLenum)target, level, xoffset, yoffset, width, height, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage1D(gl3.GLint level, gl3.GLint xoffset, gl3.GLsizei width, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl3.glCompressedTexSubImage1D(gl3.GL_TEXTURE_1D, level, xoffset, width, internalFormat, cast(uint)data.length, data.ptr);
}

void glGetCompressedTexImage(CompressedTextureTargets target, gl3.GLint lod, out void[] image) {
	gl3.glGetCompressedTexImage(cast(gl3.GLenum)target, lod, image.ptr);
}

