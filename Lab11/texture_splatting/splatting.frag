#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D noise0;
uniform sampler2D rock1;
uniform sampler2D grass2;



void main()
{
    fragColor = mix(texture(rock1, vtexCoord),texture(grass2, vtexCoord),texture(noise0, vtexCoord).x);
}
