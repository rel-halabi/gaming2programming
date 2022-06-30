Arm a;

void setup()
{
  size(1280, 720);
  a = new Arm(width/2, height/2, 150, 150);
}

void draw()
{
  background(#1c1c1c);
  a.display();
  
  a.side(a.x-mouseX, mouseY-a.y);
  //a.q1 = PVector.angleBetween(new PVector(mouseX, mouseY), new PVector(a.x, a.y));
}

class Arm
{
  float x,y,q1,l1;
  float q2,l2;
  
  Arm(float x, float y, float l1, float l2)
  {
    this.x = x;
    this.y = y;
    this.l1 = l1;
    this.l2 = l2;
    q1 = 0;
    q2 = PI/2;
  }
  
  void side(float x, float z)
  {
    float a = atan(x/z);
    float len = z/cos(a);
    setLength(len);
    if(this.x > x) q1 += a;
    else           q1 -= a;
  }
  
  void setLength(float c)
  {
    float a = (l1*l1 + c*c - l2*l2)/(2*l1*c);
    q1 = a;
    q2 = PI - 2*a;
  }
  
  void display()
  {
    push();
    stroke(#fefefe);
    strokeWeight(3);
    float x2 = x+cos(q1)*l1;
    float y2 = y+sin(q1)*l1;
    line(x, y, x2, y2);
    line(x2, y2, x2+cos(q2+q1)*l2, y2+sin(q2+q1)*l2);
    fill(255, 0, 0);
    noStroke();
    circle(x2, y2, 15);
    pop();
  }
}
