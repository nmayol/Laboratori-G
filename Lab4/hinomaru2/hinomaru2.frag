#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
uniform bool classic = true;

const float PI = 3.141592;
const float PSI = PI/16.;


void main()
{
    float d = length(vtexCoord - 0.5); // distancia des del centre
    if (classic && d >= 0.2) {
        vec2 u = vtexCoord - vec2(0.5,0.5);
        float Theta = atan(u.x,u.y);
        float stripes = mod((Theta / PSI) + 0.5,2);
        fragColor = vec4(max(1-step(stripes,1),step(1-0.2,1-d))) + 
                    vec4(max(  step(stripes,1),step(  0.2,  d))) * vec4(1,0,0,1);
    } else fragColor = (vec4(step(0.2,d))) + (vec4(step(1-0.2,1-d)))*vec4(1,0,0,1);
}
