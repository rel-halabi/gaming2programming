ArrayList<Tile> tiles;
float size = 35;
Point a, b;

void setup()
{
  size(700,700);
  tiles = new ArrayList<Tile>();
  a = new Point(width/2, height/2, color(255,0,0));
  b = new Point(width/2, height/2, color(0,255,0));
}

void draw()
{
  background(0);
  for(Tile t : tiles)
  {
    t.display();
  }
  grid();
  b.pos.set(mouseX,mouseY);
  b.display();
  a.display();
  if(mousePressed)
  {
    mouseActions();
  }
  println(tiles.size());
}

void keyPressed()
{
  if(key == ' ')
  {
    for(int i = tiles.size()-1; i >= 0; i--)
    {
      tiles.remove(i);
    }
  }
  switch(key)
  {
    case 'w':
      a.pos.y -= size/2;
      break;
    case 'a':
      a.pos.x -= size/2;
      break;
    case 's':
      a.pos.y += size/2;
      break;
    case 'd':
      a.pos.x += size/2;
      break;
    case ' ':
      for(int i = tiles.size()-1; i >= 0; i--)
      {
        tiles.remove(i);
      }
      break;
    
  }
}

void mouseActions()
{
  if(mouseButton == RIGHT)
  {
    boolean occupied = false;
    for (int i = 0; i < tiles.size(); i++)
    {
      if (tiles.get(i).pos.x == floor(mouseX/size)*size && tiles.get(i).pos.y == floor(mouseY/size)*size)
      {
        occupied = true;
      }
    }
    if(!occupied)
    {
      tiles.add(new Tile(floor(mouseX/size)*size, floor(mouseY/size)*size, size));
    }
  }
  else if (mouseButton == LEFT)
  {
    push();
    stroke(255);
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
    pop();
  }
}

void grid()
{
  push();
  stroke(255);
  for(int i = 0; i < width; i+=size)
  {
    line(i, 0, i, height);
    line(0, i, width, i);
  }
  pop();
}
