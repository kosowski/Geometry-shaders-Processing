/*
 Geometry shader tessellation by Nacho Cossio
 www.nachocossio.com
 https://github.com/kosowski
 
 This sketch shows how to add new vertices and primitives using GLLSL geometry shaders.
 Each triangle is tessellated by adding a new vertex and defining two triangles with these four points.

 Press any key to turn the shader on/off and see the difference.
 
 Mouse controls the light position.
 
 Built with Processing 1.5.1 and GLGraphics 1.0 
*/
import codeanticode.glgraphics.*;
import processing.opengl.PGraphicsOpenGL;
import javax.media.opengl.GL;

GLModel sphere1;
GLSLShader vertexShader;

boolean useShader = true;

void setup() {
  size(800, 800, GLConstants.GLGRAPHICS);
  vertexShader = new GLSLShader(this, "basicVertex.vert", "triangleDivider.geo", "basicLight.frag");  
  int n = vertexShader.getMaxOutVertCount();
  println("max vertices "+n);
  // it is necessary to init the primitive used and the max number of
  //vertices that the geometry shader can output
  vertexShader.setupGeometryShader(TRIANGLES, TRIANGLES, n);
  sphere1 = createSphere(30, 200);
  sphere1.setTint(242,231, 105);
}

void draw() {
  background(0);
  GLGraphics renderer = (GLGraphics)g;
  GL gl = renderer.beginGL(); 
  if (useShader) 
    vertexShader.start();
  else
    // use per vertex lighting to see the difference
    gl.glShadeModel(GL.GL_FLAT);
    
  noLights();
  pointLight(255,255,255,mouseX,mouseY,800);
  translate(width/2, height/2,0);
  renderer.model(sphere1);

  if (useShader)vertexShader.stop();
  renderer.endGL();
}


void keyPressed() {
  useShader = ! useShader;
}

