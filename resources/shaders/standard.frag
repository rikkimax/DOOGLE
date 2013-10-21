#version 150
in vec2 texloc;

uniform sampler2D tex;

out vec4 color;
void main() {
    color = texture(tex, texloc);
}