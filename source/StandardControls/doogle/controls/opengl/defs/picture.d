module doogle.controls.opengl.defs.picture;
import doogle.controls.control;
import doogle.controls.defs.picture;
import doogle.drawing.image;
import doogle.window.component;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
import doogle.events.event;
import doogle.events.types;
import glwrap = doogle.overloads.wrappers;
import doogle.window.window;
import doogle.controls.all;
import doogle.controls.font;

enum CaptionVisiblity {
	MouseOver,
	Always
}

shared class Picture : Control, Picture_Def {
	protected {
		Image image_;
		Texture texture_;
		Label captionLbl_;
		CaptionVisiblity captionVisibility_ = CaptionVisiblity.MouseOver;
		
		ShaderProgram program;
		StandardBuffer vertices;
		StandardBuffer texturemap;
		VertexArray vao;
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

		shared(Label) captionLabel() { synchronized return captionLbl_;	}

		wstring caption() { synchronized return captionLbl_ !is null ? captionLbl_.text : ""w; }

		void caption(wstring value) {
			synchronized {
				if (captionLbl_ !is null)
					captionLbl_.text = value;
			}
		}

		CaptionVisiblity captionVisiblity() {
			synchronized return captionVisibility_;
		}

		void captionVisiblity(CaptionVisiblity value) {
			synchronized captionVisibility_ = value;
		}

		override void font(shared(Font) f) {
			synchronized {
				if (captionLbl_ is null)
					captionLbl_ = new shared Label(parent_, _x, _y, ""w, f);
				else
					captionLbl_.font = f;
			}
		}
	}

	override void redraw(shared(Window) window) {
		if (visible) {
			super.redraw(window);
			
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

				program.uniform("move", move_);
				program.uniform("scale", scale_);
				program.uniform("transform", transform_parent_);
				glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);
			}

			if (captionVisibility_ == CaptionVisiblity.MouseOver) {
				if (_mouseOver) {
					// show caption
					if (captionLbl_ !is null)
						captionLbl_.visible = true;
				} else {
					// hide caption
					if (captionLbl_ !is null)
						captionLbl_.visible = false;
				}
			} else {
				if (captionLbl_ !is null)
					captionLbl_.visible = true;
			}
		}
	}
}
