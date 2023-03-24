#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 N1[];
out vec4 gfrontColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform float time;

const float speed = 0.5;


void main( void )
{
	vec3 n = (N1[0] + N1[1] + N1[2]) / 3 ;
	vec3 trans = speed * time * n;
	for( int i = 0 ; i < 3 ; i++ )
	{
		
		gfrontColor = vfrontColor[i];
		mat4 TG = mat4(vec4(1,0,0,0), vec4(0,1,0,0),vec4(0,0,1,0),vec4(trans,1.));
		gl_Position = modelViewProjectionMatrix*(TG*gl_in[i].gl_Position);
		EmitVertex();
	}
    EndPrimitive();
}
