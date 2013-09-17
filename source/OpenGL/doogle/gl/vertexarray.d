module doogle.gl.vertexarray;
import doogle.gl.buffers;
import doogle.platform;
public import doogle.overloads.wrappers : BindBufferTargets;

class VertexArray {
	protected {
		uint id_;
	}

	this(StandardBuffer buffer) {this(cast(uint)buffer);}

	this(uint buffer) {
		glGenVertexArrays(1, &id_);
		glBindVertexArray(id_);
		glBindBuffer(BindBufferTargets.ElementArrayBuffer, buffer);
	}

	uint opCast(T:uint)() {
		return id_;
	}

	public {
		void bind() {
			glBindVertexArray(id_);
		}
	}
}