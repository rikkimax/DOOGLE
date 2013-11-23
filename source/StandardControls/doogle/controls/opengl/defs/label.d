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
public import doogle.util.color : Color3, Color, Color4;

shared class Label : Control, Label_Def {
	protected {
		wstring text_;
		Texture texture_;
		Color3 color_;
		Color4 background_;
		
		ShaderProgram program;
		StandardBuffer vertices;
		StandardBuffer texturemap;
		VertexArray vao;
	}

	this(shared(ComponentChildable) parent) {
		super(parent);
		color_ = Color3(255, 255, 255);
		background_ = Color4.opaque;
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY) {
		super(parent, suggestedX, suggestedY);
		color_ = Color3(255, 255, 255);
		background_ = Color4.opaque;
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, wstring _text, shared(Font) _font, shared(Color3) _color = Color3(255, 255, 255)) {
		super(parent, suggestedX, suggestedY);
		font(_font);
		color(_color);
		text(_text);
		background_ = Color4.opaque;
	}

	@property {
		wstring text() {
			synchronized return text_;
		}

		void text(wstring value) {
			synchronized {
				static shared Texture emptyTexture;

				text_ = value;

				if (text_.length > 0)
					texture_ = font_.get(value, color_).texture;
				else {
					if (emptyTexture is null) {
						emptyTexture = new shared Texture(cast(ubyte[])null, 0, 0);
					}
					texture_ = emptyTexture;
				}
				
				_width = cast(uint)texture_.width;
				_height = cast(uint)texture_.height;
			}
		}

		Color3 color() {
			synchronized return color_;
		}

		void color(Color3 value) {
			synchronized {
				color_ = value;
				text(text_);
			}
		}

		Color background() {
			synchronized return background_;
		}

		void background(Color value) {
			synchronized background_ = value;
		}
	}

	override void redraw(shared(Window) window) {
		if (visible) {
			if (_height == 0 || _width == 0) {
				if (texture_ !is null) {
					_height = cast(uint)texture_.height;
					_width = cast(uint)texture_.width;
				}
			}

			super.redraw(window);
			if (program is null) {
				program = new shared ShaderProgram("label.vert", "label.frag");
				vertices = new shared StandardBuffer("full_vertices.raw");
				texturemap = new shared StandardBuffer("full_texture_mapping.raw");
				vao = new shared VertexArray();
				vao.bindAttribute(program, "position", vertices, glwrap.AttribPointerType.Float, 2);
				vao.bindAttribute(program, "texcoord", texturemap, glwrap.AttribPointerType.Float, 2);
			}
			if (texture_ !is null) {
				texture_.bind();
				program.bind();

				glwrap.glEnable(glwrap.EnableFunc.Blend);
				glwrap.glBlendFunc(glwrap.BlendFactors.SrcAlpha, glwrap.BlendFactors.OneMinusSrcAlpha);

				program.uniform("move", move_);
				program.uniform("background", background_.floats);
				program.uniform("scale", scale_);
				program.uniform("transform", transform_parent_);
				glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);

				glwrap.glBlendFunc(glwrap.BlendFactors.One, glwrap.BlendFactors.Zero);
				glwrap.glDisable(glwrap.EnableFunc.Blend);
			}
		}
	}
}