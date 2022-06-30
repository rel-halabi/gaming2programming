class Polar
{
  float r, theta;
  
  Polar(float _r, float _theta)
  {
    r = _r;
    theta = _theta;
  }
  
  PVector cartesian()
  {
    PVector cart = new PVector(r*cos(theta), r*sin(theta));
    
    return cart;
  }
  
  void polar(float x, float y)
  {
    theta = atan2(y, x);
    r = sqrt(sq(x)+sq(y));
  }
}
