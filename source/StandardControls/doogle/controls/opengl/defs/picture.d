module doogle.controls.opengl.defs.picture;
import doogle.controls.control;
import doogle.controls.defs.picture;
import doogle.drawing.image;
import doogle.window.component;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
import glwrap = doogle.overloads.wrappers;
import doogle.window.window;

shared class Picture : Control, Picture_Def {
	protected {
		Image image_;
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

	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight, shared(Image) _image) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
		image(_image);
	}

	@property {
		shared(Image_OpenGL) image() {
			synchronized {
				return image_;
			}
		}

		void image(shared(Image) value) {
			synchronized  {
				image_ = value;
				texture_ = image_.texture;
			}
		}
	}

	override void redraw(shared(Window) window) {
		super.redraw(window);

		static shared ShaderProgram program;
		static shared StandardBuffer vertices;
		static shared StandardBuffer texturemap;
		static shared VertexArray vao;
		if (program is null) {
			program = new shared ShaderProgram("picture.vert", "picture.frag");
			vertices = new shared StandardBuffer("full_vertices.raw");
			texturemap = new shared StandardBuffer("full_texture_mapping.raw");
			vao = new shared VertexArray();
			vao.bindAttribute(program, "position", vertices, glwrap.AttribPointerType.Float, 2);
			vao.bindAttribute(program, "texcoord", texturemap, glwrap.AttribPointerType.Float, 2);
		}
		if (texture_ !is null) {
			texture_.bind();
			program.bind();

			program.uniform("move", move);
			program.uniform("scale", scale);
			program.uniform("transform", transform_parent_);
			glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);
		}
	}
}
