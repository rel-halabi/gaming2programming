Simon s;

void setup() {
  size(700,700);
  s = new Simon(width/2,height/2);
}

void draw() {
  background(120);
  s.draw();
}
