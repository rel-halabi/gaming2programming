Obstacle[] obstacles = new Obstacle[1];
Ray r;

void setup()
{
  size(1400,1000,P3D);
  obstacles[0] = new Sphere(200, 200, 50, 100);
  r = new Ray(width-200, height-200, 0);
}

void draw()
{
  background(#1c1c1c);
  //obstacles[0].display();
  //obstacles[0].center.set(mouseX, mouseY, 0);
  println(signedDstToCircle(r.vPos, obstacles[0].center, obstacles[0].w));
  r.display();
  r.vDir.set(-r.vPos.x+mouseX, -r.vPos.y+mouseY, 0).normalize();
}
