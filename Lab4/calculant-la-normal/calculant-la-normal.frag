#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec4 vE;

void main()
{
    vec3 n = normalize(cross(dFdx(vE.xyz),dFdy(vE.xyz))); // cross() retorna el producte vectorial
    fragColor = frontColor * n.z;
    
}
