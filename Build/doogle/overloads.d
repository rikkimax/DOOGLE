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

//NOT SUPPORTED glGetQueryObjecti64v
//NOT SUPPORTED glGetQueryObjectui64v

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

void glGetBufferSubData(BindBufferTargets target, int offset, void[] data) {
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