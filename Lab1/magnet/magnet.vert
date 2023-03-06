#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform mat3 normalMatrix;
uniform vec4 lightPosition; // eyespace
uniform float n = 4;


void main()
{
    vec4 posFocus = modelViewMatrixInverse*lightPosition;
    float d = distance(vertex,posFocus.xyz);
    float w = clamp(1/pow(d,n), 0, 1);

    vec3 v = (1.0 - w) * vertex + w * posFocus.xyz;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(1)*N.z;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(v, 1.0);
}
