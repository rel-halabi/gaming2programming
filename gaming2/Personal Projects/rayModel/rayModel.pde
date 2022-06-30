LightRay i, rfl, rfr;

void setup()
{
  size(1280, 720);
  i = new LightRay(width/2, height/2, 0, 0);
  rfl = new LightRay(width/2, height/2, width/2, height/2 + 1);
  rfr = new LightRay(width/2, height/2, width/2, height/2 + 1);
}

void draw()
{
  background(#1c1c1c);
  strokeWeight(3);
  stroke(#1221ab);
  i.display();
  i.ro.set(mouseX,mouseY);
  i.pointAt(width/2, height/2);
  
  PVector n = new PVector(0, -1).normalize();
  stroke(#fefefe);
  line(0, height/2, width, height/2);
  stroke(#12ab12);
  line(width/2, height/2, width/2 + n.x*150, height/2 + n.y*150);
  
  color c = color(#ab2112);
  float r = i.schlick(1.333, 1.05, n) * 1;
  c = color(red(c), green(c), blue(c), r*255);
  stroke(c);
  rfl.display();
  rfl.setAngle(i.reflect(n), n);
  c = color(#ba3653);
  c = color(red(c), green(c), blue(c), 255 - r*255);
  stroke(c);
  rfr.display();
  rfr.setAngle(i.refract(1.333, 1.05, n), PVector.mult(n, -1));
  println(r);
}

class LightRay
{
  PVector ro, rd;
  
  LightRay(float ox, float oy, float lx, float ly)
  {
    ro = new PVector(ox, oy);
    rd = new PVector(lx - ox, ly - oy).normalize();
  }
  
  float schlick(float n1, float n2, PVector normal)
  {
    //Schlick's Approximation: R(theta) = R0 + (1 - R0)(1-cos(theta))^5
    
    float incident = PVector.angleBetween(PVector.mult(rd, -1), normal);
    float r0 = (n1-n2)/(n1+n2); r0 *= r0;       //Reflection Coefficient for light parallel to the normal
    
                                                //Building of R(theta):
    float r = 1 - cos(incident); r = r*r*r*r*r; //(1-cos(theta))^5
    r *= (1 - r0);                              //(1-R0)(1-cos(theta))^5
    r += r0;                                    //R0 + (1 - R0)(1 - cos(theta))^5
    
    return r;
  }
  
  float reflect(PVector normal)
  {
    float incidence = PVector.angleBetween(PVector.mult(rd, -1), normal);
    if(rd.cross(normal).z < 0) incidence *= -1;
    
    float reflected = -incidence;
    
    return reflected;
  }
  
  float refract(float n1, float n2, PVector normal)
  {
    
    float incidence = PVector.angleBetween(PVector.mult(rd, -1), normal);
    float cross = rd.cross(normal).z;
    if(cross < 0) incidence *= -1;
    
    
    if(n1 == n2) return incidence;
    
    //Snell's Law: n1*sin(theta1) = n2*sin(theta2)
    float refraction = n1*sin(incidence)/n2; refraction = asin(refraction);
    
    
    return refraction;
  }
  
  void setAngle(float angle, PVector n)
  {
    float a = atan2(n.y, n.x);
    rd.set(cos(a + angle) , sin(a + angle)).normalize();
  }
  
  void display()
  {
    push();
    line(ro.x, ro.y, ro.x + rd.x*150, ro.y + rd.y*150);
    arrow();
    pop();
  }
  
  void arrow()
  {
    push();
    PVector p = new PVector(ro.x + rd.x*150, ro.y + rd.y*150);
    float a = atan2(rd.y, rd.x) + 5*PI/6;
    line(p.x, p.y, p.x + cos(a)*15, p.y + sin(a)*15);
    line(p.x, p.y, p.x + cos(a - 5*PI/3)*15, p.y + sin(a - 5*PI/3)*15);
    pop();
  }
  
  void pointAt(float x, float y)
  {
    rd.set(x - ro.x, y - ro.y).normalize();
  }
}
