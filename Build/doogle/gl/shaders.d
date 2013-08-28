module doogle.gl.shaders;
import doogle.overloads.structify;
import doogle.overloads.wrappers;
import std.algorithm : filter, move;

shared class ShaderProgram {
	protected {
		ProgramObj id;
		Shader[] shaders;
	}

	this(string vert, string frag=null, string geom=null) {
		if (frag is null)
			this(new shared Shader(vert, ShaderTypes.FragmentShader), null, null);
		else if (geom is null)
			this(new shared Shader(vert, ShaderTypes.FragmentShader), new shared Shader(frag, ShaderTypes.FragmentShader), null);
		else
			this(new shared Shader(vert, ShaderTypes.VertexShader), new shared Shader(frag, ShaderTypes.FragmentShader), new shared Shader(geom, ShaderTypes.GeometryShader));
	}

	this(shared(Shader) vert=null, shared(Shader) frag=null, shared(Shader) geom=null) {
		// allocate the program
		if (vert !is null)
			attach(vert, false);
		if (frag !is null)
			attach(frag, false);
		if (geom !is null)
			attach(geom, false);
		link();
	}

	~this() {
		// destroy the program
	}

	void attach(shared(Shader) shader, bool linkCall = true) {
		shaders ~= shader;
		// attach the shader
		if (linkCall)
			link();
	}

	void detach(shared(Shader) shader) {
		shared(Shader)[] ret;
		foreach (s; shaders) {
			if (s != shader)
				ret ~= s;
		}
		shaders = ret;

		link();
	}

	protected {
		void link() {

		}
	}
}

shared class Shader {
	protected {
		ShaderObj id;
		string source;
		ShaderTypes type;
	}

	this(string source, ShaderTypes type) {
		if (source is null) {
			// create
			opAssign(source);
			this.type = type;
			compile();
		}
	}

	void opAssign()(string source) {
		this.source = source;
		// assign
		compile();
	}

	shared(ShaderObj) opCast(T : ShaderObj)() {
		return id;
	}

	string opCast(T : string)() {
		return source;
	}

	ShaderTypes opCast(T : ShaderTypes)() {
		return type;
	}

	protected {
		void compile() {
			// compile
		}
	}
}

unittest {
	shared Shader s = new shared Shader(null, ShaderTypes.ComputeShader);
	s = "hi";
	assert(cast(string)s == "hi");
}

/*
 * TODO default shaders for vertices, fragment and geometry.
 * Basically meaning default behaviour i.e. they don't exist occurs.
 */