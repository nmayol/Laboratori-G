#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;


out vec2 vtexCoord;
out vec3 N;
out vec3 vE;
out vec3 L;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewMatrixInverse;

uniform mat3 normalMatrix;
uniform vec4 lightPosition; // similar a gl_LightSource[0].position


uniform bool world = false;

void main()
{
    if (!world) {
        vE = -(modelViewMatrix * vec4(vertex,1.0)).xyz;
        N = normalize(normalMatrix * normal); 
        L = lightPosition.xyz + vE;
    }
    else {
        vE = (modelViewMatrixInverse*vec4(0,0,0,1)).xyz - vertex;
        N = normal; 
        L = (modelViewMatrixInverse*lightPosition).xyz - vertex;
    }
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
