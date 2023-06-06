#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;


out vec2 vtexCoord;
out vec4 vE;

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vE =modelViewMatrix * vec4(vertex, 1.0);
    vtexCoord = texCoord * 2 - 1;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
