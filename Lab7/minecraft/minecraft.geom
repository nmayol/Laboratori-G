#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;


uniform int N = 300;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
out vec2 gtexCoord;
out vec3 gNorm;
uniform int mode = 0;
out vec4 C;

void process(vec3 v, vec2 tex) {
	gl_Position = modelViewProjectionMatrix * vec4(v,1.);
	if (mode == 2)	gtexCoord = tex;
	EmitVertex();
}

//	4.______________.2
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	3.______________.1

void createSquare(vec3 v1, vec3 v2, vec3 v3, vec3 v4, vec3 n) {
	// gNorm ha de tinr el mateix nom que la variable out, i entra al frag shader
	gNorm = normalize(normalMatrix* n);
	if (mode == 1) {
		gfrontColor = vec4(gNorm.z,gNorm.z,gNorm.z,1.0);
	}

	if (mode == 2 && n == vec3(0,0,1)) {
		process(v1,vec2(1,0));
		process(v2,vec2(1,1));
		process(v3,vec2(0,0));
		process(v4,vec2(0,1));
	}
	else {
		process(v1,vec2(-1,-1));
		process(v2,vec2(-1,-1));
		process(v3,vec2(-1,-1));
		process(v4,vec2(-1,-1));
	}
	

	
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

void main( void )
{
	if (gl_PrimitiveIDIn % N == 0) {
		//Sigui C la mitjana dels vèrtexs del triangle (en object space).
		vec4 sum = vec4(0);
		vec4 sumc = vec4(0);
		for( int i = 0 ; i < 3 ; i++ )
		{
			if (mode != 1) sumc = sumc + vfrontColor[i];
			sum = sum + gl_in[i].gl_Position;
		}
		if (mode != 1) gfrontColor = sumc / 3.;
		C = sum / 3.;
		vec4 punt_proper = round(C);
		createCube(punt_proper.xyz,.5,.5,.5);
    	//EndPrimitive();

	}
	

}
