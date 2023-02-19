#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 ProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform bool eyespace = false;
uniform float time;
const float PI = 3.141592;

void main()
{
    float r = length(boundingBoxMax - boundingBoxMin)/2;
    
    float y = 0;
    if (eyespace) {
        vec4 vE = modelViewMatrix * vec4(vertex,1.0);
        y = vE.y;
    }
    else {y = vertex.y;}
    float d = (r / 10) * y;
    float factor = d * sin(time);
    vec3 newV = vertex + normal*factor;


    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(newV, 1.0);
   
}
