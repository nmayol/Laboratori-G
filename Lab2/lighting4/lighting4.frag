#version 330 core

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position

// (sempre estarà en eye space)
uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess


out vec4 fragColor;
in vec3 N;
in vec3 vE;

void main()
{

    vec3 V = -normalize(vE);
    vec3 L = normalize(lightPosition.xyz - vE);
    vec3 R = normalize(2*dot(N,L)*N-L);  
  
    vec4 ambient = lightAmbient * matAmbient;
    vec4 difus = lightDiffuse * matDiffuse * max(0.0, dot(N, L));
    vec4 spec = lightSpecular * matSpecular * pow(max(0.0, dot(R, V)), matShininess);
    
    fragColor = ambient + difus + spec;
}
