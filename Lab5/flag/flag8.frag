#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    vec4 col;
    if (vtexCoord.x < 0.5) col = vec4(0,0.6,0.8,1.);
    else if (vtexCoord.y > 0.5) col = vec4(1.,0,0,1);
    else col = vec4(1.,1.,0,1);
    fragColor = col;
}
