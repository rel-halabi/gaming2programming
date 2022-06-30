class Tile
{
  PVector pos;
  float size;
  
  Tile(float x, float y, float _size)
  {
    pos = new PVector(x, y);
    size = _size;
  }
  
  void display()
  {
    push();
    translate(pos.x, pos.y);
    noStroke();
    fill(0,120,255);
    rect(0, 0, size, size);
    pop();
  }
}
