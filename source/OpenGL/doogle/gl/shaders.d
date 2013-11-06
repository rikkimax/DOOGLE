module doogle.gl.shaders;
import gl = derelict.opengl3.gl3;
import glwrap = doogle.overloads.wrappers;
import doogle.util.storage;
import std.algorithm : filter, move;
import std.string : indexOf;
import gl3n.linalg;

shared class ShaderProgram {
	protected {
		uint id_;
		Shader[] shaders;
	}

	this(string vert, string frag=null, string geom=null) {
		if (frag is null)
			this(new shared Shader(vert, glwrap.ShaderTypes.VertexShader), null, null);
		else if (geom is null)
			this(new shared Shader(vert, glwrap.ShaderTypes.VertexShader), new shared Shader(frag, glwrap.ShaderTypes.FragmentShader), null);
		else
			this(new shared Shader(vert, glwrap.ShaderTypes.VertexShader), new shared Shader(frag, glwrap.ShaderTypes.FragmentShader), new shared Shader(geom, glwrap.ShaderTypes.GeometryShader));
	}

	this(shared(Shader) vert=null, shared(Shader) frag=null, shared(Shader) geom=null) {
		// allocate the program
		id_ = glwrap.glCreateProgram();
		if (vert !is null)
			attach(vert, false);
		if (frag !is null)
			attach(frag, false);
		if (geom !is null)
			attach(geom, false);
		link();
		bind();
	}

	~this() {
		synchronized {
			// destroy the program
			glwrap.glDeleteProgram(id_);
		}
	}

	void attach(shared(Shader) shader, bool linkCall = true) {
		synchronized {
			shaders ~= shader;
			// attach the shader
			glwrap.glAttachShader(cast(uint)id_, cast(uint)shader);
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
			glwrap.glDetachShader(cast(uint)id_, cast(uint)shader);
			link();
		}
	}

	uint getAttribute(string name) {
		synchronized {
			return glwrap.glGetAttribLocation(cast(uint)id_, name);
		}
	}

	uint getUniform(string name) {
		synchronized {
			return glwrap.glGetUniformLocation(cast(uint)id_, name);
		}
	}

	uint opCast(T:uint)() {
		synchronized {
			return cast(uint)id_;
		}
	}

	void bind() {
		synchronized {
			glwrap.glUseProgram(id_);
		}
	}

	void uniform(string name, shared(mat2) value, bool transpose = false) {
		synchronized {
			bind();
			glwrap.glUniformMatrix2fv(getUniform(name), transpose, cast(float[])value.matrix);
		}
	}

	void uniform(string name, shared(mat3) value, bool transpose = false) {
		synchronized {
			bind();
			glwrap.glUniformMatrix3fv(getUniform(name), transpose, cast(float[])value.matrix);
		}
	}

	void uniform(string name, shared(mat4) value, bool transpose = false) {
		synchronized {
			bind();
			glwrap.glUniformMatrix4fv(getUniform(name), transpose, cast(float[])value.matrix);
		}
	}

	void uniform(string name, shared(vec2) value) {
		synchronized {
			bind();
			glwrap.glUniform2fv(getUniform(name), cast(float[])value.vector);
		}
	}

	void uniform(string name, shared(vec3) value) {
		synchronized {
			bind();
			glwrap.glUniform3fv(getUniform(name), cast(float[])value.vector);
		}
	}

	void uniform(string name, shared(vec4) value) {
		synchronized {
			bind();
			glwrap.glUniform4fv(getUniform(name), cast(float[])value.vector);
		}
	}

	void uniform(string name, float[2] value) {
		synchronized {
			bind();
			glwrap.glUniform2fv(getUniform(name), value);
		}
	}

	void uniform(string name, float[4] value) {
		synchronized {
			bind();
			glwrap.glUniform4fv(getUniform(name), value);
		}
	}
	
	void uniform(string name, bool value) {
		synchronized {
			bind();
			glwrap.glUniform1i(getUniform(name), value);
		}
	}

	void uniform(string name, int[2] value) {
		synchronized {
			bind();
			glwrap.glUniform2iv(getUniform(name), value);
		}
	}
	
	void uniform(string name, int[4] value) {
		synchronized {
			bind();
			glwrap.glUniform4iv(getUniform(name), value);
		}
	}
	
	void uniform(string name, int value) {
		synchronized {
			bind();
			glwrap.glUniform1i(getUniform(name), value);
		}
	}

	protected {
		void link() {
			synchronized {
				glwrap.glLinkProgram(id_);

				int res;
				gl.glGetProgramiv(id_, gl.GL_LINK_STATUS, &res);
				if (res == gl.GL_FALSE)
					throw new Exception(getInfoLog());
			}
		}

		string getInfoLog() {
			int res;
			gl.glGetProgramiv(id_, gl.GL_INFO_LOG_LENGTH, &res);
			
			if (res > 0) {
				char* infoLog;
				gl.glGetProgramInfoLog(id_, res, &res, infoLog);
				return *(cast(string*)infoLog);
			}
			return "";
		}
	}

	/**
	 * Add uniform infromation get/set
	 */
}

shared class Shader {
	protected {
		//ShaderObj id_;
		uint id_;
		string source = null;
		glwrap.ShaderTypes type;
	}

	/**
	 * Given either the source or filename(asset loader).
	 */
	this(string source, glwrap.ShaderTypes type) {
		// create
		id_ = glwrap.glCreateShader(type);
		if (source.indexOf('\n') == -1) {
			// we are a file name
			string name = source;
			source = shaders.get(name);
			if (source == "") {
				throw new Exception("Could not get shader from storage " ~ name);
			} else {
				opAssign(source);
			}
		} else {
			opAssign(source);
		}
		this.type = type;
		compile();
	}

	~this() {
		synchronized {
			glwrap.glDeleteShader(id_);
		}
	}

	void opAssign()(string source) {
		synchronized {
			this.source = source;
			// assign
			glwrap.glShaderSource(id_, source);
			compile();
		}
	}

	string opCast(T : string)() {
		synchronized {
			return source;
		}
	}

	ShaderTypes opCast(T : glwrap.ShaderTypes)() {
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
				glwrap.glCompileShader(id_);

				int res;
				gl.glGetShaderiv(id_, gl.GL_COMPILE_STATUS, &res);
				if (res == gl.GL_FALSE)
					throw new Exception(getInfoLog());
			}
		}

		string getInfoLog() {
			int res;
			gl.glGetShaderiv(id_, gl.GL_INFO_LOG_LENGTH, &res);
			
			if (res > 0) {
				char* infoLog;
				gl.glGetShaderInfoLog(id_, res, &res, infoLog);
				return *(cast(string*)infoLog);
			}
			return "";
		}
	}
}

/*
 * TODO default shaders for vertices, fragment and geometry.
 * Basically meaning default behaviour i.e. they don't exist occurs.
 */