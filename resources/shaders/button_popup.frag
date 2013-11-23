#version 150  
in vec2 texloc;  
in vec2 pos; 
 
uniform bool mouseDown;  
uniform bool mouseOver;  
uniform ivec2 size;  
uniform ivec2 location; 
uniform ivec2 wsize; 
 
out vec4 color;  
void main() {  
    float rlx = gl_FragCoord.x - location.x - 1; // left x base coord  
    float rrx = size.x - rlx - 3; // right x base coord  
    float rty = (wsize.y - location.y) - gl_FragCoord.y - .5; // top y base coord  1.5 for x64
    float rby = size.y - rty + 1; // bottom y base coord  
 
    if (rby + rlx <= 1 || rby + rrx <= 1 || rty + rlx <= 1 || rty + rrx <= 1) {
    } else if (rby + rlx <= 3 || rby + rrx <= 3 || rby <= 1) {
        color = vec4(0, 0, 0, 1); 
    } else { 
		if (mouseOver && mouseDown) { 
			color = vec4(0.5, 0.5, 0.5, 1); 
		} else if (mouseOver) { 
			color = vec4(0.7, 0.7, 0.7, 1); 
		} else { 
			color = vec4(1, 1, 1, 1); 
		} 
    } 
}