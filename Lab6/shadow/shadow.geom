#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;


uniform mat4 modelViewProjectionMatrix;

uniform vec3 boundingBoxMin;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();
	for( int i = 0 ; i < 3 ; i++ )
	{
		
		float Y = boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix *  vec4(gl_in[i].gl_Position.x,Y,gl_in[i].gl_Position.z,gl_in[i].gl_Position.w);
		gfrontColor = vec4(0.); 
		EmitVertex();
	}
    	EndPrimitive();
}
