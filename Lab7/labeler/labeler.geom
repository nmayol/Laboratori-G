#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec2 vtexCoords[];
out vec2 gtexCoord;
out vec4 gfrontColor;
uniform mat4 modelViewProjectionMatrix;
uniform float size = 0.07; 
uniform float depth = -0.01;
uniform mat3 normalMatrix;
out vec3 gNorm; 

vec3 C;

void process(vec3 v) {

	gl_Position = modelViewProjectionMatrix * vec4(v,1.);
	gtexCoord = vec2((v.x-(C.x-1.5*size))/(3*size),(v.y-(C.y-size))/(2*size));
	EmitVertex();
}

//	1.______________.2
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	 |				|
//	3.______________.4

void createRectangle(vec3 v1, vec3 v2, vec3 v3, vec3 v4) {
	process(v1);
	process(v2);
	process(v3);
	process(v4);

	EndPrimitive();
}




void main( void )
{
	vec3 sumaNDC = vec3(0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		gtexCoord = vtexCoords[i];
		sumaNDC = sumaNDC + gl_Position.xyz / gl_Position.w ;
		EmitVertex();
	}
	C = sumaNDC / 3.;

    EndPrimitive();
	gfrontColor = vec4(1,1,0,0);
	createRectangle(vec3(C.x-1.5*size,C.y+size,C.z+depth),
					vec3(C.x+1.5*size,C.y+size,C.z+depth),
					vec3(C.x-1.5*size,C.y-size,C.z+depth),
					vec3(C.x+1.5*size,C.y-size,C.z+depth));

	
}
