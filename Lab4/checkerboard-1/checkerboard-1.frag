#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

const vec4 NEGRE = vec4(0.);
const vec4 GRIS = vec4(0.8);

void main()
{
    vec2 d = floor(vtexCoord * 8);
    if (mod(d.y,2) == mod(d.x,2)) fragColor = GRIS;
    else fragColor = NEGRE;
}
