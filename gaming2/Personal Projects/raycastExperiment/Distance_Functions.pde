float dstToBox(PVector p, PVector c, float w, float h)
{
  float rectMaximumX = c.x + w/2;
  float rectMinimumX = c.x - w/2;
  float rectMaximumY = c.y + h/2;
  float rectMinimumY = c.y - h/2;
  
  float dX = max(rectMinimumX - p.x, 0, p.x - rectMaximumX);
  float dY = max(rectMinimumY - p.y, 0, p.y - rectMaximumY);
  
  return vLength(new PVector(dX, dY));
}

float vLength(PVector v)
{
  return sqrt(v.x*v.x + v.y*v.y);
}
