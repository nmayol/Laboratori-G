#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out vec3 gNorm;

uniform mat3 normalMatrix;
uniform float step = 0.2;
uniform mat4 modelViewProjectionMatrix;

void process(vec3 v) {
	gl_Position = modelViewProjectionMatrix * vec4(v,1.);
	EmitVertex();
}

//	1.______________.2
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	3.______________.4

void createSquare(vec3 v1, vec3 v2, vec3 v3, vec3 v4, vec3 n) {
	process(v1);
	process(v2);
	process(v3);
	process(v4);

	// gNorm ha de tinr el mateix nom que la variable out, i entra al frag shader
	gNorm = normalize(normalMatrix* n);
	EndPrimitive();
}

void createCube(vec3 centre, float meitatCostatX, float meitatCostatY, float meitatCostatZ) {
	vec3 v0 = vec3(centre.x - meitatCostatX, centre.y - meitatCostatY, centre.z - meitatCostatZ);
	vec3 v1 = vec3(centre.x - meitatCostatX, centre.y - meitatCostatY, centre.z + meitatCostatZ);
	vec3 v2 = vec3(centre.x - meitatCostatX, centre.y + meitatCostatY, centre.z - meitatCostatZ);
	vec3 v3 = vec3(centre.x - meitatCostatX, centre.y + meitatCostatY, centre.z + meitatCostatZ);
	vec3 v4 = vec3(centre.x + meitatCostatX, centre.y - meitatCostatY, centre.z - meitatCostatZ);
	vec3 v5 = vec3(centre.x + meitatCostatX, centre.y - meitatCostatY, centre.z + meitatCostatZ);
	vec3 v6 = vec3(centre.x + meitatCostatX, centre.y + meitatCostatY, centre.z - meitatCostatZ);
	vec3 v7 = vec3(centre.x + meitatCostatX, centre.y + meitatCostatY, centre.z + meitatCostatZ);

	
	createSquare(v4,v5,v6,v7,vec3( 1, 0, 0));
	createSquare(v0,v1,v2,v3,vec3(-1, 0, 0));
	createSquare(v2,v3,v6,v7,vec3( 0, 1, 0));
	createSquare(v0,v1,v4,v5,vec3( 0,-1, 0));
	createSquare(v1,v3,v5,v7,vec3( 0, 0, 1));
	createSquare(v0,v2,v4,v6,vec3( 0, 0,-1));
	

}







void main()
{
	vec4 sum = vec4(0,0,0,0);

	for( int i = 0 ; i < 3 ; i++ )
		sum = sum + gl_in[i].gl_Position;
	vec3 baricentre = vec3(sum.x/(3*step),sum.y/(3*step),sum.z/(3*step));
	vec3 punt_proper = round(baricentre) * step;

	float step2 = step / 2.;

	createCube(punt_proper,step2,step2,step2);

	

}
