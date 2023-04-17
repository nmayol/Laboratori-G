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
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(0,0,1.,1.0);
    vtexCoord = texCoord;
    float angle =  - time * texCoord.x; 
    float sinus = sin(angle);
    float cosinus = cos(angle);
    mat3 TG = mat3(vec3(cosinus, 0, -sinus),vec3(0,1,0),vec3(sinus,0,cosinus));
    gl_Position = modelViewProjectionMatrix * vec4(TG*vertex, 1.0);
}
