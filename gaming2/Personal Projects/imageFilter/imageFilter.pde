PImage img;

void setup()
{
  size(620,930);
  img = loadImage("milpede.jpg");
  image(img, 0, 0);
  
}

void draw()
{
  if (keyPressed) 
  {
  for (int x = 1; x < width-1; x++)
  {
    for (int y = 1; y < 464; y++)
    {
      stroke(passThroughKernel(x,y));
      point(x,y + 465);
    }
  }
  }
}

color passThroughKernel(int x, int y)
{
  
  float kernel[][] = { 
                       { 1, 1, 1}, 
                       { 1, -3, 1 },
                       { 1, 1, 1 }
                                      };
  
  //float kernelR[][] = { 
  //                     {  2, 2,  2 }, 
  //                     { 2,  4, 2 },
  //                     {  2, 2, 2 }
  //                                    };
  //float kernelG[][] = { 
  //                     { 2, 2,  2 }, 
  //                     { 2,  4, 2 },
  //                     {  2, 2, 2 }
  //                                    };
  //float kernelB[][] = { 
  //                     {  2, 2, 2 }, 
  //                     { 2,  4, 2 },
  //                     {  2, 2, 2 }
  //                                    };
  
  float kernelR[][] = kernel;
  float kernelG[][] = kernel;
  float kernelB[][] = kernel;
                                      
  
  
  color result = 0;
  float input[][] = new float[3][3];
  float red = 0; float green = 0; float blue = 0;
  for (int pass = 0; pass < 3; pass++)
  {
    if (x != 0 && y != 0 && x != width && y != height)
    {
      for (int j = -1; j < 1; j++)
      {
        for (int i = -1; i < 1; i++)
        {
          if (pass == 0)
          {
            input[i+1][j+1] = red(get(x+i, y+j));
          }
          if (pass == 1)
          {
            input[i+1][j+1] = green(get(x+i, y+j));
          }
          if (pass == 2)
          {
            input[i+1][j+1] = blue(get(x+i, y+j));
          }
        }
      }
    }
    
    for (int i = 0; i < 3; i++)
    {
      for (int j = 0; j < 3; j++)
      {
        if (pass == 0)
        {
          red += input[i][j] * kernelR[i][j];
        }
        if (pass == 1)
        {
          green += input[i][j] * kernelG[i][j];
        }
        if (pass == 2)
        {
          blue += input[i][j] * kernelB[i][j];
        }
      }
    }
  }
  
  result = color(red, green, blue);
  
  return result;
}
