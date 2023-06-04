#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 256) out;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
in vec3 vN[];


out vec2 gtexCoord;
out vec3 gNorm;
out vec4 gfrontColor;

uniform float time;




void process(vec3 v,vec3 n) {
	if (gl_PrimitiveIDIn < 4) {
		mat3 TG = mat3(	vec3( cos(time),sin(time),0),
					vec3(-sin(time),cos(time),0),
					vec3(0,0,1));

		gl_Position = modelViewProjectionMatrix * vec4(TG*v,1.);
	}
	else gl_Position = modelViewProjectionMatrix * vec4(v,1.);
	
	if (n == vec3(1,0,0)) gtexCoord=vec2((v.z+2)/4.,(v.y+2)/4.); 
	else if (n == vec3(0,1,0)) gtexCoord= vec2((v.x+2)/4.,(v.z+2)/4.);
	else if (n == vec3(0,-1,0)) gtexCoord= vec2((v.x+2)/4.,(v.z+2)/4.);
	else if (n == vec3(0,0,1)) gtexCoord= vec2((v.x+2)/4.,(v.y+2)/4.);
	else if (n == vec3(0,0,-1)) gtexCoord= vec2((v.x+2)/4.,(v.y+2)/4.);
	else if (n == vec3(-1,0,0)) gtexCoord=vec2((v.z+2)/4.,(v.y+2)/4.); 
	
	
	

	
	EmitVertex();
}

//	1.______________.2
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	3.______________.4


void pintaCara(vec3 gNorm) {
	if (gNorm.y < 0) gfrontColor = vec4(1.0,0.6,0.0,0.0);
	else if (gNorm.x < 0) gfrontColor = vec4(0.0,1.0,0.0,0.0);
	else if (gNorm.z < 0) gfrontColor = vec4(1.0);
	else if (gNorm.y > 0) gfrontColor = vec4(1.0,0.0,0.0,0.0);
	else if (gNorm.x > 0) gfrontColor = vec4(0.0,0.0,1.0,0.0);
	else if (gNorm.z > 0) gfrontColor = vec4(1.0,1.0,0.0,0.0);

}

void createSquare(vec3 v1, vec3 v2, vec3 v3, vec3 v4, vec3 n) {
	process(v1,n);
	process(v2,n);
	process(v3,n);
	process(v4,n);

	// gNorm ha de tinr el mateix nom que la variable out, i entra al frag shader
	gNorm = n;
	pintaCara(gNorm);
	EndPrimitive();
	
}

void createCube(vec3 centre, float meitatCostat) {
	vec3 v0 = vec3(centre.x - meitatCostat, centre.y - meitatCostat, centre.z - meitatCostat);
	vec3 v1 = vec3(centre.x - meitatCostat, centre.y - meitatCostat, centre.z + meitatCostat);
	vec3 v2 = vec3(centre.x - meitatCostat, centre.y + meitatCostat, centre.z - meitatCostat);
	vec3 v3 = vec3(centre.x - meitatCostat, centre.y + meitatCostat, centre.z + meitatCostat);
	vec3 v4 = vec3(centre.x + meitatCostat, centre.y - meitatCostat, centre.z - meitatCostat);
	vec3 v5 = vec3(centre.x + meitatCostat, centre.y - meitatCostat, centre.z + meitatCostat);
	vec3 v6 = vec3(centre.x + meitatCostat, centre.y + meitatCostat, centre.z - meitatCostat);
	vec3 v7 = vec3(centre.x + meitatCostat, centre.y + meitatCostat, centre.z + meitatCostat);

	
	createSquare(v4,v5,v6,v7,vec3( 1, 0, 0));
	createSquare(v0,v1,v2,v3,vec3(-1, 0, 0));
	createSquare(v2,v3,v6,v7,vec3( 0, 1, 0));
	createSquare(v0,v1,v4,v5,vec3( 0,-1, 0));
	createSquare(v1,v3,v5,v7,vec3( 0, 0, 1));
	createSquare(v0,v2,v4,v6,vec3( 0, 0,-1));
	

}




void main( void )
{
	vec3 T[8] = vec3[8](vec3(-1,-1,-1),
						vec3( 1,-1,-1),
						vec3(-1, 1,-1),
						vec3( 1, 1,-1),
						vec3(-1,-1, 1),
						vec3( 1,-1, 1),
						vec3(-1, 1, 1),
						vec3( 1, 1, 1)
						);
	

	if (gl_PrimitiveIDIn <= 7) {
		createCube(T[gl_PrimitiveIDIn],1);
	}
	


	// for( int i = 0 ; i < 3 ; i++ )
	// {
	// 	gfrontColor = vec4(0);
	// 	gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
	// 	EmitVertex();
	// }
    // EndPrimitive();
}
