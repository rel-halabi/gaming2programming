Obstacle[] obstacles = new Obstacle[4];
Ray r;

void setup()
{
  size(1400,700);
  obstacles[0] = new Circle(200, 400, 50);
  obstacles[1] = new Circle(400, 200, 100);
  obstacles[2] = new Circle(500, 500, 150);
  obstacles[3] = new Box(350, 500, 100, 100);
  r = new Ray(100, 100);
  //r.march(5, r.vPos);
}

void draw()
{
  background(#1c1c1c);
  strokeWeight(3);
  stroke(#fefefe);
  noFill();
  for(Obstacle o : obstacles)
  {
    o.display();
  }
  
  r.display();
  r.vDir.set(mouseX, mouseY).normalize();
  println(dstToBox(new PVector(mouseX, mouseY), new PVector(350, 500), 100, 100));
  //rectMode(CENTER);
  //rect(350, 500, 100, 100);
}

//float signedDstToBox(PVector p, PVector center, float w, float h)
//{
//  PVector offset = new PVector(abs(p.x-center.x)-w, abs(p.y-center.y)-h);
  
//  float unsignedDst = vLength(max(offset.mag(), 0) == offset.mag() ? offset : new PVector(0,0));
  
//  return unsignedDst;
//}

float dstToBox(PVector p, PVector c, float w, float h)
{
  float rectMaximumX = c.x + w/2;
  float rectMinimumX = c.x - w/2;
  float rectMaximumY = c.y + h/2;
  float rectMinimumY = c.y - h/2;
  
  float dX = max(rectMinimumX - p.x, 0, p.x - rectMaximumX);
  float dY = max(rectMinimumY - p.y, 0, p.y - rectMaximumY);
  
  return vLength(new PVector(dX, dY));
}


//float dstToBox(PVector p, PVector c, float w, float h)
//{
//  float diffX = abs(c.x - p.x) - w/2;
//  float diffY = abs(c.y - p.y) - h/2;
//  PVector diff = new PVector(diffX, diffY);
  
//  return vLength(diff);
//}

//float dstToBox(PVector p, PVector center, float w, float h)
//{
//  PVector v = new PVector(center.x - p.x, center.y - p.y);
//  float diffX, diffY;
//  if(v.x < 0)
//  {
//    diffX = v.x + w/2;
//  }
//  else
//  {
//    diffX = v.x - w/2;
//  }
//  if(v.y < 0)
//  {
//    diffY = v.y + h/2;
//  }
//  else
//  {
//    diffY = v.y - h/2;
//  }
  
//  return vLength(new PVector(diffX, diffY));
//}

float signedDstToCircle(PVector p, PVector center, float diameter)
{
   PVector v = new PVector(p.x - center.x,p.y - center.y);
   
   return vLength(v) - diameter/2;
}

float vLength(PVector v)
{
  return sqrt(v.x*v.x + v.y*v.y);
}
