#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;
in vec2 gtexCoord;
in vec4 C;
uniform sampler2D face;
uniform int mode;

void main()
{
    if (mode == 2 && C.y >= 4.5 && gtexCoord != vec2(-1,-1)) fragColor = texture(face,gtexCoord);
    else fragColor = gfrontColor;
}
