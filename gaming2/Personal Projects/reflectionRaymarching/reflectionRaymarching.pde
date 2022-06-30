PVector ro, rd;

void setup()
{
  size(1200, 675);
  ro = new PVector(width/2, height/2);
  rd = new PVector(1, 0).normalize();
}

void draw()
{
  background(#1c1c1c);
  if(mousePressed) mouseActions();  
  push();
  noFill();
  strokeWeight(3);
  stroke(#fefefe);
  circle(700, 450, 100*2);
  stroke(#fea653);
  strokeWeight(5);
  point(ro.x, ro.y);
  pop();
}

void mouseActions()
{
  rd = new PVector(mouseX - ro.x, mouseY - ro.y);
  rd.normalize();
  float d = Raymarch(ro, rd);
  PVector p = new PVector(ro.x + rd.x*d, ro.y + rd.y*d);
  PVector n = GetNormal(p);
  float d2 = Raymarch(new PVector(p.x + n.x, p.y + n.y), n);
  push();
  stroke(#ba53a6);
  line(ro.x, ro.y, p.x, p.y);
  stroke(#fe5353);
  strokeWeight(5);
  point(p.x, p.y);
  strokeWeight(0.5);
  line(p.x, p.y, p.x + n.x*d2, p.y + n.y*d2);
  pop();
}

void keyPressed()
{
  switch(key)
  {
    case 'w': ro.y -= 5; break;
    case 'a': ro.x -= 5; break;
    case 's': ro.y += 5; break;
    case 'd': ro.x += 5; break;
  }
}

float length(PVector v)
{
  return sqrt(v.x*v.x + v.y*v.y);
}

PVector GetNormal(PVector p)
{
  float d = GetDist(p);
  float e = 0.01;
  PVector n = new PVector(d - GetDist(new PVector(p.x - e, p.y)), d - GetDist(new PVector(p.x, p.y - e))).normalize();
  
  return n;
}

float GetDist(PVector p)
{
  PVector c = new PVector(700, 450, 100);
  float d = length(new PVector(p.x - c.x, p.y - c.y)) - c.z; 
  
  return d;
}

float Raymarch(PVector ro, PVector rd)
{
  float dO = 0;
  for(int i = 0; i < 100; i++)
  {
    PVector p = new PVector(ro.x + rd.x*dO, ro.y + rd.y*dO);
    float dS = GetDist(p);
    
    dO += dS;
    
    //push();
    //noFill();
    //stroke(#baa653);
    //circle(p.x, p.y, dS*2);
    //pop();
    
    if(dO > 5000 || dS < 0.001) break;
  }
  
  return dO;
}
