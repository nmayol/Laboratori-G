#version 330 core


out vec4 fragColor;
in vec2 vtexCoord;
in vec4 vE;

uniform int mode = 2;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position

// (sempre estarà en eye space)
uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

void main()
{
	if (distance(vtexCoord,vec2(0,0)) >= 1.) discard;
    if (mode >= 0) fragColor = vec4(0,0,0,1);
    if (mode > 0) {
        vec3 P = vec3(vtexCoord.s,vtexCoord.t,sqrt(1-pow(vtexCoord.s,2)-pow(vtexCoord.t,2)));
        vec3 N = P;

        if (mode == 2) {
            N = normalize(normalMatrix*N);
            P = (modelViewMatrix * vec4(P,1.)).xyz;
            vec3 V = -normalize(vE).xyz;
            vec3 L = normalize(lightPosition.xyz - vE.xyz);
            vec3 R = normalize(2*dot(N,L)*N-L);  
  
            vec4 ambient = lightAmbient * matAmbient;
            vec4 difus = lightDiffuse * matDiffuse * max(0.0, dot(N, L));
            vec4 spec = lightSpecular * matSpecular * pow(max(0.0, dot(R, V)), matShininess);
    
            fragColor = ambient + difus + spec;

        }
        else fragColor = vec4(1.) * N.z;
    }


}
