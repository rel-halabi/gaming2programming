class Obstacle
{
  PVector center;
  float w, h;
  
  Obstacle(float x, float y, float _w, float _h)
  {
    center = new PVector(x, y);
    w = _w;
    h = _h;
  }
  
  void display()
  {
    
  }
  
}

class Circle extends Obstacle
{
  float radius;
  
  Circle(float x, float y, float r)
  {
    super(x, y, r, r);
    radius = r;
  }
  
  void display()
  {
    circle(center.x, center.y, radius);
  }
}

class Box extends Obstacle
{
  Box(float x, float y, float _w, float _h)
  {
    super(x, y, _w, _h);
  }
  
  void display()
  {
    push();
    rectMode(CENTER);
    rect(center.x, center.y, w, h);
    pop();
  }
}
