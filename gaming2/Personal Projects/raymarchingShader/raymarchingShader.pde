final int max_iter = 100;
final float max_dist = 100.0f;
final float surf_dist = 0.01f;

void setup()
{
  size(1280, 720);
  colorMode(RGB, 1.0);
  loadPixels();
}

void draw()
{
  for(int y = 0; y < height; y++)
  {
    for(int x = 0; x < width; x++)
    {
      pixels[y*width + x] = frag(x, height - y);
    }
  }
  updatePixels();
}

float sdSphere(PVector p, float radius)
{
  return p.mag()-radius;
}

float sdTorus( PVector p, PVector t )
{
  PVector temp = new PVector(p.x, 0, p.z);
  PVector q = new PVector(temp.mag()-t.x, p.y);
  return q.mag()-t.y;
}

float distField(PVector p)
{
  PVector s = new PVector(0, 1, -6);
  float d = sdTorus(new PVector(p.x - s.x, p.y - s.y, p.z - s.z), new PVector(0.5, 0.25)); //sdSphere(new PVector(p.x - s.x, p.y - s.y, p.z - s.z), 1);
  
  return min(d, p.y);
}

PVector getNormal(PVector p)
{
  final float off = 0.01;
  float d = distField(p);
  return new PVector(
    distField(new PVector(p.x + off, p.y, p.z)) - d,
    distField(new PVector(p.x, p.y + off, p.z)) - d,
    distField(new PVector(p.x, p.y, p.z + off)) - d
  ).normalize();
}

float raymarch(PVector ro, PVector rd)
{
  float dO = 0;
  for(int i = 0; i < max_iter; i++)
  {
    PVector p = new PVector(ro.x + rd.x*dO, ro.y + rd.y*dO, ro.z + rd.z*dO);
    
    float dS = distField(p);
    
    dO += dS;
    
    // Environment
    if(dO > max_dist)
    {
      break;
    }
    
    // Objects
    if(dS < surf_dist)
    {
      break;
    }
  }
  
  return dO;
}

float step(float thresh, float trig)
{
  return trig > thresh ? 1 : 0;
}

float smoothstep(float edge1, float edge2, float x)
{
  float k = max(0, min(1, (x-edge1)/edge2));
  return k*k*(3-2*k);
}

float getLight(PVector p)
{
  PVector n = getNormal(p);
  PVector l = new PVector(2, 5, -3);
  
  float d = dist(l.x, l.y, l.z, p.x, p.y, p.z);
  PVector lightVector = new PVector(p.x - l.x, p.y - l.y, p.z-l.z).normalize().mult(-1);
  
  
  float light = PVector.dot(n,lightVector);
  light = light > 1 ? 1 : light < 0 ? 0 : light;
  
  float lD = raymarch(new PVector(p.x + n.x*surf_dist*2, p.y + n.y*surf_dist*2, p.z + n.z*surf_dist*2), lightVector);
  
  if(lD < d) light *= 0.1;
  
  return light;
}

color frag(int x, int y)
{
  PVector uv = new PVector((float)x/width - 0.5, (float)y/height - 0.5);
  uv.x *= (float)width/height;
  
  PVector ro = new PVector(0, 1, 0);
  PVector rd = new PVector(uv.x, uv.y, -1).normalize();
  
  float d = raymarch(ro, rd);
  PVector p = new PVector(ro.x + rd.x*d, ro.y + rd.y*d, ro.z + rd.z*d);
  
  PVector n = getNormal(p);
  float l = getLight(p);
  
  return color(l);
}
