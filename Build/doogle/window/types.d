module doogle.window.types;
import derelict.opengl3.gl3;

enum Buffers {
	Color = GL_COLOR_BUFFER_BIT,
	Depth = GL_DEPTH_BUFFER_BIT,
	Stencil = GL_STENCIL_BUFFER_BIT
}

enum Primitives {
	Triangles = GL_TRIANGLES,
	Lines = GL_LINES,
	Points = GL_POINTS
}

enum Capabilitys {
	DepthTest = GL_DEPTH_TEST,
	StencilTest = GL_STENCIL_TEST,
	CullFace = GL_CULL_FACE,
	RasterizerDiscard = GL_RASTERIZER_DISCARD
}

enum TestFunctions {
	Never = GL_NEVER,
	Less = GL_LESS,
	LessEqual = GL_LEQUAL,
	Greater = GL_GREATER,
	GreaterEqual = GL_GEQUAL,
	Equal = GL_EQUAL,
	NotEqual = GL_NOTEQUAL,
	Always = GL_ALWAYS
}

enum StencilActions {
	Keep = GL_KEEP,
	Zero = GL_ZERO,
	Replace = GL_REPLACE,
	Increase = GL_INCR,
	IncreaseWrap = GL_INCR_WRAP,
	Decrease = GL_DECR,
	DecreaseWrap = GL_DECR_WRAP,
	Invert = GL_INVERT
}

enum WindowStyle {
	Base = 0,
	Resize = 1,
	Close = 2,
	FullScreen = 4
}