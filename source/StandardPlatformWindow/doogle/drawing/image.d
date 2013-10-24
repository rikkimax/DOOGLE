module doogle.drawing.image;

version(Windows) {
	public import doogle.drawing.image_def;
	public import doogle.drawing.opengl.image;

	alias Image_OpenGL Image;
}