Particle p, p2;

void setup()
{
  size(700,700);
  p = new Particle(250, 100, 1, 50);
  p2 = new Particle(width/2, height/2, 50, 75);
}

void draw()
{
  background(0);
  p2.update();
  p.update();
  
  p.applyForce(attraction(p2, p));
}

PVector attraction(Particle a, Particle b)
{
  double dG = 50;
  
  float fM1 = a.fMass;
  float fM2 = b.fMass;
  
  PVector vR = new PVector(a.vPos.x-b.vPos.x, a.vPos.y-b.vPos.y);
  vR.normalize();
  float fForce = (float)(((fM1*fM2)/(dist(a.vPos.x, a.vPos.y,b.vPos.x, b.vPos.y)*dist(a.vPos.x, a.vPos.y,b.vPos.x, b.vPos.y)))*dG);
  
  return new PVector(vR.x*fForce,vR.y*fForce);
}

class Particle
{
  float fMass;
  float fSize;
  PVector vPos;
  PVector vVel;
  PVector vAcc;
  
  Particle(float x, float y, float mass, float size)
  {
    vPos = new PVector(x, y);
    vVel = new PVector();
    vAcc = new PVector();
    fMass = mass;
    fSize = size;
  }
  
  void update()
  {
    display();
    updateVelocity();
    updatePosition();
  }
  
  void display()
  {
    push();
    translate(vPos.x, vPos.y);
    stroke(255);
    strokeWeight(3);
    fill(100);
    circle(0,0,fSize);
    pop();
  }
  
  void updatePosition()
  {
    vPos.add(vVel);
  }
  
  void updateVelocity()
  {
    vVel.add(vAcc);
    vAcc.set(0, 0);
  }
  
  void applyForce(PVector vForce)
  {
    vAcc.set(vForce.x / fMass, vForce.y / fMass);
  }
}
