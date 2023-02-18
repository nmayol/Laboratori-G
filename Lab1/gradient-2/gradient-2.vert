#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 projectionMatrixInverse;

void main()
{    
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
    
    vec3 red = vec3(1,0,0);
    vec3 yellow = vec3(1,1,0);
    vec3 green = vec3(0,1,0);
    vec3 cyan = vec3(0,1,1);
    vec3 blue = vec3(0,0,1);

    vec3 col1,col2;
    float ipol = 2*(gl_Position.y/gl_Position.w+1.0);

    if(ipol < 0) {col1 = red; col2 = red;}
    else if (ipol < 1) {col1 = red; col2 = yellow;}
    else if (ipol < 2) {col1 = yellow; col2 = green;}
    else if (ipol < 3) {col1 = green; col2 = cyan;}
    else if (ipol < 4) {col1 = cyan; col2 = blue;}
    else {col1 = blue; col2 = blue;}
    
    frontColor = vec4(mix(col1,col2,fract(ipol)),1.0);

    
}
