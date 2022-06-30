float t = 0;
DraggablePoint a[] = new DraggablePoint[5];

void setup()
{
  size(700,700);
  background(0);
  a[0] = new DraggablePoint(10,10);
  a[1] = new DraggablePoint(200,600);
  a[2] = new DraggablePoint(600,300);
  a[3] = new DraggablePoint(300, 200);
  a[4] = new DraggablePoint(350, 350);
}

void draw()
{
  background(0);
 
  for(DraggablePoint p : a)
  {
    p.display();
  }
  for (float time = 0; time < width; time+=1)
  {
    PVector points[] = new PVector[a.length];
    for(int i = 0; i < a.length; i++)
    {
      points[i] = a[i].pos;
    }
    stroke(255);
    strokeWeight(1);
    point(time, lagrangeInterpolation(points, time));
    line(time, lagrangeInterpolation(points, time), time-1, lagrangeInterpolation(points, time-1));
    //println(time, lagrangeInterpolation(points, time));
  }
}

void mouseDragged()
{
  for(DraggablePoint p : a)
  {
    p.drag();
  }
}

void keyPressed()
{  
  if(key == ' ')
  {
    t+=1;
  }
  if (key == 'c')
  {
    background(0);
  }
  if(key == 'r')
  {
    t = 0;
  }
}

class DraggablePoint
{
  PVector pos;
  
  DraggablePoint(float x, float y)
  {
    pos = new PVector(x, y);
  }
  
  void display()
  {
    push();
    stroke(255,0,0);
    strokeWeight(5);
    point(pos.x, pos.y); 
    noFill();
    strokeWeight(1);
    circle(pos.x, pos.y, 20);
    pop();
  }
  
  void drag()
  {
   // println(dist(mouseX, mouseY, pos.x, pos.y));
    if (dist(mouseX, mouseY, pos.x, pos.y) < 10)
    {
      println("dragged", pos.x, pos.y);
      pos.x = mouseX;
      pos.y = mouseY;
    }
  }
}

float lagrangeInterpolation(PVector[] points, float t)
{
  float numerators[] = new float[points.length];
  float denominators[] = new float[points.length];
  float interpolated = 0;
  
  for(int i = 0; i < points.length; i++)
  {
    numerators[i] = 1;
    denominators[i] = 1;
    for(int p = 0; p < points.length; p++)
    {
      if (p != i)
      {
        numerators[i] *= (t - points[p].x);
        denominators[i] *= (points[i].x - points[p].x);
      }
    }
  }
  for(int i = 0; i < points.length; i++)
  {
    interpolated += points[i].y * (numerators[i]/denominators[i]);
  }
  
  return interpolated;
}

float lagrange(PVector a, PVector b, PVector c, float t)
{
  float f = a.y * (((t-b.x)*(t-c.x))/((a.x-b.x)*(a.x-c.x)));
  float g = b.y * (((t-a.x)*(t-c.x))/((b.x-a.x)*(b.x-c.x)));
  float h = c.y * (((t-a.x)*(t-b.x))/((c.x-a.x)*(c.x-b.x)));
  
  float interpolated = f + g + h;
  
  return interpolated;
}
