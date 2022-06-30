class Point
{
  PVector pos;
  color c;
  
  Point(float x, float y, color _c)
  {
    pos = new PVector(x, y);
    c = _c;
  }
  
  void display()
  {
    push();
    translate(pos.x, pos.y);
    noStroke();
    fill(c);
    circle(0, 0, 10);
    pop();
  }
}
