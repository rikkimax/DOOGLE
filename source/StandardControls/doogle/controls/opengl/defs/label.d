module doogle.controls.opengl.defs.label;
import doogle.controls.defs.label;
import doogle.controls.control;
import doogle.window.component;
import doogle.window.window;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
import doogle.controls.font;

shared class Label : Control, Label_Def {
	protected {
		wstring text_;
		Texture texture_;
	}

	this(shared(ComponentChildable) parent) {
		super(parent);
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY) {
		super(parent, suggestedX, suggestedY);
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, wstring _text, shared(Font) _font) {
		super(parent, suggestedX, suggestedY);
		font(_font);
		text(_text);
	}

	@property {
		wstring text() {
			synchronized return text_;
		}

		void text(wstring value) {
			synchronized {
				text_ = value;
				texture_ = font_.get(value).texture;
			}
		}
	}

	override void redraw(shared(Window) window) {
		if (_height == 0 || _width == 0) {
			if (texture_ !is null) {
				_height = texture_.height;
				_width = texture_.width;
			}
		}

		super.redraw(window);
		
		static shared ShaderProgram program;
		static shared StandardBuffer vertices;
		static shared StandardBuffer texturemap;
		static shared VertexArray vao;
		if (program is null) {
			program = new shared ShaderProgram("standard.vert", "standard.frag");
			vertices = new shared StandardBuffer("full_vertices.raw");
			texturemap = new shared StandardBuffer("full_texture_mapping.raw");
			vao = new shared VertexArray();
			vao.bindAttribute(program, "position", vertices, glwrap.AttribPointerType.Float, 2);
			vao.bindAttribute(program, "texcoord", texturemap, glwrap.AttribPointerType.Float, 2);
		}
		if (texture_ !is null) {
			texture_.bind();
			program.bind();
			
			glwrap.glUniform4fv(program.getUniform("move"), cast(float[])move.vector);
			glwrap.glUniformMatrix4fv(program.getUniform("scale"), false, cast(float[])scale.matrix);
			glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);
		}
	}
}