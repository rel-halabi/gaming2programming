OBB box;

void setup()
{
  size(1280, 720);
  PVector[] boxPoints = new PVector[]
  {
    new PVector(-50, -50),
    new PVector(0, -100),
    new PVector(50, -50),
    new PVector(50, 50),
    new PVector(-50, 50)
  };
  box = new OBB(boxPoints);
}

void draw()
{
  background(#1c1c1c);
  stroke(#fefefe);
  noFill();
  
  box.rotate(PI/4);
  box.scale(100);
  box.translate(width/2, height/2);
  box.display();
  
  for(int i = 0; i < 5; i++)
  {
    println(box.original[i], box.transformed[i], i);
    println(mouseX, mouseY);
  }
}

class OBB
{
  PVector[] original, transformed;
  
  OBB(PVector[] points)
  {
    original = new PVector[points.length];
    transformed = new PVector[points.length];
    for(int i = 0; i < points.length; i++)
    {
      original[i] = points[i].normalize();
      transformed[i] = original[i].copy();
    }
  }
  
  void render()
  {
    beginShape();
    for(int i = 0; i < transformed.length; i++)
    {
      vertex(transformed[i].x, transformed[i].y);
    }
    endShape(CLOSE);
  }
  
  void display()
  {
    render();
  }
  
  void rotate(float angle)
  {
    float cosine = cos(angle);
    float sine = sin(angle);
    for(int i = 0; i < original.length; i++)
    {
      float rotX = original[i].x*cosine - original[i].y*sine;
      float rotY = original[i].x*sine + original[i].y*cosine;
      transformed[i].set(rotX, rotY);
    }
  }
  
  void scale(float factor)
  {
    for(int i = 0; i < original.length; i++)
    {
      transformed[i].x = original[i].x*factor;
      transformed[i].y = original[i].y*factor;
    }
  }
  
  void translate(float x, float y)
  {
    for(int i = 0; i < original.length; i++)
    {
      transformed[i].x = original[i].x + x;
      transformed[i].y = original[i].y + y;
    }
  }
  
  
}
