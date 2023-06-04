#version 330 core

in vec4 gfrontColor;
in vec2 gtexCoord;
out vec4 fragColor;


void main()
{
    vec2 a = gtexCoord;
    if (gtexCoord.t >= 0.95 || gtexCoord.s >= 0.95) fragColor = vec4(0);
    else if (gtexCoord.t <= 0.05 || gtexCoord.s <= 0.05) fragColor = vec4(0);
    else if (gtexCoord.s >= 0.475 && gtexCoord.s <= 0.525) fragColor = vec4(0);
    else if (gtexCoord.t >= 0.475 && gtexCoord.t <= 0.525) fragColor = vec4(0);
    else fragColor = gfrontColor;
}
