#version 120
#extension GL_EXT_geometry_shader4: enable

uniform float Explode;
varying in vec3 Normal[3];
varying in vec4 v_Color[3];
varying out vec3 posEye;
varying out vec3 normalEye;
varying out vec4 vColor;

vec4 V[3];

void ProduceVertex( int v ){
	vec3 face_normal = normalize ( cross (V[2].xyz - V[0].xyz, V[1].xyz - V[0].xyz));			
	vec4 newPos = V[v] + vec4(Explode*face_normal,0.);

	normalEye = gl_NormalMatrix * face_normal;
	posEye = (gl_ModelViewMatrix * newPos ).xyz;
    vColor = v_Color[v];  
    gl_Position = gl_ModelViewProjectionMatrix *newPos ;
    EmitVertex();
}

void main()
{
	V[0] = gl_PositionIn[0];
	V[1] = gl_PositionIn[1];
	V[2] = gl_PositionIn[2];
	ProduceVertex(0);
	ProduceVertex(1);
	ProduceVertex(2);
	EndPrimitive();
}

