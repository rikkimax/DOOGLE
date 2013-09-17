module doogle.overloads.wrappers;
import gl3 = derelict.opengl3.gl3;
import arb = derelict.opengl3.arb;

/**
 * OpenGL 1.0
 */

/*bindFunc(cast(void**)&glCullFace, "glCullFace");
bindFunc(cast(void**)&glFrontFace, "glFrontFace");
bindFunc(cast(void**)&glHint, "glHint");
bindFunc(cast(void**)&glLineWidth, "glLineWidth");
bindFunc(cast(void**)&glPointSize, "glPointSize");
bindFunc(cast(void**)&glPolygonMode, "glPolygonMode");
bindFunc(cast(void**)&glScissor, "glScissor");
bindFunc(cast(void**)&glTexParameterf, "glTexParameterf");
bindFunc(cast(void**)&glTexParameterfv, "glTexParameterfv");
bindFunc(cast(void**)&glTexParameteri, "glTexParameteri");
bindFunc(cast(void**)&glTexParameteriv, "glTexParameteriv");
bindFunc(cast(void**)&glTexImage1D, "glTexImage1D");
bindFunc(cast(void**)&glTexImage2D, "glTexImage2D");
bindFunc(cast(void**)&glDrawBuffer, "glDrawBuffer");
bindFunc(cast(void**)&glClear, "glClear");
bindFunc(cast(void**)&glClearColor, "glClearColor");
bindFunc(cast(void**)&glClearStencil, "glClearStencil");
bindFunc(cast(void**)&glClearDepth, "glClearDepth");
bindFunc(cast(void**)&glStencilMask, "glStencilMask");
bindFunc(cast(void**)&glColorMask, "glColorMask");
bindFunc(cast(void**)&glDepthMask, "glDepthMask");
bindFunc(cast(void**)&glDisable, "glDisable");
bindFunc(cast(void**)&glEnable, "glEnable");
bindFunc(cast(void**)&glFinish, "glFinish");
bindFunc(cast(void**)&glFlush, "glFlush");
bindFunc(cast(void**)&glBlendFunc, "glBlendFunc");
bindFunc(cast(void**)&glLogicOp, "glLogicOp");
bindFunc(cast(void**)&glStencilFunc, "glStencilFunc");
bindFunc(cast(void**)&glStencilOp, "glStencilOp");
bindFunc(cast(void**)&glDepthFunc, "glDepthFunc");
bindFunc(cast(void**)&glPixelStoref, "glPixelStoref");
bindFunc(cast(void**)&glPixelStorei, "glPixelStorei");
bindFunc(cast(void**)&glReadBuffer, "glReadBuffer");
bindFunc(cast(void**)&glReadPixels, "glReadPixels");
bindFunc(cast(void**)&glGetBooleanv, "glGetBooleanv");
bindFunc(cast(void**)&glGetDoublev, "glGetDoublev");
bindFunc(cast(void**)&glGetError, "glGetError");
bindFunc(cast(void**)&glGetFloatv, "glGetFloatv");
bindFunc(cast(void**)&glGetIntegerv, "glGetIntegerv");
bindFunc(cast(void**)&glGetString, "glGetString");
bindFunc(cast(void**)&glGetTexImage, "glGetTexImage");
bindFunc(cast(void**)&glGetTexParameterfv, "glGetTexParameterfv");
bindFunc(cast(void**)&glGetTexParameteriv, "glGetTexParameteriv");
bindFunc(cast(void**)&glGetTexLevelParameterfv, "glGetTexLevelParameterfv");
bindFunc(cast(void**)&glGetTexLevelParameteriv, "glGetTexLevelParameteriv");
bindFunc(cast(void**)&glIsEnabled, "glIsEnabled");
bindFunc(cast(void**)&glDepthRange, "glDepthRange");
bindFunc(cast(void**)&glViewport, "glViewport");*/

/**
 * OpenGL 1.1
 */

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

enum InternalFormat {
	DepthComponent = gl3.GL_DEPTH_COMPONENT,
	DepthStencil = gl3.GL_DEPTH_STENCIL,
	Red = gl3.GL_RED,
	RG = gl3.GL_RG,
	RGB = gl3.GL_RGB,
	RGBA = gl3.GL_RGBA
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

enum BindTextureTarget {
	Texture1D = gl3.GL_TEXTURE_1D,
	Texture2D = gl3.GL_TEXTURE_2D,
	Texture3D = gl3.GL_TEXTURE_3D,
	Texture1DArray = gl3.GL_TEXTURE_1D_ARRAY,
	Texture2DArray = gl3.GL_TEXTURE_2D_ARRAY,
	TextureRectangle = gl3.GL_TEXTURE_RECTANGLE,
	TextureCubeMap = gl3.GL_TEXTURE_CUBE_MAP,
	TextureCubeMapArray = gl3.GL_TEXTURE_CUBE_MAP_ARRAY,
	TextureBuffer = gl3.GL_TEXTURE_BUFFER,
	Texture2DMultiSample = gl3.GL_TEXTURE_2D_MULTISAMPLE,
	Texture2DMultiSampleArray = gl3.GL_TEXTURE_2D_MULTISAMPLE_ARRAY
}

void glDrawArrays(Primitives mode, gl3.GLint first, gl3.GLint count) {
	gl3.glDrawArrays(cast(gl3.GLenum)mode, first, count);
}

void glDrawElements(Primitives mode, ubyte[] indices) {
	gl3.glDrawElements(cast(gl3.GLenum)mode, cast(uint)indices.length, gl3.GL_UNSIGNED_BYTE, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, ushort[] indices) {
	gl3.glDrawElements(cast(gl3.GLenum)mode, cast(uint)indices.length, gl3.GL_UNSIGNED_SHORT, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, uint[] indices) {
	gl3.glDrawElements(cast(gl3.GLenum)mode, cast(uint)indices.length, gl3.GL_UNSIGNED_INT, cast(void*)indices.ptr);
}

void glPolygonOffset(gl3.GLfloat factor, gl3.GLfloat units) {
	gl3.glPolygonOffset(factor, units);
}

void glCopyTexImage1D(gl3.GLint level, InternalFormat internalFormat, gl3.GLint x, gl3.GLint y, gl3.GLsizei width) {
	gl3.glCopyTexImage1D(gl3.GL_TEXTURE_1D, level, cast(gl3.GLenum)internalFormat, x, y, width, 0);
}

void glCopyTexImage2D(CompressedTextureTargets2D target, gl3.GLint level, InternalFormat internalFormat, gl3.GLint x, gl3.GLint y, gl3.GLsizei width, gl3.GLsizei height) {
	gl3.glCopyTexImage2D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, x, y, width, height, 0);
}

void glCopyTexSubImage1D(gl3.GLint level, gl3.GLint xoffset, gl3.GLint x, gl3.GLint y, gl3.GLsizei width) {
	gl3.glCopyTexSubImage1D(gl3.GL_TEXTURE_1D, level, xoffset, x, y, width);
}

void glCopyTexSubImage2D(CompressedTextureTargets2D target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint x, gl3.GLint y, gl3.GLsizei width, gl3.GLsizei height) {
	gl3.glCopyTexSubImage2D(cast(gl3.GLenum)target, level, xoffset, yoffset, x, y, width, height);
}

void glBindTexture(BindTextureTarget target, gl3.GLuint texture) {
	gl3.glBindTexture(cast(gl3.GLenum)target, texture);
}

void glDeleteTextures(gl3.GLuint[] textures) {
	gl3.glDeleteTextures(cast(uint)textures.length, textures.ptr);
}

void glDeleteTextures(gl3.GLuint texture) {
	gl3.glDeleteTextures(1, &texture);
}

void glGenTextures(out gl3.GLuint texture) {
	gl3.glGenTextures(1, &texture);
}

void glGenTextures(gl3.GLsizei n, out gl3.GLuint[] textures) {
	gl3.glGenTextures(n, textures.ptr);
}

bool glIsTexture(gl3.GLuint texture) {
	return cast(bool)gl3.glIsTexture(texture);
}

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

void glBlendColor(ubyte r, ubyte g, ubyte b, ubyte a) {
	gl3.glBlendColor(r / 255f, g / 255f, b / 255f, a / 255f);
}

void glBlendEquation(BlendMode mode) {
	gl3.glBlendEquation(cast(gl3.GLenum)mode);
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

void glTexImage3D(TextureTargets target, gl3.GLint level, InternalFormat internalFormat, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, PixelFormat format, PixelDataType type, void[] data) {
	gl3.glTexImage3D(cast(gl3.GLenum)target, level, cast(gl3.GLenum)internalFormat, width, height, depth, 0, cast(gl3.GLenum)format, cast(gl3.GLenum)type, data.ptr);
}

void glTexSubImage3D(SubTextureTargets target, gl3.GLint level, gl3.GLint xoffset, gl3.GLint yoffset, gl3.GLint zoffset, gl3.GLsizei width, gl3.GLsizei height, gl3.GLsizei depth, PixelSubTextureFormat format, PixelDataType type, void[] data) {
	gl3.glTexSubImage3D(cast(gl3.GLenum)target, level, xoffset, yoffset, zoffset, width, height, depth, cast(gl3.GLenum)format, cast(gl3.GLenum)type, data.ptr);
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

/**
 * Opengl 1.4
 */

enum BlendFactors {
	Zero = gl3.GL_ZERO,
	One = gl3.GL_ONE,
	SrcColor = gl3.GL_SRC_COLOR,
	OneMinusSrcColor = gl3.GL_ONE_MINUS_SRC_COLOR,
	DstColor = gl3.GL_DST_COLOR,
	OneMinusDstColor = gl3.GL_ONE_MINUS_DST_COLOR,
	SrcAlpha = gl3.GL_SRC_ALPHA,
	OneMinusSrcAlpha = gl3.GL_ONE_MINUS_SRC_ALPHA,
	DstAlpha = gl3.GL_DST_ALPHA,
	OneMinusDstAlpha = gl3.GL_ONE_MINUS_DST_ALPHA,
	ConstantColor = gl3.GL_CONSTANT_COLOR,
	OneMinusConstantColor = gl3.GL_ONE_MINUS_CONSTANT_COLOR,
	ConstantAlpha = gl3.GL_CONSTANT_ALPHA,
	OneMinusConstantAlpha = gl3.GL_ONE_MINUS_CONSTANT_ALPHA,
	SrcAlphaSaturate = gl3.GL_SRC_ALPHA_SATURATE,
	Src2Color = gl3.GL_SRC1_COLOR
}

enum PointParamaterNames {
	FadeThresholdSize = gl3.GL_POINT_FADE_THRESHOLD_SIZE,
	SpriteCoordOrigin = gl3.GL_POINT_SPRITE_COORD_ORIGIN
}

void glBlendFuncSeparate(BlendFactors srcRGB, BlendFactors dstRGB, BlendFactors srcAlpha, BlendFactors dstAlpha) {
	gl3.glBlendFuncSeparate(cast(gl3.GLenum)srcRGB, cast(gl3.GLenum)dstRGB, cast(gl3.GLenum)srcAlpha, cast(gl3.GLenum)dstAlpha);
}

void glMultiDrawArrays(Primitives mode, gl3.GLint[] first, gl3.GLsizei[] count)
in {
	assert(first.length == count.length);
} body {
	gl3.glMultiDrawArrays(cast(gl3.GLenum)mode, first.ptr, count.ptr, cast(uint)first.length);
}

void glMultiDrawElements(Primitives mode, gl3.GLsizei[] count, ubyte[] indices) {
	gl3.glMultiDrawElements(cast(gl3.GLenum)mode, count.ptr, gl3.GL_UNSIGNED_BYTE, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, gl3.GLsizei[] count, ushort[] indices) {
	gl3.glMultiDrawElements(cast(gl3.GLenum)mode, count.ptr, gl3.GL_UNSIGNED_SHORT, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, gl3.GLsizei[] count, uint[] indices) {
	gl3.glMultiDrawElements(cast(gl3.GLenum)mode, count.ptr, gl3.GL_UNSIGNED_INT, indices.ptr, cast(uint)indices.length);
}

void glPointParameterf(PointParamaterNames pname, gl3.GLfloat param) {
	gl3.glPointParameterf(cast(gl3.GLenum)pname, param);
}

void glPointParameterfv(PointParamaterNames pname, gl3.GLfloat[] params) {
	gl3.glPointParameterfv(cast(gl3.GLenum)pname, params.ptr);
}

void glPointParameteri(PointParamaterNames pname, gl3.GLint param) {
	gl3.glPointParameterf(cast(gl3.GLenum)pname, param);
}

void glPointParameteriv(PointParamaterNames pname, gl3.GLint[] params) {
	gl3.glPointParameteriv(cast(gl3.GLenum)pname, params.ptr);
}

/**
 * Opengl 1.5
 */

enum QueryTargets {
	SamplesPassed = gl3.GL_SAMPLES_PASSED,
	AnySamplesPassed = gl3.GL_ANY_SAMPLES_PASSED,
	AnySamplesPassedConservative = gl3.GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
	PrimitivesGenerated = gl3.GL_PRIMITIVES_GENERATED,
	TransformFeedbackPrimitivesWritten = gl3.GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
	TimeElapsed = gl3.GL_TIME_ELAPSED
}

enum QueryTarget {
	SamplesPassed = gl3.GL_SAMPLES_PASSED,
	AnySamplesPassed = gl3.GL_ANY_SAMPLES_PASSED,
	AnySamplesPassedConservative = gl3.GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
	PrimitivesGenerated = gl3.GL_PRIMITIVES_GENERATED,
	TransformFeedbackPrimitivesWritten = gl3.GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
	TimeElapsed = gl3.GL_TIME_ELAPSED,
	TimeStamp = gl3.GL_TIMESTAMP
}

enum QueryNames {
	CurrentQuery = gl3.GL_CURRENT_QUERY,
	QueryCounterBits = gl3.GL_QUERY_COUNTER_BITS
}

enum QueryResultNames {
	Result = gl3.GL_QUERY_RESULT,
	ResultAvailable = gl3.GL_QUERY_RESULT_AVAILABLE
}

enum BindBufferTargets {
	ArrayBuffer = gl3.GL_ARRAY_BUFFER,
	AtomicCounterBuffer = gl3.GL_ATOMIC_COUNTER_BUFFER,
	CopyReadBuffer = gl3.GL_COPY_READ_BUFFER,
	CopyWriteBuffer = gl3.GL_COPY_WRITE_BUFFER,
	DrawIndirectBuffer = gl3.GL_DRAW_INDIRECT_BUFFER,
	DispatchIndirectBuffer = gl3.GL_DISPATCH_INDIRECT_BUFFER,
	ElementArrayBuffer = gl3.GL_ELEMENT_ARRAY_BUFFER,
	PixelPackBuffer = gl3.GL_PIXEL_PACK_BUFFER,
	PixelUnpackBuffer = gl3.GL_PIXEL_UNPACK_BUFFER,
	// NOT SUPPORTED QueryBuffer = gl3.GL_QUERY_BUFFER,
	ShaderStorageBuffer = gl3.GL_SHADER_STORAGE_BUFFER,
	TextureBuffer = gl3.GL_TEXTURE_BUFFER,
	TransformFeedbackBuffer = gl3.GL_TRANSFORM_FEEDBACK_BUFFER,
	UniformBuffer = gl3.GL_UNIFORM_BUFFER
}

enum BufferUsages {
	StreamDraw = gl3.GL_STREAM_DRAW,
	StreamRead = gl3.GL_STREAM_READ,
	StreamCopy = gl3.GL_STREAM_COPY,
	StaticDraw = gl3.GL_STATIC_DRAW,
	StaticRead = gl3.GL_STATIC_READ,
	StaticCopy = gl3.GL_STATIC_COPY,
	DynamicDraw = gl3.GL_DYNAMIC_DRAW,
	DynamicRead = gl3.GL_DYNAMIC_READ,
	DynamicCopy = gl3.GL_DYNAMIC_COPY
}

enum BufferAccess {
	ReadOnly = gl3.GL_READ_ONLY,
	WriteOnly = gl3.GL_WRITE_ONLY,
	ReadWrite = gl3.GL_READ_WRITE
}

enum GetBufferTargets {
	ArrayBuffer = gl3.GL_ARRAY_BUFFER,
	ElementArrayBuffer = gl3.GL_ELEMENT_ARRAY_BUFFER
}

enum GetBufferValues {
	BufferSize = gl3.GL_BUFFER_SIZE,
	BufferUsage = gl3.GL_BUFFER_USAGE
}

void glGenQueries(gl3.GLsizei n, out gl3.GLuint[] ids) {
	gl3.glGenQueries(n, ids.ptr);
}

void glGenQueries(out gl3.GLuint id) {
	gl3.glGenQueries(1, &id);
}

void glDeleteQueries(gl3.GLsizei n, out gl3.GLuint[] ids) {
	gl3.glDeleteQueries(n, ids.ptr);
}

void glDeleteQueries(out gl3.GLuint id) {
	gl3.glDeleteQueries(1, &id);
}

gl3.GLboolean glIsQuery(gl3.GLuint id) {
	return gl3.glIsQuery(id);
}

void glBeginQuery(QueryTargets target, gl3.GLuint id) {
	gl3.glBeginQuery(cast(gl3.GLenum)target, id);
}

void glEndQuery(QueryTargets target) {
	gl3.glEndQuery(cast(gl3.GLenum)target);
}

void glGetQueryiv(QueryTarget target, QueryNames pname, gl3.GLint[] params) {
	gl3.glGetQueryiv(cast(gl3.GLenum)target, cast(gl3.GLenum)pname, params.ptr);
}

void glGetQueryObjectiv(gl3.GLuint id, QueryResultNames pname, out gl3.GLint[] params) {
	gl3.glGetQueryObjectiv(id, cast(gl3.GLenum)pname, params.ptr);
}

void glGetQueryObjectuiv(gl3.GLuint id, QueryResultNames pname, out gl3.GLuint[] params) {
	gl3.glGetQueryObjectuiv(id, cast(gl3.GLenum)pname, params.ptr);
}

void glGetQueryObjecti64v(gl3.GLuint id, QueryResultNames pname, out long[] params) {
	arb.glGetQueryObjecti64v(id, cast(gl3.GLenum)pname, cast(gl3.GLint64*)params.ptr);
}

void glGetQueryObjectui64v(gl3.GLuint id, QueryResultNames pname, out ulong[] params) {
	arb.glGetQueryObjectui64v(id, cast(gl3.GLenum)pname, cast(gl3.GLuint64*)params.ptr);
}

void glBindBuffer(BindBufferTargets target, gl3.GLuint buffer) {
	gl3.glBindBuffer(cast(gl3.GLenum)target, buffer);
}

void glDeleteBuffers(gl3.GLuint[] buffers) {
	gl3.glDeleteBuffers(cast(int)buffers.length, buffers.ptr);
}

void glGenBuffers(gl3.GLsizei n, out gl3.GLuint[] buffers) {
	gl3.glGenBuffers(n, buffers.ptr);
}

bool glIsBuffer(gl3.GLuint buffer) {
	return cast(bool)gl3.glIsBuffer(buffer);
}

void glBufferData(BindBufferTargets target, void[] data, BufferUsages usage) {
	gl3.glBufferData(cast(gl3.GLenum)target, cast(gl3.GLsizeiptr)data.length, data.ptr, cast(gl3.GLenum)usage);
}

void glBufferSubData(BindBufferTargets target, int offset, void[] data) {
	gl3.glBufferSubData(cast(gl3.GLenum)target, cast(gl3.GLintptr)offset, cast(gl3.GLsizeiptr)data.length, data.ptr);
}

void glGetBufferSubData(BindBufferTargets target, int offset, ref void[] data) {
	gl3.glGetBufferSubData(cast(gl3.GLenum)target, cast(gl3.GLintptr)offset, cast(gl3.GLsizeiptr)data.length, data.ptr);
}

void* glMapBuffer(BindBufferTargets target, BufferAccess access) {
	return gl3.glMapBuffer(cast(gl3.GLenum)target, cast(gl3.GLenum)access);
}

bool glUnmapBuffer(BindBufferTargets target) {
	return cast(bool)gl3.glUnmapBuffer(cast(gl3.GLenum)target);
}

void glGetBufferPointerv(BindBufferTargets target, void[] params) {
	gl3.glGetBufferPointerv(cast(gl3.GLenum)target, gl3.GL_BUFFER_MAP_POINTER, params.ptr);
}

void glGetBufferParameteriv(GetBufferTargets target, GetBufferValues value, out gl3.GLint[] data) {
	gl3.glGetBufferParameteriv(cast(gl3.GLenum)target, value, data.ptr);
}

/**
 * Opengl 2.0
 */

enum DrawBuffers {
	None = gl3.GL_NONE,
	FrontLeft = gl3.GL_FRONT_LEFT,
	FrontRight = gl3.GL_FRONT_RIGHT,
	BackLeft = gl3.GL_BACK_LEFT,
	BackRight = gl3.GL_BACK_RIGHT,
	ColorAttachment0 = gl3.GL_COLOR_ATTACHMENT0
}

enum Faces {
	Front = gl3.GL_FRONT,
	Back = gl3.GL_BACK,
	FrontAndBack = gl3.GL_FRONT_AND_BACK
}

enum FaceStencilAction {
	Keep = gl3.GL_KEEP,
	Zero = gl3.GL_ZERO,
	Replace = gl3.GL_REPLACE,
	Incr = gl3.GL_INCR,
	IncrWrap = gl3.GL_INCR_WRAP,
	Decr = gl3.GL_DECR,
	DecrWrap = gl3.GL_DECR_WRAP,
	Invert = gl3.GL_INVERT
}

enum TestFunctions {
	Never = gl3.GL_NEVER,
	Less = gl3.GL_LESS,
	LEqual = gl3.GL_LEQUAL,
	Greater = gl3.GL_GREATER,
	GEqual = gl3.GL_GEQUAL,
	Equal = gl3.GL_EQUAL,
	NotEqual = gl3.GL_NOTEQUAL,
	Always = gl3.GL_ALWAYS
}

enum ShaderTypes {
	ComputeShader = gl3.GL_COMPUTE_SHADER,
	VertexShader = gl3.GL_VERTEX_SHADER,
	TessControlShader = gl3.GL_TESS_CONTROL_SHADER,
	TessEvaluationShader = gl3.GL_TESS_EVALUATION_SHADER,
	GeometryShader = gl3.GL_GEOMETRY_SHADER,
	FragmentShader = gl3.GL_FRAGMENT_SHADER
}

enum AttribDataTypes {
	Float = gl3.GL_FLOAT,
	FloatVec2 = gl3.GL_FLOAT_VEC2,
	FloatVec3 = gl3.GL_FLOAT_VEC3,
	FloatVec4 = gl3.GL_FLOAT_VEC4,
	FloatMat2 = gl3.GL_FLOAT_MAT2,
	FloatMat3 = gl3.GL_FLOAT_MAT3,
	FloatMat4 = gl3.GL_FLOAT_MAT4,
	FloatMat2x3 = gl3.GL_FLOAT_MAT2x3,
	FloatMat2x4 = gl3.GL_FLOAT_MAT2x4,
	FloatMat3x2 = gl3.GL_FLOAT_MAT3x2,
	FloatMat3x4 = gl3.GL_FLOAT_MAT3x4,
	FloatMat4x2 = gl3.GL_FLOAT_MAT4x2,
	FloatMat4x3 = gl3.GL_FLOAT_MAT4x3,
	Int = gl3.GL_INT,
	IntVec2 = gl3.GL_INT_VEC2,
	IntVec3 = gl3.GL_INT_VEC3,
	IntVec4 = gl3.GL_INT_VEC4,
	UInt = gl3.GL_UNSIGNED_INT,
	UIntVec2 = gl3.GL_UNSIGNED_INT_VEC2,
	UIntVec3 = gl3.GL_UNSIGNED_INT_VEC3,
	UIntVec4 = gl3.GL_UNSIGNED_INT_VEC4,
	Double = gl3.GL_DOUBLE,
	DoubleVec2 = gl3.GL_DOUBLE_VEC2,
	DoubleVec3 = gl3.GL_DOUBLE_VEC3,
	DoubleVec4 = gl3.GL_DOUBLE_VEC4,
	DoubleMat2 = gl3.GL_DOUBLE_MAT2,
	DoubleMat3 = gl3.GL_DOUBLE_MAT3,
	DoubleMat4 = gl3.GL_DOUBLE_MAT4,
	DoubleMat2x3 = gl3.GL_DOUBLE_MAT2x3,
	DoubleMat2x4 = gl3.GL_DOUBLE_MAT2x4,
	DoubleMat3x2 = gl3.GL_DOUBLE_MAT3x2,
	DoubleMat3x4 = gl3.GL_DOUBLE_MAT3x4,
	DoubleMat4x2 = gl3.GL_DOUBLE_MAT4x2,
	DoubleMat4x3 = gl3.GL_DOUBLE_MAT4x3
}

enum ProgramObjects {
	DeleteStatus = gl3.GL_DELETE_STATUS,
	LinkStatus = gl3.GL_LINK_STATUS,
	ValidateStatus = gl3.GL_VALIDATE_STATUS,
	InfoLogStatus = gl3.GL_INFO_LOG_LENGTH,
	AttachedShaders = gl3.GL_ATTACHED_SHADERS,
	ActiveAttributes = gl3.GL_ACTIVE_ATTRIBUTES,
	ActiveAttributeMaxLength = gl3.GL_ACTIVE_ATTRIBUTE_MAX_LENGTH,
	ActiveUniforms = gl3.GL_ACTIVE_UNIFORMS,
	ActiveUniformMaxLength = gl3.GL_ACTIVE_UNIFORM_MAX_LENGTH
}

enum ShaderObjects {
	ShaderType = gl3.GL_SHADER_TYPE,
	DeleteStatus = gl3.GL_DELETE_STATUS,
	CompileStatus = gl3.GL_COMPILE_STATUS,
	InfoLogLength = gl3.GL_INFO_LOG_LENGTH,
	ShaderSourceLength = gl3.GL_SHADER_SOURCE_LENGTH
}

enum VertexAttributeNames {
	ArrayBufferBindings = gl3.GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING,
	ArrayEnabled = gl3.GL_VERTEX_ATTRIB_ARRAY_ENABLED,
	ArraySize = gl3.GL_VERTEX_ATTRIB_ARRAY_SIZE,
	ArrayStride = gl3.GL_VERTEX_ATTRIB_ARRAY_STRIDE,
	ArrayType = gl3.GL_VERTEX_ATTRIB_ARRAY_TYPE,
	ArrayNormalized = gl3.GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
	ArrayInteger = gl3.GL_VERTEX_ATTRIB_ARRAY_INTEGER,
	ArrayDivisor = gl3.GL_VERTEX_ATTRIB_ARRAY_DIVISOR,
	Current = gl3.GL_CURRENT_VERTEX_ATTRIB
}

enum AttribPointerSize {
	One = 1,
	Two = 2,
	Three = 3,
	Four = 4,
	BGRA = gl3.GL_BGRA
}

enum AttribPointerType {
	Byte = gl3.GL_BYTE,
	UByte = gl3.GL_UNSIGNED_BYTE,
	Short = gl3.GL_SHORT,
	UShort = gl3.GL_UNSIGNED_SHORT,
	Int = gl3.GL_INT,
	UInt = gl3.GL_UNSIGNED_INT,
	HalfFloat = gl3.GL_HALF_FLOAT,
	Float = gl3.GL_FLOAT,
	Double = gl3.GL_DOUBLE,
	Fixed = gl3.GL_FIXED,
	Int2101010REV = gl3.GL_INT_2_10_10_10_REV, 
	UInt2101010Rev = gl3.GL_UNSIGNED_INT_2_10_10_10_REV,
	UInt10F11F11FRev = gl3.GL_UNSIGNED_INT_10F_11F_11F_REV 
}

void glBlendEquationSeparate(BlendMode modeRGB, BlendMode modeAlpha) {
	gl3.glBlendEquationSeparate(cast(gl3.GLenum)modeRGB, cast(gl3.GLenum)modeAlpha);
}

void glDrawBuffers(gl3.GLsizei n, DrawBuffers[] bufs) {
	gl3.glDrawBuffers(n, cast(gl3.GLenum*)bufs.ptr);
}

void glStencilOpSeparate(Faces face, FaceStencilAction sfail, FaceStencilAction dpfail, FaceStencilAction dppass) {
	gl3.glStencilOpSeparate(cast(gl3.GLenum)face, cast(gl3.GLenum)sfail, cast(gl3.GLenum)dpfail, cast(gl3.GLenum)dppass);
}

void glStencilFuncSeparate(Faces face, TestFunctions func, gl3.GLint ref_, gl3.GLuint mask) {
	gl3.glStencilFuncSeparate(cast(gl3.GLenum)face, cast(gl3.GLenum)func, ref_, mask);
}

void glStencilMaskSeparate(Faces face, gl3.GLuint mask) {
	gl3.glStencilMaskSeparate(cast(gl3.GLenum)face, mask);
}

void glAttachShader(gl3.GLuint program, gl3.GLuint shader) {
	gl3.glAttachShader(program, shader);
}

void glBindAttribLocation(gl3.GLuint program, gl3.GLuint index, string name) {
	gl3.glBindAttribLocation(program, index, (name ~ 0).ptr);
}

void glCompileShader(gl3.GLuint shader) {
	gl3.glCompileShader(shader);
}

gl3.GLuint glCreateProgram() {
	return gl3.glCreateProgram();
}

gl3.GLuint glCreateShader(ShaderTypes shaderType) {
	return gl3.glCreateShader(cast(gl3.GLenum)shaderType);
}

void glDeleteProgram(gl3.GLuint program) {
	gl3.glDeleteProgram(program);
}

void glDeleteShader(gl3.GLuint shader) {
	gl3.glDeleteShader(shader);
}

void glDetachShader(gl3.GLuint program, gl3.GLuint shader) {
	gl3.glDetachShader(program, shader);
}

void glDisableVertexAttribArray(gl3.GLuint index) {
	gl3.glDisableVertexAttribArray(index);
}

void glEnableVertexAttribArray(gl3.GLuint index) {
	gl3.glEnableVertexAttribArray(index);
}

void glGetActiveAttrib(gl3.GLuint program, gl3.GLuint index, out gl3.GLint* size, out AttribDataTypes type, out string name) {
	gl3.glGetActiveAttrib(program, index, int.max,  cast(int*)null, size, cast(gl3.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetActiveUniform(gl3.GLuint program, gl3.GLuint index, out gl3.GLint size, out AttribDataTypes type, out string name) {
	gl3.glGetActiveUniform(program, index, int.max,  cast(int*)null, &size, cast(gl3.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetAttachedShaders(gl3.GLuint program, out gl3.GLuint[] shaders) {
	gl3.GLsizei* count;
	gl3.glGetAttachedShaders(program, int.max, count, shaders.ptr);
}

gl3.GLint glGetAttribLocation(gl3.GLuint program, string name) {
	return gl3.glGetAttribLocation(program, (name ~ 0).ptr);
}

void glGetProgramiv(gl3.GLuint program, ProgramObjects pname, out gl3.GLint[] params) {
	gl3.glGetProgramiv(program, cast(gl3.GLenum)pname, params.ptr);
}

void glGetProgramInfoLog(gl3.GLuint program, out string infoLog) {
	gl3.GLsizei* length;
	gl3.glGetProgramInfoLog(program, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderiv(gl3.GLuint shader, ShaderObjects pname, out gl3.GLint[] params) {
	gl3.glGetShaderiv(shader, cast(gl3.GLenum)pname, params.ptr);
}

void glGetShaderInfoLog(gl3.GLuint shader, string infoLog) {
	gl3.GLsizei* length;
	gl3.glGetShaderInfoLog(shader, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderSource(gl3.GLuint shader, out string source) {
	gl3.GLsizei* length;
	gl3.glGetShaderInfoLog(shader, int.max, length, cast(char*)source.ptr);
	source = source[0 .. $-1];
}

gl3.GLint glGetUniformLocation(gl3.GLuint program, string name) {
	return gl3.glGetUniformLocation(program, cast(char*)(name ~ 0).ptr);
}

void glGetUniformfv(gl3.GLuint program, gl3.GLint location, gl3.GLfloat[] params) {
	gl3.glGetUniformfv(program, location, params.ptr);
}

void glGetUniformiv(gl3.GLuint program, gl3.GLint location, gl3.GLint[] params) {
	gl3.glGetUniformiv(program, location, params.ptr);
}

void glGetVertexAttribdv(gl3.GLuint index, VertexAttributeNames pname, gl3.GLdouble[] params) {
	gl3.glGetVertexAttribdv(index, cast(gl3.GLenum)pname, params.ptr);
}

void glGetVertexAttribfv(gl3.GLuint index, VertexAttributeNames pname, gl3.GLfloat[] params) {
	gl3.glGetVertexAttribfv(index, cast(gl3.GLenum)pname, params.ptr);
}

void glGetVertexAttribiv(gl3.GLuint index, VertexAttributeNames pname, gl3.GLint[] params) {
	gl3.glGetVertexAttribiv(index, cast(gl3.GLenum)pname, params.ptr);
}

void glGetVertexAttribPointerv(gl3.GLuint index, out gl3.GLvoid*[] pointer) {
	gl3.glGetVertexAttribPointerv(index, gl3.GL_VERTEX_ATTRIB_ARRAY_POINTER, pointer.ptr);
}

bool glIsProgram(gl3.GLuint program) {
	return cast(bool)gl3.glIsProgram(program);
}

bool glIsShader(gl3.GLuint shader) {
	return cast(bool)gl3.glIsShader(shader);
}

void glLinkProgram(gl3.GLuint program) {
	gl3.glLinkProgram(program);
}

void glShaderSource(gl3.GLuint shader, string _string) {
	size_t length = _string.length;
	gl3.glShaderSource(shader, 1, cast(const(gl3.GLchar*)*)_string.ptr, cast(const(gl3.GLint)*)&length);
}

void glUseProgram(gl3.GLuint program) {
	gl3.glUseProgram(program);
}

void glUniform1f(gl3.GLint location, gl3.GLfloat v0) {
	gl3.glUniform1f(location, v0);
}

void glUniform2f(gl3.GLint location, gl3.GLfloat v0, gl3.GLfloat v1) {
	gl3.glUniform2f(location, v0, v1);
}

void glUniform3f(gl3.GLint location, gl3.GLfloat v0, gl3.GLfloat v1, gl3.GLfloat v2) {
	gl3.glUniform3f(location, v0, v1, v2);
}

void glUniform4f(gl3.GLint location, gl3.GLfloat v0, gl3.GLfloat v1, gl3.GLfloat v2, gl3.GLfloat v3) {
	gl3.glUniform4f(location, v0, v1, v2, v3);
}

void glUniform1i(gl3.GLint location, gl3.GLint v0) {
	gl3.glUniform1i(location, v0);
}

void glUniform2i(gl3.GLint location, gl3.GLint v0, gl3.GLint v1) {
	gl3.glUniform2i(location, v0, v1);
}

void glUniform3i(gl3.GLint location, gl3.GLint v0, gl3.GLint v1, gl3.GLint v2) {
	gl3.glUniform3i(location, v0, v1, v2);
}

void glUniform4i(gl3.GLint location, gl3.GLint v0, gl3.GLint v1, gl3.GLint v2, gl3.GLint v3) {
	gl3.glUniform4i(location, v0, v1, v2, v3);
}

void glUniform1fv(gl3.GLint location, gl3.GLfloat[] value) {
	gl3.glUniform1fv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform2fv(gl3.GLint location, gl3.GLfloat[] value) {
	gl3.glUniform2fv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform3fv(gl3.GLint location, gl3.GLfloat[] value) {
	gl3.glUniform3fv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform4fv(gl3.GLint location, gl3.GLfloat[] value) {
	gl3.glUniform4fv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform1iv(gl3.GLint location, gl3.GLint[] value) {
	gl3.glUniform1iv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform2iv(gl3.GLint location, gl3.GLint[] value) {
	gl3.glUniform2iv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform3iv(gl3.GLint location, gl3.GLint[] value) {
	gl3.glUniform3iv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform4iv(gl3.GLint location, gl3.GLint[] value) {
	gl3.glUniform4iv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform1uiv(gl3.GLint location, gl3.GLuint[] value) {
	gl3.glUniform1uiv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform2uiv(gl3.GLint location, gl3.GLuint[] value) {
	gl3.glUniform2uiv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform3uiv(gl3.GLint location, gl3.GLuint[] value) {
	gl3.glUniform3uiv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniform4uiv(gl3.GLint location, gl3.GLuint[] value) {
	gl3.glUniform4uiv(location, cast(gl3.GLsizei)value.length, value.ptr);
}

void glUniformMatrix2fv(gl3.GLint location, bool transpose, gl3.GLfloat[] value) {
	gl3.glUniformMatrix2fv(location, cast(gl3.GLint)(value.length / 4), cast(ubyte)(transpose ? gl3.GL_TRUE : gl3.GL_FALSE), value.ptr);
}

void glUniformMatrix3fv(gl3.GLint location, bool transpose, gl3.GLfloat[] value) {
	gl3.glUniformMatrix3fv(location, cast(gl3.GLint)(value.length / 9), cast(ubyte)(transpose ? gl3.GL_TRUE : gl3.GL_FALSE), value.ptr);
}

void glUniformMatrix4fv(gl3.GLint location, bool transpose, gl3.GLfloat[] value) {
	gl3.glUniformMatrix4fv(location, cast(gl3.GLint)(value.length / 16), cast(ubyte)(transpose ? gl3.GL_TRUE : gl3.GL_FALSE), value.ptr);
}

void glValidateProgram(gl3.GLuint program) {
	gl3.glValidateProgram(program);
}

void glVertexAttrib1d(gl3.GLuint index, gl3.GLdouble v0) {
	gl3.glVertexAttrib1d(index, v0);
}

void glVertexAttrib1dv(gl3.GLuint index, gl3.GLdouble v) {
	gl3.glVertexAttrib1dv(index, &v);
}

void glVertexAttrib1f(gl3.GLuint index, gl3.GLfloat v) {
	gl3.glVertexAttrib1f(index, v);
}

void glVertexAttrib1fv(gl3.GLuint index, gl3.GLfloat v) {
	gl3.glVertexAttrib1fv(index, &v);
}

void glVertexAttrib1s(gl3.GLuint index, gl3.GLshort v0) {
	gl3.glVertexAttrib1s(index, v0);
}

void glVertexAttrib1sv(gl3.GLuint index, gl3.GLshort v0) {
	gl3.glVertexAttrib1sv(index, &v0);
}

void glVertexAttrib2d(gl3.GLuint index, gl3.GLdouble v0, gl3.GLdouble v1) {
	gl3.glVertexAttrib2d(index, v0, v1);
}

void glVertexAttrib2dv(gl3.GLuint index, gl3.GLdouble[2] v) {
	gl3.glVertexAttrib2dv(index, v.ptr);
}

void glVertexAttrib2f(gl3.GLuint index, gl3.GLfloat v0, gl3.GLfloat v1) {
	gl3.glVertexAttrib2f(index, v0, v1);
}

void glVertexAttrib2fv(gl3.GLuint index, gl3.GLfloat[2] v) {
	gl3.glVertexAttrib2fv(index, v.ptr);
}

void glVertexAttrib2s(gl3.GLuint index, gl3.GLshort v0, gl3.GLshort v1) {
	gl3.glVertexAttrib2s(index, v0, v1);
}

void glVertexAttrib2sv(gl3.GLuint index, gl3.GLshort[2] v) {
	gl3.glVertexAttrib2sv(index, v.ptr);
}

void glVertexAttrib3d(gl3.GLuint index, gl3.GLdouble v0, gl3.GLdouble v1, gl3.GLdouble v2) {
	gl3.glVertexAttrib3d(index, v0, v1, v2);
}

void glVertexAttrib3dv(gl3.GLuint index, gl3.GLdouble[3] v) {
	gl3.glVertexAttrib3dv(index, v.ptr);
}

void glVertexAttrib3f(gl3.GLuint index, gl3.GLfloat v0, gl3.GLfloat v1, gl3.GLfloat v2) {
	gl3.glVertexAttrib3f(index, v0, v1, v2);
}

void glVertexAttrib3fv(gl3.GLuint index, gl3.GLfloat[3] v) {
	gl3.glVertexAttrib3fv(index, v.ptr);
}

void glVertexAttrib3s(gl3.GLuint index, gl3.GLshort v0, gl3.GLshort v1, gl3.GLshort v2) {
	gl3.glVertexAttrib3s(index, v0, v1, v2);
}

void glVertexAttrib3sv(gl3.GLuint index, gl3.GLshort[3] v) {
	gl3.glVertexAttrib3sv(index, v.ptr);
}

/*
bindGLFunc(cast(void**)&glVertexAttrib4Nbv, "glVertexAttrib4Nbv");
bindGLFunc(cast(void**)&glVertexAttrib4Niv, "glVertexAttrib4Niv");
bindGLFunc(cast(void**)&glVertexAttrib4Nsv, "glVertexAttrib4Nsv");
bindGLFunc(cast(void**)&glVertexAttrib4Nub, "glVertexAttrib4Nub");
bindGLFunc(cast(void**)&glVertexAttrib4Nubv, "glVertexAttrib4Nubv");
bindGLFunc(cast(void**)&glVertexAttrib4Nuiv, "glVertexAttrib4Nuiv");
bindGLFunc(cast(void**)&glVertexAttrib4Nusv, "glVertexAttrib4Nusv");
bindGLFunc(cast(void**)&glVertexAttrib4bv, "glVertexAttrib4bv");
bindGLFunc(cast(void**)&glVertexAttrib4d, "glVertexAttrib4d");
bindGLFunc(cast(void**)&glVertexAttrib4dv, "glVertexAttrib4dv");*/

void glVertexAttrib4f(gl3.GLuint index, gl3.GLfloat v0, gl3.GLfloat v1, gl3.GLfloat v2, gl3.GLfloat v3) {
	gl3.glVertexAttrib4f(index, v0, v1, v2, v3);
}

void glVertexAttrib4fv(gl3.GLuint index, gl3.GLfloat[] v) {
	gl3.glVertexAttrib4fv(index, v.ptr);
}

/*
bindGLFunc(cast(void**)&glVertexAttrib4iv, "glVertexAttrib4iv");
bindGLFunc(cast(void**)&glVertexAttrib4s, "glVertexAttrib4s");
bindGLFunc(cast(void**)&glVertexAttrib4sv, "glVertexAttrib4sv");
bindGLFunc(cast(void**)&glVertexAttrib4ubv, "glVertexAttrib4ubv");
bindGLFunc(cast(void**)&glVertexAttrib4uiv, "glVertexAttrib4uiv");
bindGLFunc(cast(void**)&glVertexAttrib4usv, "glVertexAttrib4usv");*/

void glVertexAttribPointer(gl3.GLuint index, AttribPointerSize size, AttribPointerType type, bool normalized, gl3.GLsizei stride, gl3.GLvoid* pointer) {
	gl3.glVertexAttribPointer(index, size, type, normalized ? gl3.GL_TRUE : gl3.GL_FALSE, stride, pointer);
}

/**
 * Opengl 2.1
 */

/*
bindGLFunc(cast(void**)&glUniformMatrix2x3fv, "glUniformMatrix2x3fv");
bindGLFunc(cast(void**)&glUniformMatrix3x2fv, "glUniformMatrix3x2fv");
bindGLFunc(cast(void**)&glUniformMatrix2x4fv, "glUniformMatrix2x4fv");
bindGLFunc(cast(void**)&glUniformMatrix4x2fv, "glUniformMatrix4x2fv");
bindGLFunc(cast(void**)&glUniformMatrix3x4fv, "glUniformMatrix3x4fv");
bindGLFunc(cast(void**)&glUniformMatrix4x3fv, "glUniformMatrix4x3fv");*/