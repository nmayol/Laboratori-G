#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;
out vec4 ver;
out vec3 norm;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    ver = vec4(vertex,1.);
    vec3 norm = normal;
    gl_Position = modelViewProjectionMatrix * ver;
}
