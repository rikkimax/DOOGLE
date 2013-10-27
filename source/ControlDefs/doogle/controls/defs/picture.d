module doogle.controls.defs.picture;
import doogle.drawing.image;

shared interface Picture_Def {
	@property {
		shared(Image) image();
		void image(shared(Image) value);
	}
}