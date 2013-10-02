/*
 Geometry shader explode by Nacho Cossio
 www.nachocossio.com
 https://github.com/kosowski
 
 This sketch illustrates how  to calculate primitive’s normals and displace its vertices
 in this direction using GLSL geometry shaders.
 
 Mouse controls the light position.
 
 Built with Processing 1.5.1 and GLGraphics 1.0 
 */
import codeanticode.glgraphics.*;
import processing.opengl.PGraphicsOpenGL;

GLModel sphere1;
GLSLShader vertexShader;

boolean useShader = true;

void setup() {
  size(800, 800, GLConstants.GLGRAPHICS);
  vertexShader = new GLSLShader(this, "basicVertex.vert", "triangleExplode.geo", "basicLight.frag");  
  int n = vertexShader.getMaxOutVertCount();
  println("max vertices "+n);
  // it is necessary to init the primitive used and the max number of
  //vertices that the geometry shader can output
  vertexShader.setupGeometryShader(TRIANGLES, TRIANGLES, 3);
  //If the sketch runs too slow, the number of polygons used for the sphere can be lowered (first parameter)
  sphere1 = createSphere(100, 200);
  sphere1.setTint(242,231, 105);
}

void draw() {
  background(0);
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL(); 
  vertexShader.start();
  vertexShader.setFloatUniform("Explode", 60 * (1 + sin(millis() * 0.002)));

  noLights();
  pointLight(255, 255, 255, mouseX, mouseY, 600);
  translate(width/2, height/2, 0);
  renderer.model(sphere1);

  vertexShader.stop();
  renderer.endGL();
}

