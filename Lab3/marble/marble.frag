#version 330 core

uniform sampler2D noise;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

out vec4 fragColor;
in vec4 ver;
in vec3 norm;

const vec4 PlaS =  0.3*vec4(0,1,-1,0);
const vec4 PlaT =  0.3*vec4(-2,-1,1,0);

const vec4 redish = vec4(0.5,0.2,0.2,1.0);
const vec4 white = vec4(1);

vec4 shading(vec3 N, vec3 Pos, vec4 diffuse) {
 vec3 lightPos = vec3(0.0,0.0,2.0);
 vec3 L = normalize( lightPos - Pos );
 vec3 V = normalize( -Pos);
 vec3 R = reflect(-L,N);
 float NdotL = max( 0.0, dot( N,L ) );
 float RdotV = max( 0.0, dot( R,V ) );
 float Ispec = pow( RdotV, 20.0 );
 return diffuse * NdotL + Ispec;
}

void main()
{
        
    float s = dot(PlaS, ver);
    float t = dot(PlaT, ver);
    vec2 texCoord=vec2(s, t);

    vec4 col = white;
    float v = 2*texture(noise,texCoord).x;
    if (v < 1) col = mix(white,redish,fract(v));
    else if (v < 2) col = mix(redish,white,fract(v));

    vec3 N = normalize(normalMatrix*norm);
    vec3 verE = (modelViewMatrix*ver).xyz;
    fragColor = shading(N, verE, col);
}
