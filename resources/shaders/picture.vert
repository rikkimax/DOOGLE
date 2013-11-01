#version 150
in vec2 position;
in vec2 texcoord;

uniform vec4 move;
uniform mat4 scale;
uniform mat4 transform;

out vec2 texloc;
void main() {
    gl_Position = ((scale * vec4(position, 0.0, 1.0)) + move) * transform;
    texloc = texcoord;
}
