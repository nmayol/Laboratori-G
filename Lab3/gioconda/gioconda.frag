#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
uniform sampler2D colorMap;
uniform float time;

const vec2 ULL = vec2(0.393, 0.652);
const vec2 BOCA =  vec2(0.45, 0.48);
const float RADI = 0.025;

void main()
{
    vec2 st = vtexCoord;
    if (fract(time) > 0.5 && distance(st, ULL) < RADI) {
        st = BOCA - (ULL - st); 
    }
    fragColor = texture(colorMap,st);
}
