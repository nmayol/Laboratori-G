#version 330 core

in vec4 frontColor;
out vec4 fragColor;
uniform sampler2D map;
uniform float time;
uniform float a = 0.5;
in vec2 vtexCoord;

const float PI = 3.141592;

void main()
{
    vec4  textura = texture(map, vtexCoord);

    vec3 c = textura.rgb;


    float m = max(c.x,max(c.y,c.z)); 
    vec2 u = vec2(m,m);

    float angle = 2 * PI * time;
    mat2 rot = mat2(vec2(cos(angle),sin(angle)),vec2(-sin(angle),cos(angle)));

    u = rot * u;

    float offset = float((a / 100.0) * u); 
    

    fragColor = texture(map, vtexCoord+offset);
}
