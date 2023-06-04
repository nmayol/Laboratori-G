#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;

uniform float time;
uniform float SIZE;

const int W = 20; // filter size: 2W*2W

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
    
    fragColor = texture2D(colorMap, st + 0.01*sin(10*time+30*st.s));
    //fragColor = texture2D(colorMap, st);
    
}

