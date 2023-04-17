#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float angle = 0.5;

void main()
{
    
    float sinus = sin(angle); float cosinus = cos(angle);
    mat4 TG = mat4(vec4(cosinus,0,-sinus,0),vec4(0,1,0,0),vec4(sinus,0,cosinus,0),vec4(0,0,0,1));
    vec4 P = vec4(vertex, 1.);
    vec4 P1 = TG * P;
    
    float t = smoothstep(1.45, 1.55, vertex.y);
    vec4 P_interpol = mix(P,P1,t);
    
    
    
    vec3 N1 = (TG * vec4(normal,1.)).xyz;
    vec3 N = normalize(normalMatrix * mix(normal,N1,t));
    
    frontColor = vec4(1.0) * N.z;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * P_interpol;
}
