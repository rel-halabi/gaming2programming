PVector[] points;

void setup()
{
  size(1280, 720);
  initPoints(10);
}

void draw()
{
  background(#1c1c1c);
  voronoi();
  fill(255, 255, 0, 120);
  beginShape();
  for(int i = 0; i < points.length - 2; i++)
  {
    PVector p = voronoiPoint(points[i], points[i+1], points[i+2]);
    stroke(255,255,0);
    strokeWeight(5);
    point(p.x, p.y);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
  points[points.length-1].set(mouseX, mouseY);
}

void initPoints(int numPoints)
{
  points = new PVector[numPoints];
  for(int i = 0; i < numPoints; i++)
  {
    points[i] = new PVector(random(0, width), random(0, height), color(random(100, 255),random(100, 255),random(100, 255)));
  }
}

float taxicabDist(float x1, float y1, float x2, float y2)
{
  return abs(x1-x2)+abs(y1-y2);
}

void voronoi()
{
  int closest = 0;
  loadPixels();
  for(int y = 0; y < height; y++)
  {
    for(int x = 0; x < width; x++)
    {
      for(int i = 0; i < points.length; i++)
      {
        if(dist(x, y, points[i].x, points[i].y) < dist(x ,y,points[closest].x, points[closest].y)) closest = i;
      }
      pixels[y*width + x] = (color)points[closest].z;
    }
  }
  updatePixels();
  for(PVector p : points)
  {
    stroke(255,0,0);
    strokeWeight(5);
    point(p.x, p.y);
  }
}

PVector voronoiPoint(PVector a, PVector b, PVector c)
{
  float m1 = -1/((b.y-a.y)/(b.x-a.x));
  float m2 = -1/((c.y-a.y)/(c.x-a.x));
  
  PVector mid1 = new PVector((a.x+b.x)/2,(a.y+b.y)/2);
  PVector mid2 = new PVector((a.x+c.x)/2,(a.y+c.y)/2);
  
  float b1 = mid1.y - mid1.x*m1;
  float b2 = mid2.y - mid2.x*m2;
  
  float x = (b2-b1)/(m1-m2);
  float y = m1*x + b1;
  
  return new PVector(x, y);
}
