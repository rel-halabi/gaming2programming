Player p;
Ray rays[];

int[] map = { 1, 1, 1, 1, 1, 1, 1, 1,
              1, 0, 1, 0, 1, 0, 0, 1,
              1, 0, 1, 0, 1, 0, 0, 1,
              1, 0, 1, 0, 0, 0, 0, 1,
              1, 0, 1, 0, 0, 1, 0, 1,
              1, 0, 1, 1, 1, 1, 0, 1,
              1, 0, 0, 0, 0, 0, 0, 1,
              1, 1, 1, 1, 1, 1, 1, 1 };

void setup()
{
  size(1600, 800);
  frameRate(15);
  p = new Player(150, 250);
  rays = new Ray[35];
  for(int i = 0; i < rays.length; i++)
  {
    rays[i] = new Ray(p.pos.x, p.pos.y, (i*PI)/rays.length);
  }
}

void draw()
{
  push();
  stroke(50);
  for(int i = 0; i < 8; i++)
  {
    for(int j = 0; j < 8; j++)
    {
      fill(map[i*8 + j] == 1 ? color(0,0,255) : 0);
      rect(j*100, i*100, 100, 100);
    }
  }
  pop();
  
  p.display();
  for(Ray r : rays)
  {
    r.display();
    push();
    PVector hit = r.march(100,100);
    noFill();
    stroke(255);
    circle(hit.x, hit.y, 10);
    pop();
  }
  render();
}

void keyPressed()
{
  p.keyPressed();
  for(Ray r : rays)
  {
    r.origin.set(p.pos.x, p.pos.y);
  }
  for(int i = 0; i < rays.length; i++)
  {
    float angle = (p.angle + ((rays.length/2)*(PI/3))/rays.length) - (i*(PI/3)/rays.length);
    rays[i].dir.set(cos(angle), sin(angle));
  }
}

int determineTile(float x, float y)
{
  int tile = floor(x/100) + floor(y/100)*8;
  return tile;
}

PVector cameraPlane(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
{
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  if(uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
  {
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    return new PVector(intersectionX, intersectionY);
  }
  return null;
}

void render()
{
  push();
  translate(width/2, 0);
  fill(0);
  rect(0, 0, width/2, height);
  pop();
  for(int i = 0; i < rays.length; i++)
  {
    
    //PVector cast = rays[i].cast();
    PVector march = rays[i].march(100,100);
    PVector origin = rays[i].origin;
    PVector endPoint = new PVector(origin.x + rays[i].dir.x*rays[i].maxDist, origin.y+rays[i].dir.y*rays[i].maxDist);
    PVector plane = cameraPlane(origin.x, origin.y, endPoint.x, endPoint.y, p.cameraPlaneStart.x, p.cameraPlaneStart.y, p.cameraPlaneEnd.x, p.cameraPlaneEnd.y);
    
    float distance;
    
    if(plane != null)
    {
      distance = dist(plane.x, plane.y, march.x, march.y);
    }
    else
    {
      distance = dist(origin.x, origin.y, march.x, march.y);
    }
    float br = map(distance, 0, rays[i].maxDist, 255, 0);
    float p = 50;
    
    float ht = (p*(height)/(p+distance));
    
    push();
    stroke(255,0,255);
    strokeWeight(5);
    if(plane != null)
    {
    point(plane.x,plane.y);
    }
    pop();
    push();
    translate(width/2, 0);
    noStroke();
    rectMode(CENTER);
    fill(0, 0, br);
    float startX = ((width/2) - ((width/2)/rays.length)/2);
    rect(startX - i*(width/2)/rays.length, height/2, (width/2)/rays.length, ht);
    pop();
  }
}
