color[] mirror;
void setup()
{
  size(500,500);
  noStroke();
  fill(255,0,0);
  rect(0,0,width/2,height);
  fill(0,255,0);
  rect(width/2, 0, width/2, height);
  fill(255);
  text("Left", 0, height/2);
  text("Right", width/2, height/2);
  loadPixels();
  mirror = new color[pixels.length];
  mirror = verticalFlip(pixels, width);
  mirror = horizontalFlip(mirror, width);
  for (int i = 0; i < pixels.length; i++)
  {
    pixels[i] = mirror[i];
    println("working");
  }
  updatePixels();
}

void draw()
{
  
}

void keyPressed()
{
 
}
color[] horizontalFlip(color[] pixelArray, int imgWidth)
{
  color[] flipped = new color[pixelArray.length];
  for (int y = 0; y < pixelArray.length/imgWidth; y++)
  {
    for (int x = 0; x < imgWidth; x++)
    {
      flipped[x + y*imgWidth] = pixelArray[((imgWidth-x) + y*imgWidth) - 1];
    }
  }
  return flipped;
}

color[] verticalFlip(color[] pixelArray, int imgWidth)
{
  color[] flipped = new color[pixelArray.length];
  for (int y = 0; y < pixelArray.length/imgWidth; y++)
  {
    for (int x = 0; x < imgWidth; x++)
    {
      flipped[x + y*imgWidth] = pixelArray[(x + ((pixelArray.length/imgWidth)-y-1)*imgWidth)];
    }
  }
  return flipped;
}
