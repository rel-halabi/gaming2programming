Marcher m;

void setup()
{
  size(1280, 720);
  m = new Marcher(width/2, height/2);
}

void draw()
{
  background(#1c1c1c);
  m.display();
  m.lookAt(mouseX, mouseY);
}

void keyPressed()
{
  switch(key)
  {
    case ' ': m.grow(3); break;
    case 'g': m.generateShape(); break;
  }
}

void mousePressed()
{
  m.step();
  println(m.vPrev, m.vPrev.size());
}

class Marcher
{
  PVector vPos;
  PVector vDir;
  ArrayList<PVector> vPrev;
  float fStepSize;
  int prevShapeIndex = 0;
  
  Marcher(float x, float y)
  {
    vPos = new PVector(x, y);
    vDir = new PVector();
    fStepSize = 0;
    vPrev = new ArrayList<PVector>();
  }
  
  void generateShape()
  {
    beginShape();
    for(int i = prevShapeIndex; i < vPrev.size(); i++)
    {
     PVector v = vPrev.get(i);
     vertex(v.x, v.y);
    }
    endShape(CLOSE);
    prevShapeIndex = vPrev.size();
  }
  
  void display()
  {
    drawPrev();
    
    push();
    strokeWeight(2);
    stroke(#fefefe);
    fill(44, 44, 44, 100);
    circle(vPos.x, vPos.y, fStepSize*2);
    strokeWeight(5);
    point(vPos.x, vPos.y);
    pop();
    
    if(fStepSize > 0)
    {
      push();
      strokeWeight(10);
      stroke(#ba5336);
      point(vPos.x+vDir.x*fStepSize, vPos.y+vDir.y*fStepSize);
      pop();
    }
    
    push();
    stroke(#fefefe);
    strokeWeight(1);
    if(vPrev.size() > 0) line(vPrev.get(vPrev.size()-1).x, vPrev.get(vPrev.size()-1).y, vPos.x, vPos.y);
    pop();
  }
  
  void drawPrev()
  {
    for(int i = 0; i < vPrev.size(); i++)
    {
      PVector v = vPrev.get(i);
      push();
      stroke(#fefefe);
      strokeWeight(3);
      point(v.x, v.y);
     // println(v, i);
      pop();
      
      if(i > 0) 
      {
        PVector vP = vPrev.get(i-1);
        strokeWeight(1);
        stroke(#fefefe);
        line(vP.x, vP.y, v.x, v.y);
      }
    }
  }
  
  void step()
  {
    if(fStepSize != 0) vPrev.add(vPos.copy());
    vPos.x += vDir.x*fStepSize;
    vPos.y += vDir.y*fStepSize;
    fStepSize = 0;
  }
  
  void lookAt(float x, float y)
  {
    vDir.set(x - vPos.x, y - vPos.y).normalize();
  }
  
  
  void grow(float factor)
  {
    fStepSize += factor;
  }
}
