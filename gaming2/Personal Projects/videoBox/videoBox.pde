import processing.video.*;

Capture video;

int[] prev;

PVector pos;
PVector vel;
int d = 1;
void setup()
{
  size(720,720);
  video = new Capture(this, width, height);
  video.start();
  prev = new int[video.width*video.height];
  loadPixels();
  
  pos = new PVector(width/2, height/2);
  vel = new PVector(1, 0);
}

void draw()
{
  //displayDifference();
  background(120);
  asciiArt(720);
}

void displayBox(int x, int y, int size)
{
  if (video.available())
  {
    
    video.read();
    video.loadPixels();
    
    for (int i = 0; i < video.pixels.length; i++)
    {
      color currentColor = video.pixels[i];
      int currentR = (currentColor >> 16) & 0xFF;
      int currentG = (currentColor >> 8) & 0xFF;
      int currentB = currentColor & 0xFF;
      
      if (i/width > y - size && i/width < y + size && i % width > x - size && i % width < x + size)
      {
        pixels[i] = color(currentR, currentG, currentB);
      }
      else
      {
        pixels[i] = color(120);
      }
    }
    updatePixels();
  }
}
void asciiArt(int size)
{
  if (video.available())
  {
    video.read();
    video.loadPixels();
  } 
    
    for ( int j = 0; j < height; j += size)
    {
      for(int i = 0; i < width; i += size)
      {
        int avgR = 0;
        int avgG = 0;
        int avgB = 0;
        for (int y = j; y < j+size; y++)
        {
          for (int x = i; x < i+size; x++)
          {
            color c = video.pixels[x + y*width];
            avgR += red(c);
            avgG += green(c);
            avgB += blue(c);
          }
        }
        color average = color(avgR/(size*size), avgG/(size*size), avgB/(size*size));
        fill(average);
        noStroke();
        rect(i, j, size, size);
      }
    }
  
}

void mirror()
{
  if (video.available())
  {
    video.read();
    video.loadPixels();
    println(width*height);
    for (int i = 0; i < video.pixels.length; i++)
    {
      int mid = (width/2) + width * (int)(i/width);
      int mir = (mid - i)*2;
      pixels[i] = video.pixels[(i + mir) - 1];
      
    }
    updatePixels();
  }
}

void invert()
{
  if (video.available())
  {
    video.read();
    video.loadPixels();
    
    for (int i = 0; i < video.pixels.length; i++)
    {
      color currentColor = video.pixels[i];
      int currentR = (currentColor >> 16) & 0xFF;
      int currentG = (currentColor >> 8) & 0xFF;
      int currentB = currentColor & 0xFF;
      
      pixels[i] = color(255-currentR, 255-currentG, 255-currentB);
    }
    updatePixels();
  }
}

void displayDifference()
{
  if (video.available())
  {
    video.read();
    video.loadPixels();
    for (int i = 0; i < video.pixels.length; i++)
    {
      color currentColor = video.pixels[i];
      color previousColor = prev[i];
      
      int currentR = (currentColor >> 16) & 0xFF;
      int currentG = (currentColor >> 8) & 0xFF;
      int currentB = currentColor & 0xFF;
      
      int previousR = (previousColor >> 16) & 0xFF;
      int previousG = (previousColor >> 8) & 0xFF;
      int previousB = previousColor & 0xFF;
      
      int diffR = abs(currentR - previousR);
      int diffG = abs(currentG - previousG);
      int diffB = abs(currentB - previousB);
      
      pixels[i] = color(255-diffR, 255-diffG, 255-diffB);
      
      prev[i] = currentColor;
    }
    updatePixels();
  }
}
