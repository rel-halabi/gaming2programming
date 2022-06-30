class Player
{
  PVector pos;
  float angle;
  float stepSize = 5;
  float turnBy = PI/8;
  PVector cameraPlaneStart, cameraPlaneEnd;
  float planeDist = 25;
  
  Player(float x, float y)
  {
    pos = new PVector(x, y);
    angle = 0;
    cameraPlaneStart = new PVector();
    cameraPlaneEnd = new PVector();
  }
  
  void updatePlane()
  {
    cameraPlaneStart.set(pos.x+cos(angle-(PI/4))*planeDist, pos.y+sin(angle-(PI/4))*planeDist);
    cameraPlaneEnd.set(pos.x+cos(angle+(PI/4))*planeDist, pos.y+sin(angle+(PI/4))*planeDist);
  }
  
  void display()
  {
    push();
    translate(pos.x, pos.y);
    scale(5);
    rotate(angle + PI/2);
    fill(255, 0, 0);
    noStroke();
    beginShape();
    vertex(-2, 2);
    vertex(2, 2);
    vertex(0, -3);
    endShape(CLOSE);
    stroke(255,0,0);
    pop();
    updatePlane();
    push();
    stroke(255,0,0);
    strokeWeight(5);
    line(cameraPlaneStart.x, cameraPlaneStart.y, cameraPlaneEnd.x, cameraPlaneEnd.y);
    pop();
  }
  
  char keyPressed()
  {
    switch(key)
    {
      case 'w':
        pos.x += cos(angle)*stepSize; pos.y += sin(angle)*stepSize;
        break;
      case 's':
        pos.x -= cos(angle)*stepSize; pos.y -= sin(angle)*stepSize;
        break;
      case 'a':
        angle -= turnBy;
        break;
      case 'd':
        angle += turnBy;
        break;
    }
    return key;
  }
}
