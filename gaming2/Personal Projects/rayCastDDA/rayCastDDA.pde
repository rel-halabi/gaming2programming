Player p;
int type = 0;

void setup()
{
  size(1920, 960);
  p = new Player(30, 1);
}

void draw()
{
  background(0);
  p.raycast(width/2);
  displayMap();
}

void keyPressed()
{
  p.keyPressed();
  
  switch(key)
  {
    case '1':
      type = 1;
      break;
    case '2':
      type = 2;
      break;
    case '3':
      type = 3;
      break;
    case '4':
      type = 4;
      break;
    case '0':
      type = 0;
      break;
  }
}

void mousePressed()
{
  mapEditor(mouseX-(width/2), mouseY, type);
}

void displayMap()
{
  int tileWidth = (width/2) / mapWidth;
  int tileHeight = height / mapHeight;
  
  for(int y = 0; y < mapHeight; y++)
  {
    for(int x = 0; x < mapWidth; x++)
    {
      switch(map[x][y]) 
      {
        case 1: fill(0, 0, 255); break;
        case 2: fill(255, 0, 0); break;
        case 3: fill(0, 255, 0); break;
        case 4: fill(255, 0, 255); break;
        case 0: fill(0); break;
        default: fill(255, 255, 0); break;
      }
      stroke(120);
      rect(width/2 + (x*tileWidth), y*tileHeight, tileWidth, tileHeight);
    }
  }  
  
  push();
  translate(width/2, 0);
  stroke(255, 0, 0);
  strokeWeight(10);
  point(map(p.vPos.x, 0, tileWidth, 0, (width/2)), map(p.vPos.y, 0, tileHeight, 0, height));
  strokeWeight(1);
  line(map(p.vPos.x, 0, tileWidth, 0, (width/2)), map(p.vPos.y, 0, tileHeight, 0, height), map(p.vPos.x, 0, tileWidth, 0, (width/2)) + p.vDir.x*25,map(p.vPos.y, 0, tileHeight, 0, height) + p.vDir.y*25);
  pop();
}
