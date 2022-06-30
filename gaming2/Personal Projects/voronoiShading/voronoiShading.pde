int numOfPoints = 100;
PVector[] points;
void setup()
{
  size(1280, 720);
  points = new PVector[numOfPoints];
  initArray();
  background(0);
  voronoi();
  seePoints();
  
}

void draw()
{
  if(keyPressed)
  {
    voronoi();
  }
}

void keyPressed()
{
  background(0);
  generateNewPoints();
}

void generateNewPoints()
{
  for(int i = 0; i < points.length; i++)
  {
    points[i].x = random(0, width);
    points[i].y = random(0, height);
  }
}

void voronoi()
{
  loadPixels();
  for(int y = 0; y < height; y++)
  {
    for(int x = 0; x < width; x++)
    {
      int i = getClosest(x, y);
      pixels[y*width + x] = (int)points[i].z;
    }
  }
  updatePixels();
}

void seePoints()
{
  for(PVector p : points)
  {
    stroke(255, 0, 0);
    strokeWeight(3);
    point(p.x, p.y);
  }
}

int getClosest(float x, float y)
{
  int closest = 0;
  for(int i = 0; i < points.length; i++)
  {
    if(dist(points[closest].x, points[closest].y, x, y) > dist(points[i].x, points[i].y, x, y)) closest = i;
  }
  
  return closest;
}

void initArray()
{
  for(int i = 0; i < points.length; i++)
  {
    points[i] = new PVector(random(0, width), random(0, height), color(random(100, 255), random(100, 255), random(100, 255)));
  }
}
