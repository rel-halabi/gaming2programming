class TileSpace
{
  int[] tileMap;
  float tileWidth, tileHeight;
  float spaceWidth, spaceHeight;
  
  TileSpace(int w, int h, int _WIDTH, int _HEIGHT)
  {
    tileWidth = _WIDTH/w;
    tileHeight = _HEIGHT/h;
    spaceWidth = _WIDTH;
    spaceHeight = _HEIGHT;
    tileMap = new int[w*h];
    for(int i = 0; i < tileMap.length; i++)
    {
      tileMap[i] = 0;
    }
  }
  
  void display()
  {
    grid();
  }
  
  void grid()
  {
    push();
    stroke(255);
    strokeWeight(0.5);
    for(int y = 0; y < spaceHeight/tileHeight; y++)
    {
      for(int x = 0; x < spaceWidth/tileWidth; x++)
      {
        fill(tileMap[int(x + y*(spaceWidth/tileWidth))] == 1 ? color(0,120, 255) : color(0));
        rect(x*tileWidth, y*tileHeight, tileWidth, tileHeight);
      }
    }
    pop();
  }
  
  void setCell(float x, float y)
  {
    tileMap[whichCell(x, y)] = 1;
  }
  
  void clearMap()
  {
    for(int i = 0; i < tileMap.length; i++)
    {
      tileMap[i] = 0;
    }
  }
  
  PVector cellCoord(float x, float y)
  {
    int cX = floor((x/spaceWidth)*(spaceWidth/tileWidth));
    int cY = floor((y/spaceHeight)*(spaceHeight/tileHeight));
    
    return new PVector(cX, cY);
  }
  
  int whichCell(float x, float y)
  {
    int cell = floor(((x/spaceWidth)*(spaceWidth/tileWidth) + (floor((y/spaceHeight)*(spaceHeight/tileHeight)))*(spaceWidth/tileWidth)));
    
    return cell;
  }
}
