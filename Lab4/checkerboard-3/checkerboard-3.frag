#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
uniform float n = 8;


void main()
{
    vec2 d = fract(vtexCoord * n);
    fragColor = vec4(step(0.1,d.x)) * vec4(step(0.1,d.y)) * 0.8;
    
}
