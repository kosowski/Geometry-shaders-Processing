#version 120
#extension GL_EXT_geometry_shader4: enable

uniform float Shrink;
varying in vec3 Normal[3];
varying in vec4 v_Color[3];
varying out vec3 posEye;
varying out vec3 normalEye;
varying out vec4 vColor;


vec4 V[3];
vec4 CG;

void ProduceVertex( int v ){
	normalEye = gl_NormalMatrix * Normal[v];
	posEye = (gl_ModelViewMatrix * ( CG + Shrink * (V[v] - CG) )).xyz;
	vColor = v_Color[v];
	gl_Position = gl_ModelViewProjectionMatrix * ( CG + Shrink * (V[v] - CG) );
	EmitVertex();
}

void main(){
  
  V[0] = gl_PositionIn[0];
  V[1] = gl_PositionIn[1];
  V[2] = gl_PositionIn[2];
  CG = ( V[0] + V[1] + V[2] ) / 3.;
  ProduceVertex(0);
  ProduceVertex(1);
  ProduceVertex(2);
  EndPrimitive();
  
}