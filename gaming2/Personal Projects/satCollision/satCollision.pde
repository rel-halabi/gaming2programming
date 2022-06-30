Shape s;

void setup()
{
  size(1280, 720);
  PVector[] points = new PVector[]
  {
    new PVector(0, -1),
    new PVector(-1, 1),
    new PVector(1, 1)
  };
  s = new Shape(points, true);
}

void draw()
{
  background(#1c1c1c);
  stroke(#fefefe);
  noFill();
  s.setTransform(width/2, height/2, PI/6, 50);
  s.display();
}

void sat(Shape a, Shape b)
{

}

class Shape
{
  PVector[] vertices;
  PVector[] normals;
  float x,y,a,s;
  
  Shape(PVector[] points, boolean normalize)
  {
    if(!normalize) vertices = points;
    else
    {
      vertices = new PVector[points.length];
      for(int i = 0; i < points.length; i++)
      {
        vertices[i] = points[i].copy().normalize();
      }
    }
    x = 0;
    y = 0;
  }
  
  void display()
  {
    render();
  }
  
  void calculateNormals()
  {
    
  }
  
  void setTransform(float x, float y, float a, float s)
  {
    setTranslation(x,y);
    setRotation(a);
    setScale(s);
  }
  
  void setScale(float s)
  {
    this.s = s;
  }
  
  void setTranslation(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  void setRotation(float a)
  {
    this.a = a;
  }
  
  void render()
  {
    beginShape();
    for(PVector v : vertices)
    {
      vertex(((v.x*s)*cos(a)-(v.y*s)*sin(a)) + x, ((v.x*s)*sin(a)+(v.y*s)*cos(a)) + y);
    }
    endShape(CLOSE);
  }
}
