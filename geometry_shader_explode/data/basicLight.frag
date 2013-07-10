varying vec4 vColor;
varying vec3 posEye;
varying vec3 normalEye;

void main(void)
{
    vec3 L = normalize(gl_LightSource[0].position.xyz - posEye);   
	float Idiff =  max(dot(normalEye,L), 0.0);     
	gl_FragColor = vec4( vColor.rgb * Idiff, vColor.a);
}
