#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 N1[];
out vec4 gfrontColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform float time;

const float speed = 1.2;


void main( void )
{
	vec3 n = (N1[0] + N1[1] + N1[2]) / 3 ;
	vec3 trans = speed * time * n;
	for( int i = 0 ; i < 3 ; i++ )
	{
		
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix*(gl_in[i].gl_Position + trans[i]);
		EmitVertex();
	}
    EndPrimitive();
}
