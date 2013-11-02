#version 150
in vec2 texloc;

uniform bool mouseDown;
uniform bool mouseOver;

out vec4 color;
void main() {
	if (mouseOver && mouseDown) {
		color = vec4(0.5, 0.5, 0.5, 1);
	} else if (mouseOver) {
		color = vec4(0.7, 0.7, 0.7, 1);
	} else {
		color = vec4(1, 1, 1, 1);
	}
}