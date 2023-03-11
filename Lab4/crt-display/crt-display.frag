#version 330 core

in vec4 frontColor;
out vec4 fragColor;
uniform int n = 5;


void main()
{
    if (mod(gl_FragCoord.y,float(n)) > 1) discard;
    else {   fragColor = frontColor;}
}
