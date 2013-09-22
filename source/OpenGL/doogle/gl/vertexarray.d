module doogle.gl.vertexarray;
import doogle.gl.buffers;
import doogle.gl.shaders;
import doogle.platform;
public import doogle.overloads.wrappers : BindBufferTargets;

shared class VertexArray {
	protected {
		uint id_;
	}

	this(shared(StandardBuffer) buffer) {this(cast(uint)buffer);}

	this(uint buffer) {
		gl.glGenVertexArrays(1, cast(uint*)&id_);
		gl.glBindVertexArray(id_);
		gl.glBindBuffer(BindBufferTargets.ElementArrayBuffer, buffer);
		gl.glEnableVertexAttribArray(0);
	}

	~this() {
		gl.glDeleteVertexArrays(1, cast(uint*)&id_);
	}

	uint opCast(T:uint)() {
		return id_;
	}

	public {
		void bind() {
			gl.glBindVertexArray(id_);
		}

		void bindAttribute(shared(ShaderProgram) program, string attribute, shared(StandardBuffer) buffer, glwrap.AttribPointerType type, uint count, uint stride=0, int* offset = null) {
			buffer.bind();
			bindAttribute(program, attribute, type, count, stride, offset);
		}

		void bindAttribute(shared(ShaderProgram) program, string attribute, glwrap.AttribPointerType type, uint count, uint stride=0, int* offset = null) {
			uint attrib = program.getAttribute(attribute);
			gl.glEnableVertexAttribArray(attrib);
			gl.glVertexAttribPointer(attrib, count, type, gl.GL_FALSE, stride, offset);
		}
	}
}
