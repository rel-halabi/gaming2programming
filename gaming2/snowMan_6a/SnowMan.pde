class SnowMan 
{
  
  float x, y;
  boolean melted,happy;
  
  SnowMan( float _x, float _y )
  {
    
    x = _x;
    y = _y;
    melted = false;
    happy = true;
    
  }
  
  void draw() 
  {
   
    push();
    
    translate( x, y );
    ellipse( 0, 0, 150, 150 );
    fill(255);
    if ( melted ) 
    {
      ellipse( 125, 25, 100, 100 );
    }
    else
    {
      ellipse( 0, -125, 100, 100 );
    }
    
    if ( happy )
    {
      fill(0);
      ellipse( 0, -110, 5, 5);
      ellipse( 10, -113, 5, 5);
      ellipse( 20, -115, 5, 5);
      ellipse( -10, -113, 5, 5);
      ellipse( -20, -115, 5, 5);
      
    }
    else 
    {
      fill(0);
      ellipse( 0, -115, 5, 5);
      ellipse( 10, -113, 5, 5);
      ellipse( 20, -110, 5, 5);
      ellipse( -10, -113, 5, 5);
      ellipse( -20, -110, 5, 5);
      
    }
    
    
    pop();
    
  }
  
  void melt()
  {
    
    melted = true;
    
  }
  
  void umelt()
  {
   
    melted = false;
    
  }
  
}
