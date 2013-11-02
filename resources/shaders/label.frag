#version 150
in vec2 texloc;

uniform sampler2D tex;
uniform vec4 background;

out vec4 color;
void main() {
    color = texture(tex, texloc);
	if (color.r <= 0.3 && color.g <= 0.3 && color.b <= 0.3) {
		color = background;
	}
}