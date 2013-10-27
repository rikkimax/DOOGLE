module test;
import doogle.controls.font;
import doogle.platform;
import doogle.window.window;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
import doogle.util.color;
import doogle.controls.opengl.defs.picture;

import gl3n.linalg;
import std.stdio : writeln;
import std.file : exists, read, isFile, write;

import core.thread;

void main() {
	// make sure all the files were loaded.
	assert(storage.fonts.local.length == 1);
	assert(storage.shaders.local.length == 4);
	assert(storage.models.local.length == 2);

	shared Window window = new shared Window(800, 600, "OpenGL Window"w, WindowStyle.Close);

	shared Font font = new shared Font("Anonymous_Pro.ttf", 20, 3);
	auto text_hi = font.get("Hi");

	shared Picture picture = new shared Picture(window, 750, 550, 50, 50, text_hi);

	gl.glClearColor(0.4f, 0.4f, 0.4f, 1f);
	while (window.isOpen) {
		if (!window.whileOpenEvent()) return;

		glwrap.glClear(true, true);
		glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);
		
		window.redraw();
		Thread.sleep(dur!"msecs"(75));
	}
}
