Sphere s;

void setup()
{
  size(700, 700, P3D);
  colorMode(HSB);
  s = new Sphere(new PVector(500, 200, -200), 100);
  //render();
}

void draw()
{
  background(#1c1c1c);
  stroke(#fefefe);
  Ray r = new Ray(width/2, 100, 0, mouseX, mouseY, 0);
  
  r.display();
  s.display();
}

void render()
{
  Ray[] rays = new Ray[(width/5) * (height/5)];
  int i = 0;
  for(int y = 0; y < height; y+=5)
  {
    for(int x = 0; x < width; x+=5)
    {
      rays[i] = new Ray(width/2, height/2, 0, x, y, -100);
      
      float dist = rays[i].marchS(s, 500);
      //println(dist);
      
      stroke(0, 0, map(dist, 0, 500, 255, 0));
      strokeWeight(5);
      point(rays[i].origin.x + dist*rays[i].direction.x, rays[i].origin.y + dist*rays[i].direction.y, (rays[i].origin.z + dist*rays[i].direction.z));
      println(rays[i].origin.x + dist*rays[i].direction.x, rays[i].origin.y + dist*rays[i].direction.y, (rays[i].origin.z + dist*rays[i].direction.z));
      i++;
    }
  }
  println("done");
}

float sdSphere(PVector p, float r)
{
  return vectorLength(p) - r;
}

float vectorLength(PVector v)
{
  return sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
}

class Ray
{
  PVector origin;
  PVector direction;
  
  Ray(float x, float y, float z, float dx, float dy, float dz)
  {
    origin = new PVector(x, y, z);
    direction = new PVector(dx - x, dy - y, dz - z).normalize();
  }
  
  float marchS(Sphere sphere, float end)
  {
    int MAX = 5;
    float epsilon = 0.01;
    float depth = 0;
    
    for(int i = 0; i < MAX; i++)
    {
      PVector difference = new PVector((origin.x + depth*direction.x) - sphere.center.x, (origin.y + depth*direction.y) - sphere.center.y);
      float distance = sdSphere(difference, sphere.radius);
      
      if (distance < epsilon)
      {
        return depth;
      }
      
      noFill();
      circle(origin.x + depth*direction.x, origin.y + depth*direction.x, distance);
      
      depth += distance;
      
      if (depth >= end)
      {
        return end;
      }
      
    }
    
    return end;
  }
  
  void display()
  {
    float dist = marchS(s, 100);
    line(origin.x, origin.y, origin.z, origin.x + direction.x*dist, origin.y + direction.y*dist, origin.z + direction.z*dist);
  }
  
  //boolean determineShade(PVector lightSource)
  //{
    
  //}
}

class Sphere
{
  PVector center;
  float radius;
  
  Sphere(PVector center, float radius)
  {
    this.center = center;
    this.radius = radius;
  }
  
  void display()
  {
    push();
    translate(center.x, center.y, center.z);
    sphere(radius);
    pop();
  }
}
