#version 330 core

in vec4 frontColor;
in vec3 vertexNDC;
out vec4 fragColor;

uniform float time;


void main()
{
    if((vertexNDC.x) > time-1) discard;
    fragColor = frontColor;
}
