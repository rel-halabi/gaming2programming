class Voronoi
{
  HashMap<String, PVector> points;
  
  
  Voronoi()
  {
    points = new HashMap<String, PVector>();
    loadPixels();
  }
  
  void draw()
  {
    background(0);
    for(int y = 0; y < height; y++)
    {
      for(int x = 0; x < width; x++)
      {
        pixels[y*width+x] = voronoi(x, y);
      }
    }
    updatePixels();
    strokeWeight(5);
    stroke(255,0,0);
    for(PVector p : points.values())
    {
      point(p.x, p.y);
    }
  }
  
  color voronoi(float x, float y)
  {
    if(points.size() < 1) return color(0);
    PVector closest = new PVector(1e30, 1e30);
    for(String s : points.keySet())
    {
      if(dist(points.get(s).x, points.get(s).y, x, y) < dist(closest.x, closest.y, x, y)) closest = points.get(s);
    }
    //println(closest.z);
    return (color)closest.z;
  }
  
  void updateHash(HashMap<String, PVector> data)
  {
    points = data;
  }
  
  void smoothMove(String name, float x, float y)
  {
    
    PVector p = points.get(name);
    float i = map(dist(p.x, p.y, x, y), 0, sqrt(width*width + height*height), 0.2, 1);
    PVector n = PVector.lerp(p, new PVector(x, y, p.z), i);
    points.replace(name, n);
    //println(i);

  }
  
  void addPoint(String name, float x, float y)
  {
    for(String s : points.keySet())
    {
      if(s.equals(name)) 
      {
        points.replace(name, new PVector(x, y, points.get(name).z));
        //smoothMove(name, x, y);
        return;
      }
    }
    points.put(name, new PVector(x, y, color(random(100, 255), random(100, 255), random(100, 255))));
  }
  
  void removePoint(String name)
  {
    points.remove(name);
  }
  
}
