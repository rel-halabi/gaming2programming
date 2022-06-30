int[][] test;
int[][] mask;

void setup()
{
  size(1280, 720);
  int size = 100;
  test = new int[size/2][size/2];
  mask = new int[size/2][size/2];
  init();
  for(int i = 0; i < test[1].length; i++)
  {
    test[40][i] = -1;
    mask[40][i] = 2;
  }
}

void drawGrid(int size)
{
  for(int i = 0; i < test[0].length; i++)
  {
    for(int j = 0; j < test[1].length; j++)
    {
      switch(mask[i][j])
      {
        case 1: fill(255,0,0); break;
        case 2: fill(255,0,255); break;
        default: fill(120); break;
      }
      
      
      rect(i*size, j*size, size, size);
    }
  }
}

void expandSearch(int x, int y)
{
  if(mask[x][y] != 0) return;
  
  mask[x][y] = 1;
  //println("working" + x + y);
  try
  {
    expandSearch(x+1, y);
    expandSearch(x-1, y);
    expandSearch(x, y-1);
    expandSearch(x, y+1);
  }
  catch(Exception e)
  {
    return;
  }
}

void init()
{
  for(int i = 0; i < test[0].length; i++)
  {
    for(int j = 0; j < test[1].length; j++)
    {
      test[i][j] = 0;
      mask[i][j] = 0;
    }
  }
}

void draw()
{
  background(#1c1c1c);
  drawGrid(10);
}

void mouseClicked()
{
  int x = mouseX/10;
  int y = mouseY/10;
  println(x, y);
  
  expandSearch(x, y);
}
