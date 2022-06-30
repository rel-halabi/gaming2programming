TileSpace ts;
Player a, b;

void setup()
{
  size(1000,700);
  ts = new TileSpace(10,14, 500, 700);
  a = new Player(0, 0, color(0,255,0));
  b = new Player(width/2, height/2, color(255,0,0));
}

void draw()
{
  ts.display();
  a.display();
  b.display();
  
  a.pos.set(mouseX, mouseY);
  if(mousePressed)
  {
    mouseActions();
  }
  println(ts.cellCoord(mouseX, mouseY), ts.cellCoord(b.pos.x, b.pos.y));
}

//Graphics

void dottedLine(float x1, float y1, float x2, float y2, float sparcity)
{
  float dots = dist(x1, y1, x2, y2)/sparcity;
  for(int i = 0; i <= dots; i++)
  {
    float x = lerp(x1, x2, i/dots);
    float y = lerp(y1, y2, i/dots);
    
    point(x,y);
  }
}

//User Interaction

void keyPressed()
{
  if(key == ' ')
  {
    ts.clearMap();
  }
  
  switch(key)
  {
    case 'w':
      b.pos.y -= 10;
      break;
    case 'a':
      b.pos.x -= 10;
      break;
    case 's':
      b.pos.y += 10;
      break;
    case 'd':
      b.pos.x += 10;
      break;
  }
}

void mouseActions()
{
  if(mouseButton == RIGHT)
  {
    ts.setCell(mouseX, mouseY);
  }
  else
  {
    push();
    stroke(255);
    strokeWeight(2);
    dottedLine(a.pos.x, a.pos.y, b.pos.x, b.pos.y, 10);
    colorCells(b.pos.x, b.pos.y, a.pos.x, a.pos.y);
    noFill();
    circle(rayCast(a.pos, b.pos).x, rayCast(a.pos, b.pos).y, 10);
    pop();
    render();
    
  }
}

PVector rayCast(PVector a, PVector b)
{
  PVector hit = new PVector(-1, -1);
  float l = 1/(((ts.tileWidth+ts.tileHeight)/2) * 10);
  float start = 0;
  for(int iterations = 0; iterations < 10; iterations++)
  {
    for(float i = start; i < 1; i+=l)
    {
      float x = lerp(b.x, a.x, i);
      float y = lerp(b.y, a.y, i);
      if(ts.tileMap[ts.whichCell(x, y)] == 1)
      {
        hit.set(x, y);
        start = i-l;
        l /= 2;
        break;
      }
    }
  }
  
  return hit;
}

void colorCells(float x1, float y1, float x2, float y2)
{
  float factor = dist(x1, y1, x2, y2)/10;
  PVector dir = new PVector(x2 - x1, y2 - y1).normalize();
  for(int i = 0; i < factor; i++)
  {
    float x = lerp(x1, x2, i/factor);
    float y = lerp(y1, y2, i/factor);
    
    PVector r = ts.cellCoord(x, y);
    println(r);
    if (ts.whichCell(x, y) < ts.tileMap.length)
    {
      if(ts.tileMap[ts.whichCell(x, y)] != 1)
      {
        push();
        noStroke();
        fill(0,255,0,50);
        rect(r.x*ts.tileWidth, r.y*ts.tileHeight, ts.tileWidth, ts.tileHeight);
        pop();
      }
      else
      {
        push();
        stroke(255,0,0);
        if (dir.x > 0)
        {
          line(r.x*ts.tileWidth, r.y*ts.tileHeight, r.x*ts.tileWidth, r.y*ts.tileHeight + ts.tileHeight);
        }
        else
        {
          line(r.x*ts.tileWidth + ts.tileWidth, r.y*ts.tileHeight, r.x*ts.tileWidth + ts.tileWidth, r.y*ts.tileHeight + ts.tileHeight);
        }
        
        if (dir.y > 0)
        {
          line(r.x*ts.tileWidth, r.y*ts.tileHeight, r.x*ts.tileWidth + ts.tileWidth, r.y*ts.tileHeight);
        }
        else
        {
          line(r.x*ts.tileWidth, r.y*ts.tileHeight + ts.tileHeight, r.x*ts.tileWidth + ts.tileWidth, r.y*ts.tileHeight + ts.tileHeight);
        }
        pop();
        break;
      }
    }
  }
}
