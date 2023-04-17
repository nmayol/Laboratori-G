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

void main()
{
	vec4 sum = vec4(0,0,0,0);

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		sum = sum + gl_in[i].gl_Position;
	}
	vec3 baricentre = vec3(sum.x/(3*step),sum.y/(3*step),sum.z/(3*step));
	vec3 punt_proper = round(baricentre) * step;

	float step2 = step / 2.;

	vec3 v1 = vec3(punt_proper.x - step2, punt_proper.y - step2, punt_proper.z + step2); // 1
	process(v1);
	vec3 v2 = vec3(punt_proper.x - step2, punt_proper.y + step2, punt_proper.z + step2); // 3
	process(v2);
	vec3 v3 = vec3(punt_proper.x + step2, punt_proper.y - step2, punt_proper.z + step2); // 5
	process(v3);
	vec3 v4 = vec3(punt_proper.x + step2, punt_proper.y + step2, punt_proper.z + step2); // 7
	process(v4);
	gNorm = normalMatrix* vec3(0,0,1);
	EndPrimitive();

	vec3 v5 = vec3(punt_proper.x + step2, punt_proper.y - step2, punt_proper.z - step2); // 4
	process(v5);
	vec3 v6 = vec3(punt_proper.x + step2, punt_proper.y + step2, punt_proper.z - step2); // 6
	process(v6);
	vec3 v7 = vec3(punt_proper.x - step2, punt_proper.y - step2, punt_proper.z - step2); // 0
	process(v7);
	vec3 v8 = vec3(punt_proper.x - step2, punt_proper.y + step2, punt_proper.z - step2); // 2
	process(v8);
	gNorm = normalMatrix* vec3(0,0,-1);
	EndPrimitive();

	process(v8); process(v2); process(v6); process(v4);
	gNorm = normalMatrix* vec3(0,1,0);
    EndPrimitive();

	process(v3); process(v4); process(v5); process(v6);
	gNorm = normalMatrix* vec3(1,0,0);
    EndPrimitive();

	process(v1); process(v7); process(v3); process(v5);
	gNorm = normalMatrix* vec3(0,-1,0);
    EndPrimitive();

	process(v1); process(v2); process(v7); process(v8);
	gNorm = normalMatrix* vec3(-1,0,0);
    EndPrimitive();
}
