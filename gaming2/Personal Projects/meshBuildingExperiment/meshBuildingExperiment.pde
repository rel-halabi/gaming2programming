PVector[] circle = generateCircle();
PVector[] sphere = generateSphere();

void setup()
{
  size(700,700, P3D);
}

void draw()
{
  background(0);
  camera(mouseX, mouseY, 0, width/2, height/2, -500, 0, 1, 0);
  translate(width/2, height/2, -500);
  stroke(255);
  
  
  for(int i = 0; i < sphere.length; i+=2)
  {
    point(sphere[i].x, sphere[i].y, sphere[i].z);
    int p1 = i;
    int p2 = i+2 < sphere.length ? i + 2 : i + 2 - sphere.length;
    int p3 = i+1 < sphere.length ? i + 1 : i + 1 - sphere.length;
    int p4 = i+3 < sphere.length ? i + 3 : i + 3 - sphere.length;    
    
    fill(255, 0, 0);
    makeTri(sphere[p1], sphere[p2], sphere[p3]);
    fill(0, 0, 255);
    makeTri(sphere[p3], sphere[p2], sphere[p4]);
  }
  
  //for(int i = 0; i < circle.length; i+=2)
  //{
  //  point(circle[i].x, circle[i].y);
  //  int p1 = i;
  //  int p2 = i+2 < circle.length ? i + 2 : i + 2 - circle.length;
  //  int p3 = i+1 < circle.length ? i + 1 : i + 1 - circle.length;
  //  int p4 = i+3 < circle.length ? i + 3 : i + 3 - circle.length;
    
  //  fill(255, 0, 0);
  //  makeTri(circle[p1], circle[p2], circle[p3]);
  //  fill(0, 0, 255);
  //  makeTri(circle[p3], circle[p2], circle[p4]);
  //}
}

void makeTri(PVector point1, PVector point2, PVector point3)
{
  beginShape();
  vertex(point1.x, point1.y, point1.z);
  vertex(point2.x, point2.y, point2.z);
  vertex(point3.x, point3.y, point3.z);
  endShape(CLOSE);
}

PVector[] generateSphere()
{
  int detail = 50;
  float radius = 300;
  float offset = 25;
  PVector[] points = new PVector[2*detail];

  float step = (2*PI)/detail;
  int i = 0;
  for(float a = 0; a < 2*PI; a += step)
  {
    points[i] = new PVector(cos(a)*radius, 0, sin(a)*radius);
    points[i+1] = new PVector(cos(a)*radius, offset, sin(a)*radius);
    i+=2;
  }
  
  return points;
}

PVector[] generateCircle()
{
  int detail = 50;
  float radius = 300;
  float offset = 100;
  PVector[] points = new PVector[2*detail];

  float step = (2*PI)/detail;
  int i = 0;
  for(float a = 0; a < 2*PI; a += step)
  {
    points[i] = new PVector(cos(a)*radius, sin(a)*radius);
    points[i+1] = new PVector(cos(a)*(radius-offset), sin(a)*(radius-offset));
    i+=2;
  }
  
  return points;
}
