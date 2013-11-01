#version 150
in vec2 texloc;

uniform sampler2D tex;
uniform vec4 background;

out vec4 color;
void main() {
    color = texture(tex, texloc);
	if (color == vec4(0, 0, 0, 1)) {
		color = background;
	}
}