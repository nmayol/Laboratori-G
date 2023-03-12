#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
uniform float n = 32;


void main()
{
    vec2 d = fract(vtexCoord * n);
    if (d.x >= 0.1 && d.y >= 0.1) discard;
    fragColor = vec4(1.,0.,0.,0.);
    
}
