varying vec3 Normal;
varying vec4 v_Color;

void main(void)
{
    Normal = gl_Normal;
	v_Color = gl_Color;
    gl_Position = gl_Vertex;
}