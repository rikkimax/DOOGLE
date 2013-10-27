module test;
import doogle.controls.font;
import doogle.platform;
import doogle.window.window;
import doogle.gl.shaders;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import doogle.gl.texture;
import doogle.util.color;

import gl3n.linalg;
import std.stdio : writeln;
import std.file : exists, read, isFile, write;

import core.thread;
import core.memory;

void main() {
	GC.disable();

	// make sure all the files were loaded.
	assert(storage.fonts.local.length == 1);
	assert(storage.shaders.local.length == 2);
	assert(storage.models.local.length == 2);

	shared Window window = new shared Window(800, 600, "OpenGL Window"w, WindowStyle.Close);
	shared ShaderProgram program = new shared ShaderProgram("Vertex_Standard", "Fragment_Standard");

	/*
	 * float cx = 1f / (window.width / 2f);
	 * float cy = 1f / (window.height / 2f);
	 * vec4 move = vec4(cx * pixelsToMoveX, cy * pixelsToMoveY, 0, 0);
	 */

	/*
	 * mat4 scale;
	 * float dx = 1 / (window.width / text_hi.width)
	 * float dy = 1 / (window.height / text_hi.height)
	 * 
     * scale[0] = vec4(dx, 0f, 0f, 0f);
     * scale[1] = vec4(0f, dy, 0f, 0f);
     * scale[2] = vec4(0f, 0f, 1f, 0f);
     * scale[3] = vec4(0f, 0f, 0f, 1f);
	 */
	
	shared StandardBuffer vertices = new shared StandardBuffer("full_vertices.raw");
	shared StandardBuffer texturemap = new shared StandardBuffer("full_texture_mapping.raw");

	shared VertexArray vao = new shared VertexArray();
	vao.bindAttribute(program, "position", vertices, glwrap.AttribPointerType.Float, 2);
	vao.bindAttribute(program, "texcoord", texturemap, glwrap.AttribPointerType.Float, 2);

	shared Font font = new shared Font("Anonymous_Pro.ttf", 20, 3);
	auto text_hi = font.get("Hi");
	shared Texture texture = text_hi.texture;

	gl.glClearColor(0.4f, 0.4f, 0.4f, 1f);
	while (window.isOpen) {
		if (!window.whileOpenEvent()) return;

		glwrap.glClear(true, true);
		glwrap.glDrawArrays(glwrap.Primitives.TriangleStrip, 0, 4);
		
		window.redraw();
		Thread.sleep(dur!"msecs"(75));
	}
	GC.enable();
}
