module doogle.controls.opengl.defs.button;
import doogle.controls.defs.button;
import doogle.controls.control;
import doogle.window.component;
import doogle.window.window;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
public import doogle.util.color : Color3, Color, Color4;

class Button : Control, Button_Def {
	protected {
		ComponentChild[] children_;
		shared ShaderProgram program;
		shared StandardBuffer vertices;
		shared StandardBuffer texturemap;
		shared VertexArray vao;
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

	@property {
		ButtonState state() {
			synchronized return cast(ButtonState)_mouseButtons[0];
		}

		void addChild(shared(ComponentChild) child) {
			synchronized children_ ~= child;
		}
		
		void removeChild(shared(ComponentChild) child) {
			synchronized {
				if (children_.length == 0) return;
				size_t found;
				bool got = false;
				for(size_t i = 0; i < children_.length; i++ ) {
					if (children_[i] == child) {
						found = i;
						got = true;
						break;
					}
				}
				if (got) {
					if (found > children_.length) // middle
						children_ = children_[0 .. found]  ~ children_[found .. $];
					else if (found > 0) // end
						children_ = children_[0 .. found];
					else // start
						children_= children_[found .. $];
					
				}
			}
		}
		
		@property shared(Component)[] children() { synchronized return cast(shared(Component)[]) children_; }
	}

	override void redraw(shared(Window) window) {
		if (visible) {
			uint x = 0, y = 0, height = 0, width = 0;
			
			/**
			 * Improvements that can be made:
			 * [1] Children vertical alignment
			 * [2] Adhere to width and height
			 * [3] Borders
			 */
			
			foreach(child; children_) {
				width += child.width;
				child.x = _x + x;
				child.y = _y + y;
				
				x += child.width;
				if (height < child.height)
					height = child.height;
			}
			_width = width;
			_height = height;

			// draw me
			if (program is null) {
				program = new shared ShaderProgram("button.vert", "button.frag");
				vertices = new shared StandardBuffer("full_vertices.raw");
				vao = new shared VertexArray();
				vao.bindAttribute(program, "position", vertices, glwrap.AttribPointerType.Float, 2);
			}
			
			program.bind();
			super.redraw(window);
			
			glwrap.glEnable(glwrap.EnableFunc.Blend);
			glwrap.glBlendFunc(glwrap.BlendFactors.SrcAlpha, glwrap.BlendFactors.OneMinusSrcAlpha);

			program.uniform("move", move);
			program.uniform("scale", scale);
			program.uniform("transform", transform_parent_);
			program.uniform("mouseDown", cast(bool)state);
			program.uniform("mouseOver", cast(bool)mouseOver);
				program_flat.uniform("move", move_);
				program_flat.uniform("scale", scale_);
				program_popup.uniform("move", move_);
				program_popup.uniform("scale", scale_);
			glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);

			glwrap.glBlendFunc(glwrap.BlendFactors.One, glwrap.BlendFactors.Zero);
			glwrap.glDisable(glwrap.EnableFunc.Blend);
			
			// draw children
			foreach(child; children_) {
				child.redraw(window);
			}
		}
	}
}