#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

const vec4 VERD = vec4(0,1,0,1);
const vec4 BLAU = vec4(0,0,1,1);

void main()
{
    vec2 d = floor(vtexCoord * 16);

    if (vtexCoord.y <= 0.9 && vtexCoord.y >= 0.1) {
        if (vtexCoord.x >= 0.2 && vtexCoord.x <= 0.3) {
            if(mod(d.y,2) == mod(d.x,2)) fragColor = VERD;
            else discard;
        }
        else if (vtexCoord.x >= 0.8 && vtexCoord.x <= 0.9) {
            if(mod(d.y,2) == mod(d.x,2)) fragColor = VERD;
            else discard;
        }
        else if (vtexCoord.x < 0.8 && vtexCoord.x > 0.3 && (vtexCoord.y < -1.3*vtexCoord.x + 1.3)&& (vtexCoord.y > -1.3*vtexCoord.x + 1.1) ) {
            if (mod(d.y,2) == mod(d.x,2)) fragColor= VERD;
            else discard;
        }
        else if (mod(d.y,2) != mod(d.x,2)) fragColor = BLAU;
        else discard;

    }
    else discard;
      
    
}
