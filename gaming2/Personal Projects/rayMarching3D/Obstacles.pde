class Obstacle
{
  PVector center;
  float w, h, l;
  
  Obstacle(float x, float y, float z, float _w, float _h, float _l)
  {
    center = new PVector(x, y, z);
    w = _w;
    h = _h;
    l = _l;
  }
  
  void display()
  {
    
  }
  
}

class Sphere extends Obstacle
{
  float radius;
  
  Sphere(float x, float y, float z, float r)
  {
    super(x, y, z, r, r, r);
    radius = r;
  }
  
  void display()
  {
    push();
    translate(center.x, center.y, center.z);
    sphere(w);
    pop();
  }
}

class Box extends Obstacle
{
  Box(float x, float y, float z, float _w, float _h, float _l)
  {
    super(x, y, z, _w, _h, _l);
  }
  
  void display()
  {
    push();
    rectMode(CENTER);
    translate(center.x, center.y, center.z);
    box(w, h, l);
    pop();
  }
}
