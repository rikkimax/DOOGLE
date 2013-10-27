module doogle.controls.defs.picture;
import doogle.drawing.image;

interface Picture_Def {
	@property {
		Image image();
		void image(Image value);
		void image(string name);
	}
}