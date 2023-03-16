#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    vec4 col;
    float factor = 1./3.;
    vec2 coords = vec2(vtexCoord.x*4/3.-0.65,vtexCoord.y-0.5);
    if ((length(coords)) <= 0.3) col = vec4(1.,0,0,1);
    else if (vtexCoord.y < factor) col = vec4(0,0.5,1,1.);
    else if (vtexCoord.y < factor * 2) col = vec4(1.,1.,0,1);
    else col = vec4(0,0.8,0.6,1);
    fragColor = col;
}
