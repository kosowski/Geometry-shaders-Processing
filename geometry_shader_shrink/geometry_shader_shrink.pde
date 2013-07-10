/*
 Geometry shader shrink by Nacho Cossio
 www.nachocossio.com
 https://github.com/kosowski
 
 This example shows how to manipulate primitives, triangles in this case, using a GLSL geometry shader.
 The centre point of the triangle is calculated and the vertices moved towards it, creating a shrink effect.

 Mouse controls the light position.
 
 Built with Processing 1.5.1 and GLGraphics 1.0 
 */

import codeanticode.glgraphics.*;
import processing.opengl.PGraphicsOpenGL;

GLModel sphere1;
GLSLShader vertexShader;

void setup() {
  size(800, 800, GLConstants.GLGRAPHICS);
  vertexShader = new GLSLShader(this, "basicVertex.vert", "triangleShrinker.geo", "basicLight.frag");  
  int n = vertexShader.getMaxOutVertCount();
  println("max vertices "+n);
  // it is necessary to init the primitive used and the max number of
  //vertices that the geometry shader can output
  vertexShader.setupGeometryShader(TRIANGLES, TRIANGLES, 3);
  sphere1 = createSphere(20, 200);
  sphere1.setTint(206, 186, 0);
}

void draw() {
  background(0);
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL(); 

  vertexShader.start();
  vertexShader.setFloatUniform("Shrink", 3 * (1 + sin(millis() * 0.001)));

  noLights();
  pointLight(255, 255, 255, mouseX, mouseY, 600);
  translate(width/2, height/2, 0);
  renderer.model(sphere1);

  vertexShader.stop();
  renderer.endGL();
}
