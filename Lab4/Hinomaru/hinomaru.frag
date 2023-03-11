#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    float d = length(vtexCoord - 0.5);
    fragColor = (vec4(step(0.2,d))) + (vec4(step(0.8,1-d)))*vec4(1,0,0,1);
}
