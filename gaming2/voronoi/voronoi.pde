PVector[] points;

void setup()
{
  size(1280, 720);
  points  = new PVector[]
  {
    new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255)))
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255))),
    //new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255)))
  };
}



void draw()
{
  background(#1c1c1c);
  points[points.length-1].x = mouseX;
  points[points.length-1].y = mouseY;
  
  stroke(255,0,0);
  strokeWeight(5);
  point(200, 200);
  point(300, 300);
  point(50, 300);
  stroke(255);
  PVector e = voronoiPoint(200, 200, 300, 300, 50, 300);
  point(e.x, e.y);
  println(e);
  
  //voronoi(points);
}

PVector centerFind(PVector[] points)
{
  float x = 0;
  float y = 0;
  for(int i = 0; i < points.length; i++)
  {
    x += points[i].x;
    y += points[i].y;
  }
  x /= points.length;
  y /= points.length;
  
  return new PVector(x, y);
}

float someDist(float x1, float y1, float x2, float y2)
{
  return max(abs(x1-x2), abs(y1-y2));
}

float manhattanDist(float x1, float y1, float x2, float y2)
{
  return abs(x1-x2)+abs(y1-y2);
}

void voronoi(PVector[] points)
{

  loadPixels();
  for(int x = 0; x < width; x++)
  {
    for(int y = 0; y < height; y++)
    {
      //int pclosest = 0;
      int closest = 0;
      for(int p = 1; p < points.length; p++)
      {
        if (dist(x, y, points[p].x, points[p].y) < dist(x, y, points[closest].x, points[closest].y)) closest = p;
      }
      pixels[y*width + x] = (color)points[closest].z; //map(dist(x, y, points[closest].x, points[closest].y), 0, dist(points[pclosest].x, points[pclosest].y, points[closest].x, points[closest].y), points[pclosest].z, points[closest].z);
    }
  }
  updatePixels();
  for(PVector p : points)
  {
    strokeWeight(3);
    stroke(255, 0, 0);
    point(p.x, p.y);
  }
}

PVector voronoiPoint(float x1, float y1, float x2, float y2, float x3, float y3)
{
  PVector q1 = new PVector((x1 + x2)/2, (y1 + y2)/2);
  PVector q2 = new PVector((x1 + x3)/2, (y1 + y3)/2);
  
  PVector perp1 = new PVector(y2 - y1, -(x2 - x1));
  PVector perp2 = new PVector(y3 - y1, -(x3 - x1));
  
  PVector l1 = new PVector(q1.x + perp1.x, q1.y + perp1.y);
  PVector l2 = new PVector(q2.x + perp2.x, q2.y + perp2.y);
  
  float a1 = q1.y - l1.y;
  float b1 = l1.x - q1.x;
  float c1 = a1*l1.x + b1*l1.y;
  
  float a2 = q2.y - l2.y;
  float b2 = l2.x - q2.x;
  float c2 = a2*l2.x + b2*l2.y;
  
  double det = a1*b2 - a2*b1;
  
  //return q1;
  
  if(det == 0) return null;
  else return new PVector((b2 * c1 - b1 * c2), (a1 * a2 - a2 * a1));
}
