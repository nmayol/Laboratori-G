#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
in vec4 vx;
uniform sampler2D colorMap;



void main()
{

    float factor = float(1./6.);
    
    
    vec2 coord2;
    float coordX = mod(vtexCoord.x*6/10,0.1);
    
    
    if (vtexCoord.x < factor) {
    	coord2 = vec2((0.4 + coordX),vtexCoord.y);
    }
    else if (vtexCoord.x < factor * 2.) {
    	coord2 = vec2((0.9 + coordX),vtexCoord.y);
    }
    else if (vtexCoord.x < factor * 3.) {
    	coord2 = vec2((0.2 + coordX),vtexCoord.y);
    }
    else if (vtexCoord.x < factor * 4.) {
    	coord2 = vec2((0.9 + coordX) ,vtexCoord.y);
    }
    else if (vtexCoord.x < factor * 5.) {
    	coord2 = vec2((0.8 + coordX),vtexCoord.y);
    }
    else{
    	coord2 = vec2((coordX),vtexCoord.y);
    }
   
    vec4 col = texture(colorMap, coord2);
    if (col.a < 0.5) discard;
    fragColor = col * vec4(0,0,1,1);
}
