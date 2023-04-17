#version 330 core


out vec4 fragColor;
in vec2 vtexCoord;
uniform int mode = 2;



void main()
{

    vec4 col = vec4(0.8,0.8,0.8,0.8); 
    vec2 centre_gran = vec2(0.5,0.45); float dist_cap = distance(vtexCoord,centre_gran);
    vec2 orella1 = vec2(0.2,0.8); float dist_o1 = distance(vtexCoord,orella1);
    vec2 orella2 = vec2(0.8,0.8); float dist_o2 = distance(vtexCoord,orella2);
    
    float a = 0.25, b = 0.15;
    
    vec2 pomuls = vec2(0.5,0.325);
    float lim_pomul = pow(vtexCoord.x - pomuls.x,2) / pow (a,2) + pow(vtexCoord.y - pomuls.y,2) / pow (b,2);
    
    a = 0.225; b = 0.11;
    vec2 parpella1 = vec2(0.45,0.5); 
    float lim_p1 = pow(vtexCoord.x - parpella1.x,2) / pow (b,2) + pow(vtexCoord.y - parpella1.y,2) / pow (a,2);
    
    vec2 parpella2 = vec2(0.555,0.5); 
    float lim_p2 = pow(vtexCoord.x - parpella2.x,2) / pow (b,2) + pow(vtexCoord.y - parpella2.y,2) / pow (a,2);
    
    
    a = 0.14; b = 0.075;
    vec2 nineta1 = vec2(0.45,0.53); 
    float lim_n1 = pow(vtexCoord.x - nineta1.x,2) / pow (b,2) + pow(vtexCoord.y - nineta1.y,2) / pow (a,2);
    
    vec2 nineta2 = vec2(0.55,0.53); 
    float lim_n2 = pow(vtexCoord.x - nineta2.x,2) / pow (b,2) + pow(vtexCoord.y - nineta2.y,2) / pow (a,2);
    
    if (mode > 1 && (lim_n1 <= 1 || lim_n2 <= 1)) {
    	if (lim_n1 <= 0.25 || lim_n2 <= 0.25) col = vec4(0,0,0,1.);
    	else col = vec4(1.);
    }
    else if (mode > 0 && (lim_pomul <= 1 || lim_p1 <= 1 || lim_p2 <= 1)) col = vec4(1.0, 0.8, 0.6,1.);
    else if (dist_cap <= 0.35 || dist_o1 <= 0.2 || dist_o2 <= 0.2) col = vec4(0,0,0,1.);
    
    
    fragColor = col;
}
