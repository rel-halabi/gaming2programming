PShape s;
float scale;
float rotation;

//create shape file using https://editor.method.ac/, save as .svg
void setup() {
  size(800, 600);
  s = loadShape("starzyk5822.svg");
  scale = 1;
}

void draw() {
  background(90);
  myshape(mouseX, mouseY, scale, rotation);
}

void myshape(float x, float y, float scale, float rotation) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  rotate(rotation);
  shapeMode(CENTER);
  shape(s, 0, 0);
  popMatrix();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scale += e * 0.1;
}

void keyPressed() {
  if (key == 'd') {
    rotation+= 0.01;
  }
  if (key == 'a') {
    rotation-= 0.01;
  }
}
