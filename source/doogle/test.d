module test;
import doogle.platform;
import doogle.window.window;
import doogle.gl.shaders;
import doogle.events.event;
import doogle.events.types;
import doogle.gl.buffers;
import doogle.gl.vertexarray;
import core.thread;

import gl3n.linalg;
import std.stdio;

void main() {
	shared Window window = new shared Window(800, 600, "OpenGL Window"w, WindowStyle.Close);
	shared ShaderProgram program = new shared ShaderProgram("""
#version 150
in vec2 position;
void main() {
    gl_Position = vec4(position, 0.0, 1.0);
}
""","""
#version 150
out vec4 outColor;
void main() {
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
""");

	vec3[] vertices = [
		vec3(-0.5f, -0.5f, 0.0f),
		vec3(0.5f, -0.5f, 0.0f),
		vec3(0.0f, 0.5f, 0.0f)
	];

	shared StandardBuffer vbo = new shared StandardBuffer(vertices);
	shared VertexArray vao = new shared VertexArray(vbo);
	vao.bindAttribute(program, "position", vbo, glwrap.AttribPointerType.Float, 3);

	gl.glClearColor(0.4f, 0.4f, 0.4f, 1f);

	Event ev;
	while (window.isOpen) {
		while(window.getEvent(ev) && window.isOpen) {
			if (ev.type == EventTypes.Close)
				return;
		}

		glwrap.glClear(true, true);

		program.use();
		vao.bind();
		glwrap.glDrawArrays(glwrap.Primitives.Triangles, 0, 3);

		window.redraw();

		Thread.sleep(dur!"msecs"(75));
	}
}