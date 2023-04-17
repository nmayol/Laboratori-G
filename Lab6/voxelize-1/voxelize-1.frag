#version 330 core


out vec4 fragColor;
in vec3 gNorm;

void main()
{
    fragColor = vec4(0.8,0.8,0.8,1.) * gNorm.z;
}
