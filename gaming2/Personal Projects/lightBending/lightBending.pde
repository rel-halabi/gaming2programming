LightBeam l;

void setup()
{
  size(800, 450);
  l = new LightBeam(100, 100, 100);
}

void draw()
{
  background(#1c1c1c);
  strokeWeight(1);
  stroke(#53ba53);
  PVector n = new PVector(-1, 0).normalize();
  line(width/2, height/2, width/2 + n.x * 200, height/2 + n.y * 200);
  l.ro = new PVector(mouseX, mouseY);
  l.rd = new PVector(width/2 - l.ro.x, height/2 - l.ro.y).normalize();

  stroke(#5353fe);
  line(l.ro.x, l.ro.y, l.ro.x + l.rd.x*150, l.ro.y + l.rd.y*150);
  
  stroke(#fefefe);
  line(width/2, height/10, width/2, height - height/10);
  
  stroke(#fe5353);
  //PVector r = l.refract(1, n);
  float ref = l.refract(1.333, 1, n);
  float crit = l.determineCritical(1.333, 1);
  //line(width/2, height/2, width/2+r.x*100, height/2 + r.y*100);
  PVector r = new PVector(cos(ref), sin(ref));
  PVector c = new PVector(cos(crit), sin(crit));
  line(width/2, height/2, width/2 + r.x*150, height/2 + r.y*150);
  stroke(#fefe53);
  line(width/2, height/2, width/2 + c.x*100, height/2 + c.y*100);
}

class LightBeam
{
  PVector ro;
  PVector rd;
  float l;
  
  LightBeam(float x, float y, float lambda)
  {
    ro = new PVector(x, y);
    rd = new PVector();
    l = lambda;
  }
  
  float determineCritical(float ior1, float ior2)
  {
    return asin(ior2/ior1);
  }

  float refract(float ior1, float ior2, PVector n)
  {
    float incidence = -(PVector.angleBetween(rd, n) - PI);
    float cross = rd.cross(n).z;                    //Cross Product Z component tells if rd is to the left or right of n
    
    float critical = determineCritical(ior1, ior2);
    if(incidence > critical) return reflect(incidence, cross); //If incidence  angle is greater than critical, then reflect
    
    //Angle of Refraction, Snell's Law: (sin(theta1)/sin(theta2)) = n1 / n2
    // theta1 = angle of incidence, theta2 = angle of refraction, n1 = index of refraction of previous medium, n2 = ior of medium
    // solve for theta2, theta2 = asin(sin(theta1) * (n2/n1))
    
    float refraction = asin(sin(incidence) * (ior2/ior1));
    if(cross < 0) refraction *= -1;                         //Signed the refraction angle based on if rd is to the 
                                                            //left or right of n
    if(Float.isNaN(refraction)) return reflect(incidence, cross);                                                  
    //println(refraction, critical, incidence);
    println(schlick(ior1, ior2, incidence), critical, incidence);
    
    return refraction;
  }
  
  float reflect(float angle, float cross)
  {
    float reflection = cross < 0 ? angle + PI: -angle + PI;      //Relecting across the normal
    
    println("reflecting");
    return reflection;
  }
  
  double schlick(float ior1, float ior2, float angle) //https://en.wikipedia.org/wiki/Schlick%27s_approximation
  {
    float r0 = ((ior1-ior2)/(ior1+ior2)); r0 *= r0;      //R0 is reflection coefficient of light parallel to the normal,
                                                         //i.e., when the angle is 0, or when barely any reflection occurs
                                                         
    double R = 1 - cos(angle); R = R*R*R*R*R;  //In the approximation, this is the (1 - cos(theta))^5 part
    
    R *= (1 - r0);
    R += r0;
    
    return R;
  }
}
