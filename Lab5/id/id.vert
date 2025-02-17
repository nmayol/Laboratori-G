#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;
out vec4 vx;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    frontColor = vec4(color,1.);
    vtexCoord = texCoord;
    
    vec4 vx = modelViewProjectionMatrix * vec4(vec3(vertex.x,vertex.y*0.5,vertex.z), 1.0);
    gl_Position = vx;
}
