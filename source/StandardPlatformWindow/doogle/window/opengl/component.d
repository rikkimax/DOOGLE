module doogle.window.opengl.component;
import doogle.window.component_def;
import doogle.window.window;
import doogle.events.event;
import doogle.events.types;
import doogle.math.linalg;

enum TransformMethod {
	UseChild,
	UseParent,
	Multiply
}

abstract class ComponentChild_OpenGL : ComponentChild_Def {
	protected {
		mat4 transform_ = mat4.identity;
		mat4 transform_final_;
		mat4 transform_parent_;
		TransformMethod transformMethod_;
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
}

interface ComponentChildable_OpenGL : ComponentChildable_Def {
	
}