// Minesweeper
class Minesweeper
{
  int[][] field;
  int[][] mask;
  int size;
  int tx, ty;
  int flags;
  boolean wonGame = false;
  boolean stopGame = false;
  
  Minesweeper(int w, int h, int numMines, int size)
  {
    this.size = size;
    initField(w, h);
    setMines(numMines);
    setNumbers();
    flags = numMines;
  }
  
  void displayInfo()
  {
    text(flags, (field[0].length+1)*size, size);
    if(wonGame)text("Found All Mines!", (field[0].length+1)*size, size*2);
    else if(stopGame) text("Game Over", (field[0].length+1)*size, size*2);
  }
  
  void gameOver()
  {
    stopGame = true;
    for(int x = 0; x < mask[0].length; x++)
    {
      for(int y = 0; y < mask[1].length; y++)
      {
        mask[x][y] = 1;
      }
    }
  }
  
  void mouseClicked()
  {
    if(!stopGame)
    {
      int x = (mouseX/size);
      int y = (mouseY/size);
      if(x >= field[0].length || y >= field[1].length) return;
      switch(mouseButton)
      {
        case LEFT: 
          if(field[x][y] == -1 && mask[x][y] != 2) gameOver();
          else if(mask[x][y] != 2) expandSearch(x, y);
          break;
        case RIGHT:
          //mask[x][y] = mask[x][y] != 1 ? mask[x][y] != 2 && flags > 0 ? 2 : 0 : 1;
          if(mask[x][y] != 1 && mask[x][y] != 2 && flags > 0)
          {
            mask[x][y] = 2;
            flags -= 1;
          }
          else if(mask[x][y] != 1 && mask[x][y] == 2)
          {
            mask[x][y] = 0;
            flags += 1;
          }
          if(flags == 0) checkGame();
          break;
      }
    }
  }
  
  void checkGame()
  {
    for(int i = 0; i < field[0].length; i++)
    {
      for(int j = 0; j < field[1].length; j++)
      {
        if(field[i][j] == -1 && mask[i][j] != 2) {gameOver(); return;}
      }
    }
    
    stopGame = true;
    wonGame = true;
  }
  
  void display()
  {
    drawField(size);
    drawMask(size);
    displayInfo();
  }
  
  void tExpandSearch()
  {
    expandSearch(mouseX/size, mouseY/size);
  }
 
  void expandSearch(int x, int y)
  {
    if(x < 0 || x > field[0].length-1 || y < 0 || y > field[1].length-1) return;
    
    if(mask[x][y] != 0 || field[x][y] == -1) return;
    else if(field[x][y] > 0) {mask[x][y] = 1; return;}
    mask[x][y] = 1;
    
    //delay(100);    // Part of visualization remove when done
    
    expandSearch(x+1, y);
    expandSearch(x-1, y);
    expandSearch(x, y-1);
    expandSearch(x, y+1);
  }
  
  void drawMask(int size)
  {
    push();
    for(int x = 0; x < mask[0].length; x++)
    {
      for(int y = 0; y < mask[1].length; y++)
      {
        stroke(0);
        fill(120);
        if(mask[x][y] == 0) rect(x*size, y*size, size, size);
        else if(mask[x][y] == 2) 
        {
          rect(x*size, y*size, size, size);
          fill(255, 0, 0);
          circle(x*size + size/2, y*size + size/2, size/2);
        }
      }
    }
    pop();
  }
  
  void drawField(int size)
  {
    push();
    for(int x = 0; x < field[0].length; x++)
    {
      for(int y = 0; y < field[1].length; y++)
      {
        stroke(0);
        fill(field[x][y] == -1 ? color(255,0,0) : color(#1cba1c));
        rectMode(CORNER);
        rect(x*size, y*size, size, size);
        float c = map(field[x][y], 1, 9, 0, 255);
        fill(color(c, 50, 255 - c));
        textSize(size/2);
        if(field[x][y] != 0) text(field[x][y], x*size + size/2, y*size + size/2);
      }
    }
    pop();
  }
  
  void initField(int w, int h)
  {
    field = new int[w][h];
    mask = new int[w][h];
    for(int i = 0; i < w; i++)
    {
      for(int j = 0; j < h; j++)
      {
        field[i][j] = 0;
        mask[i][j] = 0;
      }
    }
  }
  
  void setMines(int numMines)
  {
    for(int i = 0; i < numMines; i++)
    {
      PVector p = getRandomCoordinates();
      while(field[(int)p.x][(int)p.y] == -1)
      {
        p = getRandomCoordinates();
      }
      field[(int)p.x][(int)p.y] = -1;
    }
  }
  
  PVector getRandomCoordinates()
  {
    return new PVector((int)random(0, field[0].length), (int)random(0, field[1].length));
  }
  
  void setNumbers()
  {
    for(int x = 0; x < field[0].length; x++)
    {
      for(int y = 0; y < field[1].length; y++)
      {
        if(field[x][y] != -1)
        {
          field[x][y] = modifiedSearch(x,y);
        }
      }
    }
  }
  
  int search(int x, int y)
  {
    int count = 0;
    try
    {
      for(int i = -1; i < 2; i++)
      {
        for(int j = -1; j < 2; j++)
        {
          if(field[x+i][y+j] == -1) count += 1;
        }
      }
    }
    catch(Exception e)
    {
      return modifiedSearch(x, y);
    }
    
    return count;
  }
  
  int modifiedSearch(int x, int y)
  {
    int count = 0;
    //int indexX = -1;
    //int indexY = -1;
    
    for(int i = x < 1 ? 0 : -1; i < (x > field[0].length - 2 ? 1 : 2); i++)
    {
      for(int j = y < 1 ? 0 : -1; j < (y > field[1].length - 2 ? 1 : 2); j++)
      {
        if(field[x + i][y + j] == -1) count += 1;
      }
    }
    
    return count;
    
    //while(indexY <= 1)
    //{
    //  try
    //  {
    //    if(field[x + indexX][y + indexY] == -1) count += 1;
    //    if(indexX < 1) indexX += 1;
    //    else
    //    {
    //      indexX = -1;
    //      indexY += 1;
    //    }
    //  }
    //  catch(Exception e)
    //  {
    //    if(indexX < 1) indexX += 1;
    //    else
    //    {
    //      indexX = -1;
    //      indexY += 1;
    //    }
    //  }
    //}
    
    //return count;
  }
  
}
