#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

const vec4 VERD = vec4(0.6,0.66,0.53,1.);
const vec4 BLANC = vec4(1.);

void main()
{
    vec4 col;
    vec2 coords = vec2(vtexCoord.x*4/3.-0.4,vtexCoord.y-0.5);
    vec2 coords2 = vec2(vtexCoord.x*4/3.-0.5,vtexCoord.y-0.5);
    if ((1./10.0 * 6 < vtexCoord.x && 1./10.0 * 9 > vtexCoord.x)
         && (1./10.0 * 3 < vtexCoord.y && 1./10.0 * 7 > vtexCoord.y)) //  Quadrat blanc
         col = BLANC;
    else if ((length(coords)) <= 0.3 && !(length(coords2) <= 0.25)) col = BLANC; // Lluna
    else col = VERD;

    // vec4 col;
    // float factor = 1./3.;
    // vec2 coords = vec2(vtexCoord.x*4/3.-0.65,vtexCoord.y-0.5);
    // if ((length(coords)) <= 0.3) col = vec4(1.,0,0,1);
    // else if (vtexCoord.y < factor) col = vec4(0,0.5,1,1.);
    // else if (vtexCoord.y < factor * 2) col = vec4(1.,1.,0,1);
    // else col = vec4(0,0.8,0.6,1);
    fragColor = col;
}
