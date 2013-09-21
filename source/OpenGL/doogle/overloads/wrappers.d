module doogle.overloads.wrappers;
import doogle.platform;

/**
 * OpenGL 1.0
 */

void glClear(bool buffer = false, bool depth = false, bool stencil = false) {
	gl.glClear((buffer ? gl.GL_COLOR_BUFFER_BIT : 0) | (depth ? gl.GL_DEPTH_BUFFER_BIT : 0) | (stencil ? gl.GL_STENCIL_BUFFER_BIT : 0));
}

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
	Points = gl.GL_POINTS,
	LineStrip = gl.GL_LINE_STRIP,
	LineLoop = gl.GL_LINE_LOOP,
	Lines = gl.GL_LINES,
	LineStripAdjacency = gl.GL_LINE_STRIP_ADJACENCY,
	LinesAdjacency = gl.GL_LINES_ADJACENCY,
	TriangleStrip = gl.GL_TRIANGLE_STRIP,
	TriangleFan = gl.GL_TRIANGLE_FAN,
	Triangles = gl.GL_TRIANGLES,
	TriangleStripAdjacency = gl.GL_TRIANGLE_STRIP_ADJACENCY,
	TrianglesAdjacency = gl.GL_TRIANGLES_ADJACENCY,
	Patches = gl.GL_PATCHES
}

enum InternalFormat {
	DepthComponent = gl.GL_DEPTH_COMPONENT,
	DepthStencil = gl.GL_DEPTH_STENCIL,
	Red = gl.GL_RED,
	RG = gl.GL_RG,
	RGB = gl.GL_RGB,
	RGBA = gl.GL_RGBA
}

enum CompressedTextureTargets2D {
	Texture2D = gl.GL_TEXTURE_2D,
	TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapNegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

enum BindTextureTarget {
	Texture1D = gl.GL_TEXTURE_1D,
	Texture2D = gl.GL_TEXTURE_2D,
	Texture3D = gl.GL_TEXTURE_3D,
	Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
	Texture2DArray = gl.GL_TEXTURE_2D_ARRAY,
	TextureRectangle = gl.GL_TEXTURE_RECTANGLE,
	TextureCubeMap = gl.GL_TEXTURE_CUBE_MAP,
	TextureCubeMapArray = gl.GL_TEXTURE_CUBE_MAP_ARRAY,
	TextureBuffer = gl.GL_TEXTURE_BUFFER,
	Texture2DMultiSample = gl.GL_TEXTURE_2D_MULTISAMPLE,
	Texture2DMultiSampleArray = gl.GL_TEXTURE_2D_MULTISAMPLE_ARRAY
}

void glDrawArrays(Primitives mode, gl.GLint first, gl.GLint count) {
	gl.glDrawArrays(cast(gl.GLenum)mode, first, count);
}

void glDrawElements(Primitives mode, ubyte[] indices) {
	gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_BYTE, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, ushort[] indices) {
	gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_SHORT, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, uint[] indices) {
	gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_INT, cast(void*)indices.ptr);
}

void glPolygonOffset(gl.GLfloat factor, gl.GLfloat units) {
	gl.glPolygonOffset(factor, units);
}

void glCopyTexImage1D(gl.GLint level, InternalFormat internalFormat, gl.GLint x, gl.GLint y, gl.GLsizei width) {
	gl.glCopyTexImage1D(gl.GL_TEXTURE_1D, level, cast(gl.GLenum)internalFormat, x, y, width, 0);
}

void glCopyTexImage2D(CompressedTextureTargets2D target, gl.GLint level, InternalFormat internalFormat, gl.GLint x, gl.GLint y, gl.GLsizei width, gl.GLsizei height) {
	gl.glCopyTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, x, y, width, height, 0);
}

void glCopyTexSubImage1D(gl.GLint level, gl.GLint xoffset, gl.GLint x, gl.GLint y, gl.GLsizei width) {
	gl.glCopyTexSubImage1D(gl.GL_TEXTURE_1D, level, xoffset, x, y, width);
}

void glCopyTexSubImage2D(CompressedTextureTargets2D target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint x, gl.GLint y, gl.GLsizei width, gl.GLsizei height) {
	gl.glCopyTexSubImage2D(cast(gl.GLenum)target, level, xoffset, yoffset, x, y, width, height);
}

void glBindTexture(BindTextureTarget target, gl.GLuint texture) {
	gl.glBindTexture(cast(gl.GLenum)target, texture);
}

void glDeleteTextures(gl.GLuint[] textures) {
	gl.glDeleteTextures(cast(uint)textures.length, textures.ptr);
}

void glDeleteTextures(gl.GLuint texture) {
	gl.glDeleteTextures(1, &texture);
}

void glGenTextures(out gl.GLuint texture) {
	gl.glGenTextures(1, &texture);
}

void glGenTextures(gl.GLsizei n, out gl.GLuint[] textures) {
	gl.glGenTextures(n, textures.ptr);
}

bool glIsTexture(gl.GLuint texture) {
	return cast(bool)gl.glIsTexture(texture);
}

/*
 * OpenGL 1.2
 */

enum BlendMode {
	FuncAdd = gl.GL_FUNC_ADD,
	FuncSubtract = gl.GL_FUNC_SUBTRACT,
	FuncReverseSubtract = gl.GL_FUNC_REVERSE_SUBTRACT,
	Min = gl.GL_MIN,
	Max = gl.GL_MAX
}

enum TextureTargets {
	Texture3D = gl.GL_TEXTURE_3D,
	ProxyTexture3D = gl.GL_PROXY_TEXTURE_3D,
	Texture2DArray = gl.GL_TEXTURE_2D_ARRAY,
	ProxyTexture2DArray = gl.GL_PROXY_TEXTURE_2D_ARRAY
}

enum SubTextureTargets {
	Texture3D = gl.GL_TEXTURE_3D,
	Texture2DArray = gl.GL_TEXTURE_2D_ARRAY,
}

enum PixelFormat {
	Red = gl.GL_RED,
	RG = gl.GL_RG,
	RGB = gl.GL_RGB,
	BGR = gl.GL_BGR,
	RGBA = gl.GL_RGBA,
	BGRA = gl.GL_BGRA,
	RedInteger = gl.GL_RED_INTEGER,
	RG_Integer = gl.GL_RG_INTEGER,
	RGB_Integer = gl.GL_RGB_INTEGER,
	BGR_Integer = gl.GL_BGR_INTEGER,
	RGBA_Integer = gl.GL_RGBA_INTEGER,
	BGRA_Integer = gl.GL_BGRA_INTEGER,
	StencilIndex = gl.GL_STENCIL_INDEX,
	DepthComponent = gl.GL_DEPTH_COMPONENT,
	DepthStencil = gl.GL_DEPTH_STENCIL
}

enum PixelSubTextureFormat {
	Red = gl.GL_RED,
	RG = gl.GL_RG,
	RGB = gl.GL_RGB,
	BGR = gl.GL_BGR,
	RGBA = gl.GL_RGBA,
	StencilIndex = gl.GL_STENCIL_INDEX,
	DepthComponent = gl.GL_DEPTH_COMPONENT
}

enum PixelDataType {
	UByte = gl.GL_UNSIGNED_BYTE,
	Byte = gl.GL_BYTE,
	UShort = gl.GL_UNSIGNED_SHORT,
	Short = gl.GL_SHORT,
	UInt = gl.GL_UNSIGNED_INT,
	Int = gl.GL_INT,
	Float = gl.GL_FLOAT,
	UByte332 = gl.GL_UNSIGNED_BYTE_3_3_2,
	UByte233Rev = gl.GL_UNSIGNED_BYTE_2_3_3_REV,
	UShort565 = gl.GL_UNSIGNED_SHORT_5_6_5,
	UShort565Rev = gl.GL_UNSIGNED_SHORT_5_6_5,
	UShort4444 = gl.GL_UNSIGNED_SHORT_4_4_4_4,
	UShort4444Rev = gl.GL_UNSIGNED_SHORT_4_4_4_4_REV,
	UShort5551 = gl.GL_UNSIGNED_SHORT_5_5_5_1,
	UShort1555Rev = gl.GL_UNSIGNED_SHORT_1_5_5_5_REV,
	UInt8888 = gl.GL_UNSIGNED_INT_8_8_8_8,
	UInt8888Rev = gl.GL_UNSIGNED_INT_8_8_8_8_REV,
	UInt101010102 = gl.GL_UNSIGNED_INT_10_10_10_2,
	UINT2101010REV = gl.GL_UNSIGNED_INT_2_10_10_10_REV
}

void glBlendColor(ubyte r, ubyte g, ubyte b, ubyte a) {
	gl.glBlendColor(r / 255f, g / 255f, b / 255f, a / 255f);
}

void glBlendEquation(BlendMode mode) {
	gl.glBlendEquation(cast(gl.GLenum)mode);
}

void glDrawRangeElements(Primitives mode, gl.GLuint start, gl.GLuint end, ubyte[] data) {
	gl.glDrawRangeElements(cast(gl.GLenum)mode, start, end, cast(uint)data.length, gl.GL_UNSIGNED_BYTE, data.ptr);
}

void glDrawRangeElements(Primitives mode, gl.GLuint start, gl.GLuint end, ushort[] data) {
	gl.glDrawRangeElements(cast(gl.GLenum)mode, start, end, cast(uint)data.length, gl.GL_UNSIGNED_SHORT, data.ptr);
}

void glDrawRangeElements(Primitives mode, gl.GLuint start, gl.GLuint end, uint[] data) {
	gl.glDrawRangeElements(cast(gl.GLenum)mode, start, end, cast(uint)data.length, gl.GL_UNSIGNED_INT, data.ptr);
}

void glTexImage3D(TextureTargets target, gl.GLint level, InternalFormat internalFormat, gl.GLsizei width, gl.GLsizei height, gl.GLsizei depth, PixelFormat format, PixelDataType type, void[] data) {
	gl.glTexImage3D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, depth, 0, cast(gl.GLenum)format, cast(gl.GLenum)type, data.ptr);
}

void glTexSubImage3D(SubTextureTargets target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint zoffset, gl.GLsizei width, gl.GLsizei height, gl.GLsizei depth, PixelSubTextureFormat format, PixelDataType type, void[] data) {
	gl.glTexSubImage3D(cast(gl.GLenum)target, level, xoffset, yoffset, zoffset, width, height, depth, cast(gl.GLenum)format, cast(gl.GLenum)type, data.ptr);
}

void glCopyTexSubImage3D(SubTextureTargets target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint zoffset, gl.GLint x, gl.GLint y, gl.GLsizei width, gl.GLsizei height) {
	gl.glCopyTexSubImage3D(cast(gl.GLenum)target, level, xoffset, yoffset, zoffset, x, y, width, height);
}

/*
 * OpenGL 1.3
 */

enum TextureTargets2D {
	Texture2D = gl.GL_TEXTURE_2D,
	ProxyTexture2D = gl.GL_PROXY_TEXTURE_2D,
	Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
	ProxyTexture1DArray = gl.GL_PROXY_TEXTURE_1D_ARRAY,
	TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapNegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
	ProxyTextureCubeMap = gl.GL_PROXY_TEXTURE_CUBE_MAP
}

enum TextureTargets1D {
	Texture1D = gl.GL_TEXTURE_1D,
	ProxyTexture1D = gl.GL_PROXY_TEXTURE_1D
}

enum CompressedTextureTargets {
	Texture1D = gl.GL_TEXTURE_1D,
	Texture2D = gl.GL_TEXTURE_2D,
	Texture3D = gl.GL_TEXTURE_3D,
	TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
	TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
	TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
	TextureCubeMapnegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
	TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
	TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

void glActiveTexture(gl.GLenum texture) {
	gl.glActiveTexture(texture);
}

void glSampleCoverage(gl.GLfloat value, bool invert)
in {
	assert(value <= 1);
	assert(value >= 0);
} body {
	gl.glSampleCoverage(value, cast(gl.GLboolean)invert);
}

void glCompressedTexImage3D(TextureTargets target, gl.GLint level, InternalFormat internalFormat, gl.GLsizei width, gl.GLsizei height, gl.GLsizei depth, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage3D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, depth, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage2D(TextureTargets2D target, gl.GLint level, InternalFormat internalFormat, gl.GLsizei width, gl.GLsizei height, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage1D(TextureTargets1D target, gl.GLint level, InternalFormat internalFormat, gl.GLsizei width, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexImage1D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage3D(gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLint zoffset, gl.GLsizei width, gl.GLsizei height, gl.GLsizei depth, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage3D(gl.GL_TEXTURE_3D, level, xoffset, yoffset, zoffset, width, height, depth, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage2D(CompressedTextureTargets2D target, gl.GLint level, gl.GLint xoffset, gl.GLint yoffset, gl.GLsizei width, gl.GLsizei height, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage2D(cast(gl.GLenum)target, level, xoffset, yoffset, width, height, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage1D(gl.GLint level, gl.GLint xoffset, gl.GLsizei width, InternalFormat internalFormat, void[] data)
in {
	assert(level >= 0);
} body {
	gl.glCompressedTexSubImage1D(gl.GL_TEXTURE_1D, level, xoffset, width, internalFormat, cast(uint)data.length, data.ptr);
}

void glGetCompressedTexImage(CompressedTextureTargets target, gl.GLint lod, out void[] image) {
	gl.glGetCompressedTexImage(cast(gl.GLenum)target, lod, image.ptr);
}

/**
 * Opengl 1.4
 */

enum BlendFactors {
	Zero = gl.GL_ZERO,
	One = gl.GL_ONE,
	SrcColor = gl.GL_SRC_COLOR,
	OneMinusSrcColor = gl.GL_ONE_MINUS_SRC_COLOR,
	DstColor = gl.GL_DST_COLOR,
	OneMinusDstColor = gl.GL_ONE_MINUS_DST_COLOR,
	SrcAlpha = gl.GL_SRC_ALPHA,
	OneMinusSrcAlpha = gl.GL_ONE_MINUS_SRC_ALPHA,
	DstAlpha = gl.GL_DST_ALPHA,
	OneMinusDstAlpha = gl.GL_ONE_MINUS_DST_ALPHA,
	ConstantColor = gl.GL_CONSTANT_COLOR,
	OneMinusConstantColor = gl.GL_ONE_MINUS_CONSTANT_COLOR,
	ConstantAlpha = gl.GL_CONSTANT_ALPHA,
	OneMinusConstantAlpha = gl.GL_ONE_MINUS_CONSTANT_ALPHA,
	SrcAlphaSaturate = gl.GL_SRC_ALPHA_SATURATE,
	Src2Color = gl.GL_SRC1_COLOR
}

enum PointParamaterNames {
	FadeThresholdSize = gl.GL_POINT_FADE_THRESHOLD_SIZE,
	SpriteCoordOrigin = gl.GL_POINT_SPRITE_COORD_ORIGIN
}

void glBlendFuncSeparate(BlendFactors srcRGB, BlendFactors dstRGB, BlendFactors srcAlpha, BlendFactors dstAlpha) {
	gl.glBlendFuncSeparate(cast(gl.GLenum)srcRGB, cast(gl.GLenum)dstRGB, cast(gl.GLenum)srcAlpha, cast(gl.GLenum)dstAlpha);
}

void glMultiDrawArrays(Primitives mode, gl.GLint[] first, gl.GLsizei[] count)
in {
	assert(first.length == count.length);
} body {
	gl.glMultiDrawArrays(cast(gl.GLenum)mode, first.ptr, count.ptr, cast(uint)first.length);
}

void glMultiDrawElements(Primitives mode, gl.GLsizei[] count, ubyte[] indices) {
	gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_BYTE, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, gl.GLsizei[] count, ushort[] indices) {
	gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_SHORT, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, gl.GLsizei[] count, uint[] indices) {
	gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_INT, indices.ptr, cast(uint)indices.length);
}

void glPointParameterf(PointParamaterNames pname, gl.GLfloat param) {
	gl.glPointParameterf(cast(gl.GLenum)pname, param);
}

void glPointParameterfv(PointParamaterNames pname, gl.GLfloat[] params) {
	gl.glPointParameterfv(cast(gl.GLenum)pname, params.ptr);
}

void glPointParameteri(PointParamaterNames pname, gl.GLint param) {
	gl.glPointParameterf(cast(gl.GLenum)pname, param);
}

void glPointParameteriv(PointParamaterNames pname, gl.GLint[] params) {
	gl.glPointParameteriv(cast(gl.GLenum)pname, params.ptr);
}

/**
 * Opengl 1.5
 */

enum QueryTargets {
	SamplesPassed = gl.GL_SAMPLES_PASSED,
	AnySamplesPassed = gl.GL_ANY_SAMPLES_PASSED,
	AnySamplesPassedConservative = gl.GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
	PrimitivesGenerated = gl.GL_PRIMITIVES_GENERATED,
	TransformFeedbackPrimitivesWritten = gl.GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
	TimeElapsed = gl.GL_TIME_ELAPSED
}

enum QueryTarget {
	SamplesPassed = gl.GL_SAMPLES_PASSED,
	AnySamplesPassed = gl.GL_ANY_SAMPLES_PASSED,
	AnySamplesPassedConservative = gl.GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
	PrimitivesGenerated = gl.GL_PRIMITIVES_GENERATED,
	TransformFeedbackPrimitivesWritten = gl.GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
	TimeElapsed = gl.GL_TIME_ELAPSED,
	TimeStamp = gl.GL_TIMESTAMP
}

enum QueryNames {
	CurrentQuery = gl.GL_CURRENT_QUERY,
	QueryCounterBits = gl.GL_QUERY_COUNTER_BITS
}

enum QueryResultNames {
	Result = gl.GL_QUERY_RESULT,
	ResultAvailable = gl.GL_QUERY_RESULT_AVAILABLE
}

enum BindBufferTargets {
	ArrayBuffer = gl.GL_ARRAY_BUFFER,
	AtomicCounterBuffer = gl.GL_ATOMIC_COUNTER_BUFFER,
	CopyReadBuffer = gl.GL_COPY_READ_BUFFER,
	CopyWriteBuffer = gl.GL_COPY_WRITE_BUFFER,
	DrawIndirectBuffer = gl.GL_DRAW_INDIRECT_BUFFER,
	DispatchIndirectBuffer = gl.GL_DISPATCH_INDIRECT_BUFFER,
	ElementArrayBuffer = gl.GL_ELEMENT_ARRAY_BUFFER,
	PixelPackBuffer = gl.GL_PIXEL_PACK_BUFFER,
	PixelUnpackBuffer = gl.GL_PIXEL_UNPACK_BUFFER,
	// NOT SUPPORTED QueryBuffer = gl.GL_QUERY_BUFFER,
	ShaderStorageBuffer = gl.GL_SHADER_STORAGE_BUFFER,
	TextureBuffer = gl.GL_TEXTURE_BUFFER,
	TransformFeedbackBuffer = gl.GL_TRANSFORM_FEEDBACK_BUFFER,
	UniformBuffer = gl.GL_UNIFORM_BUFFER
}

enum BufferUsages {
	StreamDraw = gl.GL_STREAM_DRAW,
	StreamRead = gl.GL_STREAM_READ,
	StreamCopy = gl.GL_STREAM_COPY,
	StaticDraw = gl.GL_STATIC_DRAW,
	StaticRead = gl.GL_STATIC_READ,
	StaticCopy = gl.GL_STATIC_COPY,
	DynamicDraw = gl.GL_DYNAMIC_DRAW,
	DynamicRead = gl.GL_DYNAMIC_READ,
	DynamicCopy = gl.GL_DYNAMIC_COPY
}

enum BufferAccess {
	ReadOnly = gl.GL_READ_ONLY,
	WriteOnly = gl.GL_WRITE_ONLY,
	ReadWrite = gl.GL_READ_WRITE
}

enum GetBufferTargets {
	ArrayBuffer = gl.GL_ARRAY_BUFFER,
	ElementArrayBuffer = gl.GL_ELEMENT_ARRAY_BUFFER
}

enum GetBufferValues {
	BufferSize = gl.GL_BUFFER_SIZE,
	BufferUsage = gl.GL_BUFFER_USAGE
}

void glGenQueries(gl.GLsizei n, out gl.GLuint[] ids) {
	gl.glGenQueries(n, ids.ptr);
}

void glGenQueries(out gl.GLuint id) {
	gl.glGenQueries(1, &id);
}

void glDeleteQueries(gl.GLsizei n, out gl.GLuint[] ids) {
	gl.glDeleteQueries(n, ids.ptr);
}

void glDeleteQueries(out gl.GLuint id) {
	gl.glDeleteQueries(1, &id);
}

gl.GLboolean glIsQuery(gl.GLuint id) {
	return gl.glIsQuery(id);
}

void glBeginQuery(QueryTargets target, gl.GLuint id) {
	gl.glBeginQuery(cast(gl.GLenum)target, id);
}

void glEndQuery(QueryTargets target) {
	gl.glEndQuery(cast(gl.GLenum)target);
}

void glGetQueryiv(QueryTarget target, QueryNames pname, gl.GLint[] params) {
	gl.glGetQueryiv(cast(gl.GLenum)target, cast(gl.GLenum)pname, params.ptr);
}

void glGetQueryObjectiv(gl.GLuint id, QueryResultNames pname, out gl.GLint[] params) {
	gl.glGetQueryObjectiv(id, cast(gl.GLenum)pname, params.ptr);
}

void glGetQueryObjectuiv(gl.GLuint id, QueryResultNames pname, out gl.GLuint[] params) {
	gl.glGetQueryObjectuiv(id, cast(gl.GLenum)pname, params.ptr);
}

void glGetQueryObjecti64v(gl.GLuint id, QueryResultNames pname, out long[] params) {
	glarb.glGetQueryObjecti64v(id, cast(gl.GLenum)pname, cast(gl.GLint64*)params.ptr);
}

void glGetQueryObjectui64v(gl.GLuint id, QueryResultNames pname, out ulong[] params) {
	glarb.glGetQueryObjectui64v(id, cast(gl.GLenum)pname, cast(gl.GLuint64*)params.ptr);
}

void glBindBuffer(BindBufferTargets target, gl.GLuint buffer) {
	gl.glBindBuffer(cast(gl.GLenum)target, buffer);
}

void glDeleteBuffers(gl.GLuint[] buffers) {
	gl.glDeleteBuffers(cast(int)buffers.length, buffers.ptr);
}

void glGenBuffers(gl.GLsizei n, out gl.GLuint[] buffers) {
	gl.glGenBuffers(n, buffers.ptr);
}

bool glIsBuffer(gl.GLuint buffer) {
	return cast(bool)gl.glIsBuffer(buffer);
}

void glBufferData(BindBufferTargets target, void[] data, BufferUsages usage) {
	gl.glBufferData(cast(gl.GLenum)target, cast(gl.GLsizeiptr)data.length, data.ptr, cast(gl.GLenum)usage);
}

void glBufferSubData(BindBufferTargets target, int offset, void[] data) {
	gl.glBufferSubData(cast(gl.GLenum)target, cast(gl.GLintptr)offset, cast(gl.GLsizeiptr)data.length, data.ptr);
}

void glGetBufferSubData(BindBufferTargets target, int offset, ref void[] data) {
	gl.glGetBufferSubData(cast(gl.GLenum)target, cast(gl.GLintptr)offset, cast(gl.GLsizeiptr)data.length, data.ptr);
}

void* glMapBuffer(BindBufferTargets target, BufferAccess access) {
	return gl.glMapBuffer(cast(gl.GLenum)target, cast(gl.GLenum)access);
}

bool glUnmapBuffer(BindBufferTargets target) {
	return cast(bool)gl.glUnmapBuffer(cast(gl.GLenum)target);
}

void glGetBufferPointerv(BindBufferTargets target, void[] params) {
	gl.glGetBufferPointerv(cast(gl.GLenum)target, gl.GL_BUFFER_MAP_POINTER, params.ptr);
}

void glGetBufferParameteriv(GetBufferTargets target, GetBufferValues value, out gl.GLint[] data) {
	gl.glGetBufferParameteriv(cast(gl.GLenum)target, value, data.ptr);
}

/**
 * Opengl 2.0
 */

enum DrawBuffers {
	None = gl.GL_NONE,
	FrontLeft = gl.GL_FRONT_LEFT,
	FrontRight = gl.GL_FRONT_RIGHT,
	BackLeft = gl.GL_BACK_LEFT,
	BackRight = gl.GL_BACK_RIGHT,
	ColorAttachment0 = gl.GL_COLOR_ATTACHMENT0
}

enum Faces {
	Front = gl.GL_FRONT,
	Back = gl.GL_BACK,
	FrontAndBack = gl.GL_FRONT_AND_BACK
}

enum FaceStencilAction {
	Keep = gl.GL_KEEP,
	Zero = gl.GL_ZERO,
	Replace = gl.GL_REPLACE,
	Incr = gl.GL_INCR,
	IncrWrap = gl.GL_INCR_WRAP,
	Decr = gl.GL_DECR,
	DecrWrap = gl.GL_DECR_WRAP,
	Invert = gl.GL_INVERT
}

enum TestFunctions {
	Never = gl.GL_NEVER,
	Less = gl.GL_LESS,
	LEqual = gl.GL_LEQUAL,
	Greater = gl.GL_GREATER,
	GEqual = gl.GL_GEQUAL,
	Equal = gl.GL_EQUAL,
	NotEqual = gl.GL_NOTEQUAL,
	Always = gl.GL_ALWAYS
}

enum ShaderTypes {
	ComputeShader = gl.GL_COMPUTE_SHADER,
	VertexShader = gl.GL_VERTEX_SHADER,
	TessControlShader = gl.GL_TESS_CONTROL_SHADER,
	TessEvaluationShader = gl.GL_TESS_EVALUATION_SHADER,
	GeometryShader = gl.GL_GEOMETRY_SHADER,
	FragmentShader = gl.GL_FRAGMENT_SHADER
}

enum AttribDataTypes {
	Float = gl.GL_FLOAT,
	FloatVec2 = gl.GL_FLOAT_VEC2,
	FloatVec3 = gl.GL_FLOAT_VEC3,
	FloatVec4 = gl.GL_FLOAT_VEC4,
	FloatMat2 = gl.GL_FLOAT_MAT2,
	FloatMat3 = gl.GL_FLOAT_MAT3,
	FloatMat4 = gl.GL_FLOAT_MAT4,
	FloatMat2x3 = gl.GL_FLOAT_MAT2x3,
	FloatMat2x4 = gl.GL_FLOAT_MAT2x4,
	FloatMat3x2 = gl.GL_FLOAT_MAT3x2,
	FloatMat3x4 = gl.GL_FLOAT_MAT3x4,
	FloatMat4x2 = gl.GL_FLOAT_MAT4x2,
	FloatMat4x3 = gl.GL_FLOAT_MAT4x3,
	Int = gl.GL_INT,
	IntVec2 = gl.GL_INT_VEC2,
	IntVec3 = gl.GL_INT_VEC3,
	IntVec4 = gl.GL_INT_VEC4,
	UInt = gl.GL_UNSIGNED_INT,
	UIntVec2 = gl.GL_UNSIGNED_INT_VEC2,
	UIntVec3 = gl.GL_UNSIGNED_INT_VEC3,
	UIntVec4 = gl.GL_UNSIGNED_INT_VEC4,
	Double = gl.GL_DOUBLE,
	DoubleVec2 = gl.GL_DOUBLE_VEC2,
	DoubleVec3 = gl.GL_DOUBLE_VEC3,
	DoubleVec4 = gl.GL_DOUBLE_VEC4,
	DoubleMat2 = gl.GL_DOUBLE_MAT2,
	DoubleMat3 = gl.GL_DOUBLE_MAT3,
	DoubleMat4 = gl.GL_DOUBLE_MAT4,
	DoubleMat2x3 = gl.GL_DOUBLE_MAT2x3,
	DoubleMat2x4 = gl.GL_DOUBLE_MAT2x4,
	DoubleMat3x2 = gl.GL_DOUBLE_MAT3x2,
	DoubleMat3x4 = gl.GL_DOUBLE_MAT3x4,
	DoubleMat4x2 = gl.GL_DOUBLE_MAT4x2,
	DoubleMat4x3 = gl.GL_DOUBLE_MAT4x3
}

enum ProgramObjects {
	DeleteStatus = gl.GL_DELETE_STATUS,
	LinkStatus = gl.GL_LINK_STATUS,
	ValidateStatus = gl.GL_VALIDATE_STATUS,
	InfoLogStatus = gl.GL_INFO_LOG_LENGTH,
	AttachedShaders = gl.GL_ATTACHED_SHADERS,
	ActiveAttributes = gl.GL_ACTIVE_ATTRIBUTES,
	ActiveAttributeMaxLength = gl.GL_ACTIVE_ATTRIBUTE_MAX_LENGTH,
	ActiveUniforms = gl.GL_ACTIVE_UNIFORMS,
	ActiveUniformMaxLength = gl.GL_ACTIVE_UNIFORM_MAX_LENGTH
}

enum ShaderObjects {
	ShaderType = gl.GL_SHADER_TYPE,
	DeleteStatus = gl.GL_DELETE_STATUS,
	CompileStatus = gl.GL_COMPILE_STATUS,
	InfoLogLength = gl.GL_INFO_LOG_LENGTH,
	ShaderSourceLength = gl.GL_SHADER_SOURCE_LENGTH
}

enum VertexAttributeNames {
	ArrayBufferBindings = gl.GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING,
	ArrayEnabled = gl.GL_VERTEX_ATTRIB_ARRAY_ENABLED,
	ArraySize = gl.GL_VERTEX_ATTRIB_ARRAY_SIZE,
	ArrayStride = gl.GL_VERTEX_ATTRIB_ARRAY_STRIDE,
	ArrayType = gl.GL_VERTEX_ATTRIB_ARRAY_TYPE,
	ArrayNormalized = gl.GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
	ArrayInteger = gl.GL_VERTEX_ATTRIB_ARRAY_INTEGER,
	ArrayDivisor = gl.GL_VERTEX_ATTRIB_ARRAY_DIVISOR,
	Current = gl.GL_CURRENT_VERTEX_ATTRIB
}

enum AttribPointerSize {
	One = 1,
	Two = 2,
	Three = 3,
	Four = 4,
	BGRA = gl.GL_BGRA
}

enum AttribPointerType {
	Byte = gl.GL_BYTE,
	UByte = gl.GL_UNSIGNED_BYTE,
	Short = gl.GL_SHORT,
	UShort = gl.GL_UNSIGNED_SHORT,
	Int = gl.GL_INT,
	UInt = gl.GL_UNSIGNED_INT,
	HalfFloat = gl.GL_HALF_FLOAT,
	Float = gl.GL_FLOAT,
	Double = gl.GL_DOUBLE,
	Fixed = gl.GL_FIXED,
	Int2101010REV = gl.GL_INT_2_10_10_10_REV, 
	UInt2101010Rev = gl.GL_UNSIGNED_INT_2_10_10_10_REV,
	UInt10F11F11FRev = gl.GL_UNSIGNED_INT_10F_11F_11F_REV 
}

void glBlendEquationSeparate(BlendMode modeRGB, BlendMode modeAlpha) {
	gl.glBlendEquationSeparate(cast(gl.GLenum)modeRGB, cast(gl.GLenum)modeAlpha);
}

void glDrawBuffers(gl.GLsizei n, DrawBuffers[] bufs) {
	gl.glDrawBuffers(n, cast(gl.GLenum*)bufs.ptr);
}

void glStencilOpSeparate(Faces face, FaceStencilAction sfail, FaceStencilAction dpfail, FaceStencilAction dppass) {
	gl.glStencilOpSeparate(cast(gl.GLenum)face, cast(gl.GLenum)sfail, cast(gl.GLenum)dpfail, cast(gl.GLenum)dppass);
}

void glStencilFuncSeparate(Faces face, TestFunctions func, gl.GLint ref_, gl.GLuint mask) {
	gl.glStencilFuncSeparate(cast(gl.GLenum)face, cast(gl.GLenum)func, ref_, mask);
}

void glStencilMaskSeparate(Faces face, gl.GLuint mask) {
	gl.glStencilMaskSeparate(cast(gl.GLenum)face, mask);
}

void glAttachShader(gl.GLuint program, gl.GLuint shader) {
	gl.glAttachShader(program, shader);
}

void glBindAttribLocation(gl.GLuint program, gl.GLuint index, string name) {
	gl.glBindAttribLocation(program, index, (name ~ 0).ptr);
}

void glCompileShader(gl.GLuint shader) {
	gl.glCompileShader(shader);
}

gl.GLuint glCreateProgram() {
	return gl.glCreateProgram();
}

gl.GLuint glCreateShader(ShaderTypes shaderType) {
	return gl.glCreateShader(cast(gl.GLenum)shaderType);
}

void glDeleteProgram(gl.GLuint program) {
	gl.glDeleteProgram(program);
}

void glDeleteShader(gl.GLuint shader) {
	gl.glDeleteShader(shader);
}

void glDetachShader(gl.GLuint program, gl.GLuint shader) {
	gl.glDetachShader(program, shader);
}

void glDisableVertexAttribArray(gl.GLuint index) {
	gl.glDisableVertexAttribArray(index);
}

void glEnableVertexAttribArray(gl.GLuint index) {
	gl.glEnableVertexAttribArray(index);
}

void glGetActiveAttrib(gl.GLuint program, gl.GLuint index, out gl.GLint* size, out AttribDataTypes type, out string name) {
	gl.glGetActiveAttrib(program, index, int.max,  cast(int*)null, size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetActiveUniform(gl.GLuint program, gl.GLuint index, out gl.GLint size, out AttribDataTypes type, out string name) {
	gl.glGetActiveUniform(program, index, int.max,  cast(int*)null, &size, cast(gl.GLenum*)&type, cast(char*)name.ptr);
	name = name[0 .. $-1];
}

void glGetAttachedShaders(gl.GLuint program, out gl.GLuint[] shaders) {
	gl.GLsizei* count;
	gl.glGetAttachedShaders(program, int.max, count, shaders.ptr);
}

gl.GLint glGetAttribLocation(gl.GLuint program, string name) {
	return gl.glGetAttribLocation(program, (name ~ 0).ptr);
}

void glGetProgramiv(gl.GLuint program, ProgramObjects pname, out gl.GLint[] params) {
	gl.glGetProgramiv(program, cast(gl.GLenum)pname, params.ptr);
}

void glGetProgramInfoLog(gl.GLuint program, out string infoLog) {
	gl.GLsizei* length;
	gl.glGetProgramInfoLog(program, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderiv(gl.GLuint shader, ShaderObjects pname, out gl.GLint[] params) {
	gl.glGetShaderiv(shader, cast(gl.GLenum)pname, params.ptr);
}

void glGetShaderInfoLog(gl.GLuint shader, string infoLog) {
	gl.GLsizei* length;
	gl.glGetShaderInfoLog(shader, int.max, length, cast(char*)infoLog.ptr);
	infoLog = infoLog[0 .. $-1];
}

void glGetShaderSource(gl.GLuint shader, out string source) {
	gl.GLsizei* length;
	gl.glGetShaderInfoLog(shader, int.max, length, cast(char*)source.ptr);
	source = source[0 .. $-1];
}

gl.GLint glGetUniformLocation(gl.GLuint program, string name) {
	return gl.glGetUniformLocation(program, cast(char*)(name ~ 0).ptr);
}

void glGetUniformfv(gl.GLuint program, gl.GLint location, gl.GLfloat[] params) {
	gl.glGetUniformfv(program, location, params.ptr);
}

void glGetUniformiv(gl.GLuint program, gl.GLint location, gl.GLint[] params) {
	gl.glGetUniformiv(program, location, params.ptr);
}

void glGetVertexAttribdv(gl.GLuint index, VertexAttributeNames pname, gl.GLdouble[] params) {
	gl.glGetVertexAttribdv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttribfv(gl.GLuint index, VertexAttributeNames pname, gl.GLfloat[] params) {
	gl.glGetVertexAttribfv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttribiv(gl.GLuint index, VertexAttributeNames pname, gl.GLint[] params) {
	gl.glGetVertexAttribiv(index, cast(gl.GLenum)pname, params.ptr);
}

void glGetVertexAttribPointerv(gl.GLuint index, out gl.GLvoid*[] pointer) {
	gl.glGetVertexAttribPointerv(index, gl.GL_VERTEX_ATTRIB_ARRAY_POINTER, pointer.ptr);
}

bool glIsProgram(gl.GLuint program) {
	return cast(bool)gl.glIsProgram(program);
}

bool glIsShader(gl.GLuint shader) {
	return cast(bool)gl.glIsShader(shader);
}

void glLinkProgram(gl.GLuint program) {
	gl.glLinkProgram(program);
}

void glShaderSource(gl.GLuint shader, string _string) {
	if (_string[$-1] != 0) _string ~= 0;
	size_t length = _string.length;
	auto str = _string.ptr;
	gl.glShaderSource(shader, 1, cast(const(gl.GLchar*)*)&str, cast(const(gl.GLint)*)&length);
}

void glUseProgram(gl.GLuint program) {
	gl.glUseProgram(program);
}

void glUniform1f(gl.GLint location, gl.GLfloat v0) {
	gl.glUniform1f(location, v0);
}

void glUniform2f(gl.GLint location, gl.GLfloat v0, gl.GLfloat v1) {
	gl.glUniform2f(location, v0, v1);
}

void glUniform3f(gl.GLint location, gl.GLfloat v0, gl.GLfloat v1, gl.GLfloat v2) {
	gl.glUniform3f(location, v0, v1, v2);
}

void glUniform4f(gl.GLint location, gl.GLfloat v0, gl.GLfloat v1, gl.GLfloat v2, gl.GLfloat v3) {
	gl.glUniform4f(location, v0, v1, v2, v3);
}

void glUniform1i(gl.GLint location, gl.GLint v0) {
	gl.glUniform1i(location, v0);
}

void glUniform2i(gl.GLint location, gl.GLint v0, gl.GLint v1) {
	gl.glUniform2i(location, v0, v1);
}

void glUniform3i(gl.GLint location, gl.GLint v0, gl.GLint v1, gl.GLint v2) {
	gl.glUniform3i(location, v0, v1, v2);
}

void glUniform4i(gl.GLint location, gl.GLint v0, gl.GLint v1, gl.GLint v2, gl.GLint v3) {
	gl.glUniform4i(location, v0, v1, v2, v3);
}

void glUniform1fv(gl.GLint location, gl.GLfloat[] value) {
	gl.glUniform1fv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform2fv(gl.GLint location, gl.GLfloat[] value) {
	gl.glUniform2fv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform3fv(gl.GLint location, gl.GLfloat[] value) {
	gl.glUniform3fv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform4fv(gl.GLint location, gl.GLfloat[] value) {
	gl.glUniform4fv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform1iv(gl.GLint location, gl.GLint[] value) {
	gl.glUniform1iv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform2iv(gl.GLint location, gl.GLint[] value) {
	gl.glUniform2iv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform3iv(gl.GLint location, gl.GLint[] value) {
	gl.glUniform3iv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform4iv(gl.GLint location, gl.GLint[] value) {
	gl.glUniform4iv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform1uiv(gl.GLint location, gl.GLuint[] value) {
	gl.glUniform1uiv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform2uiv(gl.GLint location, gl.GLuint[] value) {
	gl.glUniform2uiv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform3uiv(gl.GLint location, gl.GLuint[] value) {
	gl.glUniform3uiv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniform4uiv(gl.GLint location, gl.GLuint[] value) {
	gl.glUniform4uiv(location, cast(gl.GLsizei)value.length, value.ptr);
}

void glUniformMatrix2fv(gl.GLint location, bool transpose, gl.GLfloat[] value) {
	gl.glUniformMatrix2fv(location, cast(gl.GLint)(value.length / 4), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glUniformMatrix3fv(gl.GLint location, bool transpose, gl.GLfloat[] value) {
	gl.glUniformMatrix3fv(location, cast(gl.GLint)(value.length / 9), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glUniformMatrix4fv(gl.GLint location, bool transpose, gl.GLfloat[] value) {
	gl.glUniformMatrix4fv(location, cast(gl.GLint)(value.length / 16), cast(ubyte)(transpose ? gl.GL_TRUE : gl.GL_FALSE), value.ptr);
}

void glValidateProgram(gl.GLuint program) {
	gl.glValidateProgram(program);
}

void glVertexAttrib1d(gl.GLuint index, gl.GLdouble v0) {
	gl.glVertexAttrib1d(index, v0);
}

void glVertexAttrib1dv(gl.GLuint index, gl.GLdouble v) {
	gl.glVertexAttrib1dv(index, &v);
}

void glVertexAttrib1f(gl.GLuint index, gl.GLfloat v) {
	gl.glVertexAttrib1f(index, v);
}

void glVertexAttrib1fv(gl.GLuint index, gl.GLfloat v) {
	gl.glVertexAttrib1fv(index, &v);
}

void glVertexAttrib1s(gl.GLuint index, gl.GLshort v0) {
	gl.glVertexAttrib1s(index, v0);
}

void glVertexAttrib1sv(gl.GLuint index, gl.GLshort v0) {
	gl.glVertexAttrib1sv(index, &v0);
}

void glVertexAttrib2d(gl.GLuint index, gl.GLdouble v0, gl.GLdouble v1) {
	gl.glVertexAttrib2d(index, v0, v1);
}

void glVertexAttrib2dv(gl.GLuint index, gl.GLdouble[2] v) {
	gl.glVertexAttrib2dv(index, v.ptr);
}

void glVertexAttrib2f(gl.GLuint index, gl.GLfloat v0, gl.GLfloat v1) {
	gl.glVertexAttrib2f(index, v0, v1);
}

void glVertexAttrib2fv(gl.GLuint index, gl.GLfloat[2] v) {
	gl.glVertexAttrib2fv(index, v.ptr);
}

void glVertexAttrib2s(gl.GLuint index, gl.GLshort v0, gl.GLshort v1) {
	gl.glVertexAttrib2s(index, v0, v1);
}

void glVertexAttrib2sv(gl.GLuint index, gl.GLshort[2] v) {
	gl.glVertexAttrib2sv(index, v.ptr);
}

void glVertexAttrib3d(gl.GLuint index, gl.GLdouble v0, gl.GLdouble v1, gl.GLdouble v2) {
	gl.glVertexAttrib3d(index, v0, v1, v2);
}

void glVertexAttrib3dv(gl.GLuint index, gl.GLdouble[3] v) {
	gl.glVertexAttrib3dv(index, v.ptr);
}

void glVertexAttrib3f(gl.GLuint index, gl.GLfloat v0, gl.GLfloat v1, gl.GLfloat v2) {
	gl.glVertexAttrib3f(index, v0, v1, v2);
}

void glVertexAttrib3fv(gl.GLuint index, gl.GLfloat[3] v) {
	gl.glVertexAttrib3fv(index, v.ptr);
}

void glVertexAttrib3s(gl.GLuint index, gl.GLshort v0, gl.GLshort v1, gl.GLshort v2) {
	gl.glVertexAttrib3s(index, v0, v1, v2);
}

void glVertexAttrib3sv(gl.GLuint index, gl.GLshort[3] v) {
	gl.glVertexAttrib3sv(index, v.ptr);
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

void glVertexAttrib4f(gl.GLuint index, gl.GLfloat v0, gl.GLfloat v1, gl.GLfloat v2, gl.GLfloat v3) {
	gl.glVertexAttrib4f(index, v0, v1, v2, v3);
}

void glVertexAttrib4fv(gl.GLuint index, gl.GLfloat[] v) {
	gl.glVertexAttrib4fv(index, v.ptr);
}

/*
bindGLFunc(cast(void**)&glVertexAttrib4iv, "glVertexAttrib4iv");
bindGLFunc(cast(void**)&glVertexAttrib4s, "glVertexAttrib4s");
bindGLFunc(cast(void**)&glVertexAttrib4sv, "glVertexAttrib4sv");
bindGLFunc(cast(void**)&glVertexAttrib4ubv, "glVertexAttrib4ubv");
bindGLFunc(cast(void**)&glVertexAttrib4uiv, "glVertexAttrib4uiv");
bindGLFunc(cast(void**)&glVertexAttrib4usv, "glVertexAttrib4usv");*/

void glVertexAttribPointer(gl.GLuint index, AttribPointerSize size, AttribPointerType type, bool normalized, gl.GLsizei stride, gl.GLvoid* pointer) {
	gl.glVertexAttribPointer(index, size, type, normalized ? gl.GL_TRUE : gl.GL_FALSE, stride, pointer);
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