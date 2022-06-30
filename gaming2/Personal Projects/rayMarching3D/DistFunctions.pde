float dstToBox(PVector p, PVector c, float w, float h, float l)
{
  float rectMaximumX = c.x + w/2;
  float rectMinimumX = c.x - w/2;
  float rectMaximumY = c.y + h/2;
  float rectMinimumY = c.y - h/2;
  float rectMaximumZ = c.z + l/2;
  float rectMinimumZ = c.z - l/2;
  
  float dX = max(rectMinimumX - p.x, 0, p.x - rectMaximumX);
  float dY = max(rectMinimumY - p.y, 0, p.y - rectMaximumY);
  float dZ = max(rectMinimumZ - p.z, 0, p.z - rectMaximumZ);
  
  return vLength(new PVector(dX, dY, dZ));
}

float signedDstToCircle(PVector p, PVector center, float diameter)
{
   PVector v = new PVector(p.x - center.x,p.y - center.y, p.z - center.z);
   
   return vLength(v) - diameter;
}

float vLength(PVector v)
{
  return sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
}
