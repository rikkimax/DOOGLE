module doogle.controls.layouts.flow;
import doogle.controls.layout_def;
import doogle.window.component;

shared class FlowLayout : Layout_Def {
	protected {
		AlignmentType alignment_;
	}

	this(shared(ComponentChildable) parent, AlignmentType alignment = AlignmentType.Horizontal) {
		super(parent);
		this.alignment_ = alignment;
	}
	
	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, AlignmentType alignment = AlignmentType.Horizontal) {
		super(parent, suggestedX, suggestedY);
		this.alignment_ = alignment;
	}

	this(shared(ComponentChildable) parent, uint suggestedX, uint suggestedY, uint suggestedWidth, uint suggestedHeight, AlignmentType alignment = AlignmentType.Horizontal) {
		super(parent, suggestedX, suggestedY, suggestedWidth, suggestedHeight);
		this.alignment_ = alignment;
	}

	@property {
		void alignment(AlignmentType type) {
			synchronized alignment_ = type;
		}

		AlignmentType alignment() {
			synchronized return alignment_;
		}
	}

	protected {
		override void update() {
			synchronized {
				uint
					x = 0,
					y = 0,
					maxWidth = 0,
					maxHeight = 0;
				
				foreach(child; _children) {
					maxWidth += child.width;
					if (maxHeight < child.height)
						maxHeight = child.height;
				}

				switch(alignment_) {
					case AlignmentType.Horizontal:
						foreach(child; _children) {
							child.x = _x + x;
							child.y = _y + y;
							
							x += child.width;
							maxWidth += child.width;
							if (maxHeight < child.height)
								maxHeight = child.height;
							child.relocate();
						}
						break;
					case AlignmentType.Vertical:
						foreach(child; _children) {
							child.x = _x + x;
							child.y = _y + y;
							
							y += child.height;
							maxHeight = child.height;
							if (maxWidth < child.width)
								maxWidth = child.width;
							child.relocate();
						}
						break;
					default:
						break;
				}

				_width = maxWidth;
				_height = maxHeight;
			}
		}
	}
}