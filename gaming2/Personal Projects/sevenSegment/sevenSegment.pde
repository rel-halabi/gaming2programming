SevenSegment s;

void setup()
{
  size(700,700);
  s = new SevenSegment(width/2, height/2, 100, color(255,255,0));
}

void draw()
{
  background(255);
  s.display();
}

void keyPressed()
{
  if (key == ' ')
  {
    s.clr();
  }
}

void mouseClicked()
{
  s.check();
}

class SevenSegment
{
  Segment segments[];
  
  float x,y,s;
  color c;
  
  SevenSegment(float _x, float _y, float _s, color _c)
  {
    segments = new Segment[7];
    
    x = _x;
    y = _y;
    s = _s;
    c = _c;
    
    initSegments();
  }
  
  void display()
  {
    for(Segment s : segments)
    {
      s.display();
    }
  }
  
  void check()
  {
    for(Segment s : segments)
    {
      s.clicked();
    }
  }
  
  void clr()
  {
    for(Segment s : segments)
    {
      s.on = false;
    }
  }
  
  void initSegments()
  {
    segments[0] = new Segment(x, y, false, s, c);
    segments[1] = new Segment(x, y-s*2, false, s, c);
    segments[2] = new Segment(x+s+s/8, y-s, true, s, c);
    segments[3] = new Segment(x-s-s/8, y-s, true, s, c);
    segments[4] = new Segment(x-s-s/8, y+s, true, s, c);
    segments[5] = new Segment(x+s+s/8, y+s, true, s, c);
    segments[6] = new Segment(x, y+s*2, false, s, c);
  }
  
  
}

class Segment
{
  boolean on;
  float x,y,s;
  boolean v;
  color c;
  
  Segment(float _x, float _y, boolean _v, float _s, color _c)
  {
    x = _x;
    y = _y;
    v = _v;
    s = _s;
    c = _c;
  }
  
  void display()
  {
    stroke(0);
    if (on)
    {
      fill(c);
    }
    else
    {
      fill(0);
    }
    if (!v)
    {
      segment();
    }
    else
    {
      vertSegment();
    }
  }
  
  void vertSegment()
  {
    push();
    translate(x,y);
    beginShape();
    vertex(0, -s);
    vertex(s/5, -s + s/8);
    vertex(s/5, s - s/8);
    vertex(0, s);
    vertex(-s/5, s - s/8);
    vertex(-s/5, -s +s/8);
    endShape(CLOSE);
    pop();
  }
  
  void segment()
  {
    push();
    translate(x,y);
    beginShape();
    vertex(-s, 0);
    vertex(-s + s/8, -s/5);
    vertex(s - s/8, -s/5);
    vertex(s, 0);
    vertex(s - s/8, s/5);
    vertex(-s + s/8, s/5);
    endShape(CLOSE);
    pop();
  }
  
  void clicked()
  {
    if(!v)
    {
      if (mouseX >= x-s && mouseX <= x+s && mouseY >= y - s/5 && mouseY <= y + s/5)
      {
        on = !on;
      }
    }
    else
    {
      if (mouseX >= x - s/5 && mouseX <= x + s/5 && mouseY >= y - s && mouseY <= y + s)
      {
        on = !on;
      }
    }
  }
  
}
