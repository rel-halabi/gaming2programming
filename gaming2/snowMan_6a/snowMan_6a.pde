SnowMan snowman;

void setup() 
{
  snowman = new SnowMan( width/2 , height/2 );
  size( 700, 700 );
}

void draw()
{
  
  background(0);
  snowman.draw();
  
}

void keyPressed() 
{
 
  switch ( key )
  {
    
    case 'm':
      snowman.melt();
      break;
    case 'f':
       snowman.umelt();
       break;
    case 'h':
      snowman.happy = true;
      break;
    case 's':
      snowman.happy = false;
      break;
      
  }
  
}
