#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;
in vec2 gtexCoord;



void main()
{
    int F[49] = int[49](  0,0,0,0,0,0,0,
                          0,0,1,0,0,0,0,
                          0,0,1,0,0,0,0,
                          0,0,1,1,0,0,0,
                          0,0,1,0,0,0,0,
                          0,0,1,1,1,0,0,
                          0,0,0,0,0,0,0);

    vec2 a = gtexCoord * 7;
    if (gfrontColor == vec4(1,1,0,0) && F[int(floor(a.x)+7*floor(a.y))] == 1) fragColor = vec4(0);
    else fragColor = gfrontColor;
}
