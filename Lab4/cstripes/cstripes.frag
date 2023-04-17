#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform int nstripes = 16;
uniform vec2 origin = vec2(0,0);

void main()
{

    
    float dist = distance(vtexCoord,origin);
    float i = nstripes * dist;
    vec4 col;
    if (mod(i,2) < 1) col = vec4(1,0,0,1);
    else col = vec4(1,1,0,1);
    fragColor = col;
}
