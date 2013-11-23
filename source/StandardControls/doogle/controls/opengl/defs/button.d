module doogle.controls.opengl.defs.button;
public import doogle.controls.defs.button;
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
		
		shared ShaderProgram program_flat;
		shared ShaderProgram program_popup;
		
		shared StandardBuffer vertices;
		shared StandardBuffer texturemap;
		shared VertexArray vao;
		
		ButtonBorder border_;
	}

	this(shared(ComponentChildable) parent) {
		super(parent);
		border_ = ButtonBorder.Flat;
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY) {
		super(parent, suggestedX, suggestedY);
		border_ = ButtonBorder.Flat;
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
		border_ = ButtonBorder.Flat;
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
		
		shared(Component)[] children() { synchronized return cast(shared(Component)[]) children_; }
		
		ButtonBorder border() { synchronized return border_; }
		void border(ButtonBorder value) { synchronized border_ = value; }
	}

	override void redraw(shared(Window) window) {
		if (visible) {
			glwrap.glEnable(glwrap.EnableFunc.Blend);
			glwrap.glBlendFunc(glwrap.BlendFactors.SrcAlpha, glwrap.BlendFactors.OneMinusSrcAlpha);
			
			if (vertices is null) {
				vertices = new shared StandardBuffer("full_vertices.raw");
			}
			
			/**
			 * Improvements that can be made:
			 * [1] Children vertical alignment
			 * [2] Adhere to width and height
			 */
			uint x = 5, y = 5, height = 0, width = 0;
			
			foreach(child; children_) {
				width += child.width;
				child.x = _x + x;
				child.y = _y + y;
				
				x += child.width;
				if (height < child.height)
					height = child.height;
			}

			_width = width + 10;
			_height = height + 10;

			super.redraw(window);

			if (border == ButtonBorder.Flat) {
				if (program_flat is null) {
					program_flat = new shared ShaderProgram("button_flat.vert", "button_flat.frag");
					vao = new shared VertexArray();
					vao.bindAttribute(program_flat, "position", vertices, glwrap.AttribPointerType.Float, 2);
				}
				
				program_flat.bind();
				
				program_flat.uniform("move", move_);
				program_flat.uniform("scale", scale_);
				program_flat.uniform("transform", transform_parent_);
				program_flat.uniform("mouseDown", cast(bool)state);
				program_flat.uniform("mouseOver", cast(bool)mouseOver);
			} else if (border == ButtonBorder.Popup) {
				if (program_popup is null) {
					program_popup = new shared ShaderProgram("button_popup.vert", "button_popup.frag");
					vao = new shared VertexArray();
					vao.bindAttribute(program_popup, "position", vertices, glwrap.AttribPointerType.Float, 2);
				}

				program_popup.bind();
				program_popup.uniform("glslCoordFix", window.glslCoordFix);
				program_popup.uniform("size", cast(int[2])[_width, _height]);
				program_popup.uniform("wsize", cast(int[2])[window.width, window.height]);
				program_popup.uniform("move", move_);
				program_popup.uniform("scale", scale_);
				program_popup.uniform("transform", transform_parent_);
				program_popup.uniform("mouseDown", cast(bool)state);
				program_popup.uniform("mouseOver", cast(bool)mouseOver);
				program_popup.uniform("location", cast(int[2])[_x, _y]);
			}


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