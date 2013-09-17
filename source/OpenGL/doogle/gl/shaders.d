module doogle.gl.shaders;
import doogle.overloads.structify;
import doogle.overloads.wrappers;
import std.algorithm : filter, move;

shared class ShaderProgram {
	protected {
		ProgramObj id_;
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
		glCreateProgram(id_);
		if (vert !is null)
			attach(vert, false);
		if (frag !is null)
			attach(frag, false);
		if (geom !is null)
			attach(geom, false);
		link();
	}

	~this() {
		synchronized {
			// destroy the program
			glDeleteProgram(id_);
		}
	}

	shared(ProgramObj) opCast(T : ProgramObj)() {
		synchronized {
			return id_;
		}
	}

	void attach(shared(Shader) shader, bool linkCall = true) {
		synchronized {
			shaders ~= shader;
			// attach the shader
			glAttachShader(cast(uint)id_, cast(uint)shader);
			if (linkCall)
				link();
		}
	}

	void detach(shared(Shader) shader) {
		synchronized {
			shared(Shader)[] ret;
			foreach (s; shaders) {
				if (s != shader)
					ret ~= s;
			}
			shaders = ret;
			glDetachShader(cast(uint)id_, cast(uint)shader);
			link();
		}
	}

	uint getAttribute(string name) {
		return glGetAttribLocation(cast(uint)id_, name);
	}

	uint getUniform(string name) {
		return glGetUniformLocation(cast(uint)id_, name);
	}

	uint opCast(T:uint)() {
		synchronized {
			return cast(uint)id_;
		}
	}

	protected {
		void link() {
			synchronized {
				glLinkProgram(id_);
			}
		}
	}

	/**
	 * Add uniform infromation get/set
	 */
}

shared class Shader {
	protected {
		ShaderObj id_;
		string source = null;
		ShaderTypes type;
	}

	this(string source, ShaderTypes type) {
		// create
		glCreateShader(type, id_);
		opAssign(source);
		this.type = type;
		compile();
	}

	~this() {
		synchronized {
			glDeleteShader(id_);
		}
	}

	void opAssign()(string source) {
		synchronized {
			this.source = source;
			// assign
			glShaderSource(id_, source);
			compile();
		}
	}

	shared(ShaderObj) opCast(T : ShaderObj)() {
		synchronized {
			return id_;
		}
	}

	string opCast(T : string)() {
		synchronized {
			return source;
		}
	}

	ShaderTypes opCast(T : ShaderTypes)() {
		synchronized {
			return type;
		}
	}

	uint opCast(T:uint)() {
		synchronized {
			return cast(uint)id_;
		}
	}

	protected {
		void compile() {
			synchronized {
				// compile
				glCompileShader(id_);
			}
		}
	}
}

/*
 * TODO default shaders for vertices, fragment and geometry.
 * Basically meaning default behaviour i.e. they don't exist occurs.
 */