#version 150
in vec2 position;
in vec2 texcoord;

out vec2 texloc;
void main() {
    int wwidth = 800;
    int wheight = 600;
    int cwidth = 50;
    int cheight = 50;
    int cposX = 750;
    int cposY = 550;

    float cx = 1f / (wwidth / 2);
    float cy = 1f / (wheight / 2);
    vec4 move = vec4(cx * (-(wwidth / 2) + ((cwidth / 2) + cposX)), cy * ((wheight / 2) - ((cheight / 2) + cposY)), 0, 0);

    float dx = 1f / (wwidth / cwidth);
    float dy = 1f / (wheight / cheight);

    mat4 scale;
    scale[0] = vec4(dx, 0f, 0f, 0f);
    scale[1] = vec4(0f, dy, 0f, 0f);
    scale[2] = vec4(0f, 0f, 1f, 0f);
    scale[3] = vec4(0f, 0f, 0f, 1f);

	gl_Position = (scale * vec4(position, 0.0, 1.0)) + move;
    texloc = texcoord;
}
