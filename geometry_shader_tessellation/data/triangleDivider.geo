#version 120
#extension GL_EXT_geometry_shader4: enable


varying in vec3 Normal[3];
varying in vec4 v_Color[3];
varying out vec3 posEye;
varying out vec3 normalEye;
varying out vec4 vColor;

vec4 V[4];

void ProduceVertex( int v , vec3 n){  
  if(v==3){
	vColor =  v_Color[2];}
  else{
	vColor = v_Color[v];}
  
  gl_Position = gl_ModelViewProjectionMatrix * V[v];
  normalEye = gl_NormalMatrix * n;
  posEye = (gl_ModelViewMatrix * V[v]).xyz;
  
  EmitVertex();
}

void main(){
  
  V[0] = normalize(gl_PositionIn[0]);
  V[1] = normalize(gl_PositionIn[1]);
  V[2] = normalize(gl_PositionIn[2]);
  V[3] = normalize(V[1] + V[2]);
	
  vec3 normal = normalize ( cross (V[3].xyz - V[0].xyz, V[1].xyz - V[0].xyz));
  ProduceVertex(0, normal);
  ProduceVertex(1, normal);
  ProduceVertex(3, normal);
  normal = normalize ( cross (V[2].xyz - V[0].xyz, V[3].xyz - V[0].xyz) );
  ProduceVertex(0, normal);
  ProduceVertex(3, normal );
  ProduceVertex(2, normal );
  EndPrimitive();
}