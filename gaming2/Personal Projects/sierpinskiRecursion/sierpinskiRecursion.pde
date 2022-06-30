int i = 1;

void setup()
{
  size(1280, 720);
}

void draw()
{
  background(#1c1c1c);
  sp(width/6, height/1.2, width/3, i);
  sp(width/2, height/1.2, width/3, i+1);
  sp(5*width/6, height/1.2, width/3, i+2);
}

void keyPressed()
{
  i++;
}

void sp(float x, float y, float size, int n)
{
  float l = (size/2)/sqrt(3);
  fill(255);
  noStroke();
  triangle(x + size/2, y + l, x - size/2, y + l, x, y - 2*l);
  fill(#1c1c1c);
  triangle(x + size/4, y - l/2, x - size/4, y - l/2, x, y + l);
  
  if(n > 0)
  {
    sp(x, y - l, size/2, n-1);
    sp(x + (l/2)*sqrt(3), y + l/2, size/2, n-1);
    sp(x - (l/2)*sqrt(3), y + l/2, size/2, n-1);
  }
}
