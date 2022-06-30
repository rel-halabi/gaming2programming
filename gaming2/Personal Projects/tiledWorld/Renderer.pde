void render()
{
  push();
  translate(width/2, 0);
  float maxDist = sqrt(ts.spaceWidth*ts.spaceWidth + ts.spaceHeight*ts.spaceHeight);
  float size = map(dist(b.pos.x, b.pos.y, rayCast(a.pos, b.pos).x, rayCast(a.pos, b.pos).y), 0, maxDist, maxDist, 0);
  fill(0);
  rect(0,0,width/2, height);
  fill(0,0,255);
  rectMode(CENTER);
  if(rayCast(a.pos, b.pos).x != -1)
  {
    rect(width/4, height/2, 50, size);
  }
  pop();
}
