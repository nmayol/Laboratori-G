#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;


void main()
{

    float slice = 30.0;
    int frame = int(floor(time*slice));
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(1.0,1.0,1.0,1.0);
    vtexCoord = texCoord/vec2(8,6)+vec2(float(frame%8)/8.0,float((5-(frame/8))/6.0));
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
