#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

void main()
{
    float a = 1./9.;
    float f = fract(vtexCoord.x);
    vec4 col;
    if(mod(f,2*a) <= a) col = vec4(1.,1.,0.,1.);
    else col = vec4(1.,0,0,0);
    fragColor = col;
}
