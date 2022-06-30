class Ray
{
  PVector vDir;
  PVector vPos;
  
  Ray(float x, float y, float z)
  {
    vPos = new PVector(x, y, z);
    vDir = new PVector(-1, -1, -1);
    vDir.normalize();
  }
  
  PVector march(int depth)
  {
    float distances[] = new float[obstacles.length];
    PVector marchDistance = new PVector(vPos.x, vPos.y);
    float distance = 0;
    float threshold = 5;
    for(int d = 0; d < depth; d++)
    {
      for(int i = 0; i < obstacles.length; i++)
      {
        String type = obstacles[i].getClass().getName();
        boolean isBox = type.equals("primitiveRayMarching$Box");
        
        distances[i] = isBox ? dstToBox(marchDistance, obstacles[i].center, obstacles[i].w, obstacles[i].h, obstacles[i].l) : signedDstToCircle(marchDistance, obstacles[i].center, obstacles[i].w);
        //circle(marchDistance.x, marchDistance.y, distances[i]*2);
      }
      distance = min(distances);
      //push();
      //stroke(#bd5a36);
      //noFill();
      //strokeWeight(1);
      //translate(marchDistance.x, marchDistance.y, marchDistance.z);
      //sphere(distance);
      //pop();
      marchDistance.x += vDir.x*distance; marchDistance.y += vDir.y*distance; 
      if(distance < threshold)
      {
        break;
      }
    }
    return marchDistance;
  }
  
  void display()
  {
    PVector end = march(10);
    push();
    strokeWeight(2);
    stroke(#bd3a56);
    line(vPos.x, vPos.y, vPos.z, end.x, end.y, end.z);
    pop();
    //point(vPos.x, vPos.y);
  }
}
