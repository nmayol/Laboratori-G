#version 330 core

out vec4 fragColor;
uniform sampler2D colorMap;
uniform float SIZE;

void main()
{
    fragColor = texture(colorMap, gl_FragCoord.xy/SIZE);
}
