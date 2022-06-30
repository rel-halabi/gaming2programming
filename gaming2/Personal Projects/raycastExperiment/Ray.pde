class Ray
{
  PVector origin;
  PVector dir;
  float maxDist;
  
  Ray(float x, float y, float angle)
  {
    origin = new PVector(x, y);
    dir = new PVector(cos(angle), sin(angle));
    maxDist = 500;
  }
  
  void display()
  {
    push();
    translate(origin.x, origin.y);
    stroke(0, 255, 0);
    line(0, 0, dir.x*maxDist, dir.y*maxDist);
    pop();
  }
  
  PVector march(float w, float h)
  {
    int count = 0;
    PVector[] walls = new PVector[map.length];
    for(int y = 0; y < 8; y++)
    {
      for(int x = 0; x < 8; x++)
      {
        if(map[y*8+x] > 0)
        {
          count++;
          walls[y*8+x] = new PVector(x, y);
        }
      }
    }
    
    float[] distances = new float[count];
    float distance = 0;
    PVector marchRay = origin.copy(); 
    
    for(int d = 0; d < 5; d++)
    {
      int index = 0;
      for(int i = 0; i < walls.length; i++)
      {
        if(walls[i] != null)
        {
          PVector center = new PVector(walls[i].x*w, walls[i].y*h);
          distances[index] = dstToBox(marchRay, center, w, h);
          index++;
        }
      }
      distance = min(distances);
      marchRay.set(marchRay.x+dir.x*distance, marchRay.y+dir.y*distance);
    }
    
    return marchRay;
  }
  
  PVector cast()
  {
    PVector collision = new PVector(-1, -1);
    float step = 0.01;
    float start = 0;
    for(int iter = 0; iter < 10; iter++)
    {
      for(float l = start; l < 1; l += step)
      {
        float x = lerp(origin.x, origin.x+(dir.x*maxDist), l);
        float y = lerp(origin.y, origin.y+(dir.y*maxDist), l);
        
        int tile = determineTile(x, y);
        if(tile >= 0 && tile < map.length)
        {
          if(map[tile] == 1)
          {
            collision.set(x, y);
            start -= step;
            step /= 2;
            break;
          }
        }
      }
    }
    
    return collision;
  }
}
