import peasy.*;
PeasyCam cam;
PVector[] sphere = generateRandomPoints(500);
void setup()
{
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 500);
}

void draw()
{
  background(#1c1c1c);
  drawPoints(sphere);
  //Axes Visualization
  //strokeWeight(2);
  //stroke(0, 0, 255);
  //line(0, 0, 0, 0, 0, 100);
  //stroke(0, 255, 0);
  //line(0, 0, 0, 0, 100, 0);
  //stroke(255, 0, 0);
  //line(0, 0, 0, 100, 0, 0);
  
}

void spherePoints()
{
  float detail = 25;
  for(float r = 10; r < 100; r += 10)
  {
    PVector p = sphereToCart(r, 0, 0);
    for(float i = 0; i < 2*PI; i += PI/detail)
    {
      for(float j = 0; j < PI; j += PI/detail)
      {
        PVector c = sphereToCart(r, j, i);
        stroke(map(i, 0, 2*PI, 0, 255), map(j, 0 , PI, 0, 255), map(r, 10, 100, 0, 255));
        strokeWeight(1);
        point(c.x, c.y, c.z);
        strokeWeight(0.5);
        line(p.x, p.y, p.z, c.x, c.y, c.z);
        p = c;
      }
    }
  }
  
}

void drawPoints(PVector[] points)
{
  for(int i = 0; i < points.length; i++)
  { 
    noFill();
    stroke(#363636);
    strokeWeight(1);
    sphere(100);
    stroke(#fe5353);
    strokeWeight(3);
    point(points[i].x, points[i].y, points[i].z);
  }
}

PVector[] generateRandomPoints(int n)
{
  PVector[] points = new PVector[n];
  for(int i = 0; i < n; i++)
  {
    float t = random(0, PI);
    float p = random(0, 2*PI);
    float r = 100;
    
    points[i] = sphereToCart(r, t, p);
  }
  
  return points;
}

PVector sphereToCart(float r, float theta, float phi)
{
  PVector cart = new PVector();
  
  float st = sin(theta);
  cart.x = r * cos(phi) * st;
  cart.y = r * sin(phi) * st;
  cart.z = r * cos(theta);
  
  return cart;
}
