#version 330 core

uniform mat4 modelViewMatrixInverse;

out vec4 fragColor;

in vec3 N;   	// normal (en object space)
in vec3 P; 	// posicio del vertex (en object space)

uniform float time;
uniform bool rotate = true;

// V, N, P, lightPos han d'estar al mateix espai de coordenades
// V es el vector unitari cap a l'observador
// N es la normal
// P es la posicio 
// lightPos es la posicio de la llum
// lightColor es el color de la llum
vec4 light(vec3 V, vec3 N, vec3 P, vec3 lightPos, vec3 lightColor)
{
	const float shininess = 100.0;
	const float Kd = 0.5;
	N = normalize(N);
	vec3 L = normalize(lightPos - P);
	vec3 R = reflect(-L, N);
	float NdotL = max(0.0, dot(N,L));
	float RdotV = max(0.0, dot(R,V));
	float spec =  pow( RdotV, shininess);
	return vec4(Kd*lightColor*NdotL + vec3(spec),0);
}

void main()
{
	float angle = 0;
	if (rotate) angle = time;
    else angle = 0;
	float cs = cos(angle);
	float sn = sin(angle);
	mat3 R = mat3(vec3(cs, sn, 0), vec3(-sn, cs,0), vec3(0,0,1));

	vec3 V = normalize(modelViewMatrixInverse[3].xyz - P);
	vec4 c = vec4(0);
	

    vec4 verd    = light(V, N, P, (modelViewMatrixInverse*vec4(R*vec3(  0, 10, 0), 1)).xyz, vec3(0, 1, 0));
    vec4 vermell = light(V, N, P, (modelViewMatrixInverse*vec4(R*vec3(-10,  0, 0), 1)).xyz, vec3(1, 0, 0));
    vec4 groc    = light(V, N, P, (modelViewMatrixInverse*vec4(R*vec3(  0,-10, 0), 1)).xyz, vec3(1, 1, 0));
    vec4 blau    = light(V, N, P, (modelViewMatrixInverse*vec4(R*vec3( 10,  0, 0), 1)).xyz, vec3(0, 0, 1));

	c = verd + vermell + groc + blau;
	fragColor = c;
}