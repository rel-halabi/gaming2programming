void setup()
{
  size(1000,500);
}

void draw()
{
  background(0);
  wave();
}

void wave()
{
  push();
  stroke(255);
  
  float freq = 12;
  float amp = 100;
  float inc = 0.5;
  float px = 0;
  for (float i = 0; i < width; i += inc)
  {
    float x = map(i, 0, width, 0, 2*PI * freq);
    point(i, sin(x)*amp + (height/2));
    if (i > 0)
    {
      line(i-inc, sin(px)*amp + (height/2), i, sin(x)*amp + (height/2));
    }
    px = x;
  }
  pop();
}
