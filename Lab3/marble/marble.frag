#version 330 core


out vec4 fragColor;
in vec2 vtexCoord;
in vec3 norm;
in vec3 ver;

// uniforms
uniform sampler2D noise;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

// plans
const vec4 PLA_S = 0.3*vec4(0, 1, -1, 0);
const vec4 PLA_T = 0.3*vec4(-2, -1, 1, 0);

// colors
const vec4 WHITE = vec4(1);
const vec4 REDISH = vec4(0.5,0.2,0.2,1.);

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

    vec4 ver4 = vec4(ver,1.);

    float s = dot(ver4,PLA_S); 
    float t = dot(ver4,PLA_T);

    float v = 2*texture(noise, vec2(s,t)).x;
    vec4 diffuse;
    if (v < 1) diffuse = mix(WHITE,REDISH,fract(v));
    else diffuse = mix(REDISH,WHITE,fract(v));

    vec3 verEye = (modelViewMatrix*ver4).xyz;
    vec3 N = normalize(normalMatrix * norm);


    fragColor = shading(N,verEye,diffuse);
}