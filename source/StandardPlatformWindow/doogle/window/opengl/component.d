module doogle.window.opengl.component;
import doogle.window.component_def;
import doogle.window.window;
import doogle.events.event;
import doogle.events.types;
import doogle.math.linalg;

enum TransformMethod {
	UseChild,
	UseParent,
	Multiply,
	Add,
	SubtractParent,
	SubtractChild
}

abstract class ComponentChild_OpenGL : ComponentChild_Def {
	protected {
		mat4 transform_ = mat4.identity;
		mat4 transform_final_ = mat4.identity;
		mat4 transform_parent_ = mat4.identity;
		TransformMethod transformMethod_ = TransformMethod.UseChild;

		mat4 scale_;
		vec4 move_;
	}
	
	@property {
		shared(mat4) finalTransform() {
			synchronized return transform_final_;
		}
		
		shared(mat4) transform() {
			synchronized return transform_;
		}
		
		void transform(shared(mat4) m, TransformMethod tm) {
			synchronized {
				transform_ = m;
				transformMethod_ = tm;
			}
		}
		
		TransformMethod transformMethod() {
			synchronized return transformMethod_;
		}
		
		void transformMethod(TransformMethod tm) {
			synchronized transformMethod_ = tm;
		}
	}
	
	override void childEvent(shared(Window) window, shared(Component) parent, shared(Event) event) {
		synchronized {
			if (parent !is null) {
				if (is(parent : ComponentChild_OpenGL)) {
					if ((cast(shared(ComponentChild_OpenGL))parent).finalTransform != transform_parent_) {
						transform_parent_ = (cast(shared(ComponentChild_OpenGL))parent).finalTransform;
						if (event.type == EventTypes.Draw) {
							switch(transformMethod_) {
								case TransformMethod.UseChild:
									transform_final_ = transform_;
									break;
								case TransformMethod.UseParent:
									transform_final_ = (cast(shared(ComponentChild_OpenGL))parent).finalTransform;
									break;
								case TransformMethod.Multiply:
									transform_final_ = mult(transform_, (cast(shared(ComponentChild_OpenGL))parent).finalTransform);
									break;
								case TransformMethod.Add:
									transform_final_ = add((cast(shared(ComponentChild_OpenGL))parent).finalTransform, transform_);
									break;
								case TransformMethod.SubtractChild:
									transform_final_ = subtract((cast(shared(ComponentChild_OpenGL))parent).finalTransform, transform_);
									break;
								case TransformMethod.SubtractParent:
									transform_final_ = subtract(transform_, (cast(shared(ComponentChild_OpenGL))parent).finalTransform);
									break;
								default:
									break;
							}
						}
					}
				}
			}
			super.childEvent(window, parent, event);
		}
	}

	override void redraw(shared(Window) window) {
		int wwidth = window.width;
		int wheight = window.height;
		int cwidth = _width;
		int cheight = _height;
		if (wwidth > 0 && wheight > 0 && cwidth > 0 && cheight > 0) {
			int cposX = _x;
			int cposY = _y;
			
			float cx = 1f / (wwidth / 2);
			float cy = 1f / (wheight / 2);
			vec4 move = vec4(cx * (-(wwidth / 2) + ((cwidth / 2) + cposX)), cy * ((wheight / 2) - ((cheight / 2) + cposY)), 0, 0);
			move_ = *cast(shared(vec4*))cast(void*)&move;

			
			float dx = cwidth / cast(float)wwidth;
			float dy = cheight / cast(float)wheight;

			mat4 scale = mat4(
				dx, 0f, 0f, 0f,
				0f, dy, 0f, 0f,
				0f, 0f, 1f, 0f,
				0f, 0f, 0f, 1f
			);
			scale_ = *cast(shared(mat4*))cast(void*)&scale;
		} else {
			vec4 move = vec4(0f, 0f, 0f, 0f);
			move_ = *cast(shared(vec4*))cast(void*)&move;
			mat4 scale = mat4.identity;
			scale_ = *cast(shared(mat4*))cast(void*)&scale;
		}

		super.redraw(window);
	}
}

interface ComponentChildable_OpenGL : ComponentChildable_Def {
	
}