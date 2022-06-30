int amount = 100;
Tile[] tiles = new Tile[amount*amount];

void setup()
{
  size(900,900);
  for(int y = 0; y < tiles.length/amount; y++)
  {
    for(int x = 0; x < tiles.length/amount; x++)
    {
      tiles[floor(y*(tiles.length/amount))+x] = new Tile(x*(width/amount), y*(height/amount), width/amount);
      int f = round(random(0, 1));
      //if(f == 1) tiles[floor(y*(tiles.length/amount))+x].flipped = true;
    }
  }
}

void draw()
{
  background(#212738);
  for(Tile t : tiles)
  {
    t.display();
  }
}

void keyPressed()
{
  for(int y = 0; y < tiles.length/amount; y++)
  {
    for(int x = 0; x < tiles.length/amount; x++)
    {
      //tiles[floor(y*(tiles.length/amount))+x] = new Tile(x*(width/amount), y*(height/amount), width/amount);
      int f = round(random(0, 1));
      if(f == 1) tiles[floor(y*(tiles.length/amount))+x].flipped = true;
      else       tiles[floor(y*(tiles.length/amount))+x].flipped = false;
    }
  }
}
class Tile
{
  PVector pos;
  boolean flipped;
  float size;
  boolean outline = false;
  
  Tile(float x, float y, float size)
  {
    pos = new PVector(x, y);
    this.size = size;
    flipped = false;
  }
  
  void display()
  {
    circles();
  }
  
  void icircles()
  {
    push();
    if(outline) stroke(#C1B2AB);
    else        noStroke();
    if(!flipped)
    {
      fill(#212738);
      rect(pos.x, pos.y, pos.x+size, pos.y+size);
      fill(#D33F49);
      arc(pos.x, pos.y, size, size, 0, PI/2);
      arc(pos.x+size, pos.y+size, size, size, PI, 3*PI/2);
    }
    else
    {
      fill(#D33F49);
      rect(pos.x, pos.y, pos.x+size, pos.y+size);
      fill(#212738);
      arc(pos.x, pos.y, size, size, 0, PI/2);
      arc(pos.x+size, pos.y+size, size, size, PI, 3*PI/2);
    }
    pop();
  }
  
  void circles()
  {
    push();
    noFill();
    if(outline) stroke(#C1B2AB);
    else        noStroke();
    rect(pos.x, pos.y, pos.x+size, pos.y+size);
    stroke(#D33F49);
    strokeWeight(3);
    if(!flipped)
    {
      arc(pos.x, pos.y, size, size, 0, PI/2);
      arc(pos.x+size, pos.y+size, size, size, PI, 3*PI/2);
    }
    else
    {
      arc(pos.x, pos.y+size, size, size, 3*PI/2, 2*PI);
      arc(pos.x+size, pos.y, size, size, PI/2, PI);
    }
    pop();
  }
  
  void lines()
  {
    push();
    noFill();
    if(outline) stroke(#C1B2AB);
    else        noStroke();
    rect(pos.x, pos.y, pos.x+size, pos.y+size);
    stroke(#D33F49);
    if(!flipped) line(pos.x, pos.y, pos.x+size, pos.y+size);
    else         line(pos.x+size, pos.y, pos.x, pos.y+size);
    pop();
  }
}
