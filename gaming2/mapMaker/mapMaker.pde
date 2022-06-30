/*
* Map Creation Tool
* Generates a 32x32 two dimensional integer array
* 1 represents a filled square, 0 being empty
* 
* Author: Raja El-Halabi
* Date Created: 05/27/2022
* 
*/


PrintWriter p;
int[][] map = new int[32][32];

void setup()
{
  size(800, 800);
  p = createWriter("map.txt");
  clearmap();
  initborder();
}

void draw()
{
  drawmap();
  println((mouseX/(width/32)), (mouseY/(width/32)));
}

void keyPressed()
{
  p.println(generateString());
  p.flush();
  p.close();
  exit();
}

String generateString()
{
  String s = "int[][] map = {\n";
  for(int i = 0; i < 32; i++)
  {
    s += "{";
    for(int j = 0; j < 32; j++)
    {
      if(j != 31) s += map[i][j] + ",";
      else        s += map[i][j];
    }
    if(i != 31) s += "},\n";
    else        s += "}\n";
  }
  s += "};";
  
  return s;
}

void drawmap()
{
  stroke(255);
  int size = width/32;
  for(int i = 0; i < 32; i++)
  {
    for(int j = 0; j < 32; j++)
    {
      switch(map[i][j])
      {
        case 0: fill(0); break;
        case 1: fill(255,0,0); break;
        default: fill(255); break;
      }
      rect(i*size, j*size, size, size);
    }
  }
}

void clearmap()
{
  for(int i = 0; i < 32; i++)
  {
    for(int j = 0; j < 32; j++)
    {
      map[i][j] = 0;
    }
  }
}
void initborder()
{
  for(int i = 0; i < 32; i++)
  {
    map[i][0] = 1;
    map[i][31] = 1;
    map[0][i] = 1;
    map[31][i] = 1;
  }
}

void editor()
{
  int tile = 1;
  int size = width/32;
  if(mouseButton == RIGHT) tile = 0;   
  
  int x = ceil(mouseX/size);
  int y = ceil(mouseY/size);
  
  map[x][y] = tile;
}

void mousePressed()
{
  editor();
}

void mouseDragged()
{
  editor();
}
