int pointDensity = 200;
int multiplier = 0;
int timing;

void setup() {
  //size(700,700);
  fullScreen();
}

void draw() {
  background(0);
  pointsOnCircle(width/2, height/2, pointDensity, multiplier);
  println(multiplier);
  textSize(50);
  text("M = " + multiplier, 100, height-200);
  text("n = " + pointDensity, 100, height -100);
}

void keyPressed() {
  switch(key) {
    case 'd':
      multiplier = multiplier < 50 ? multiplier += 1 : multiplier;
      break;
    case 'a':
      multiplier = multiplier > 0 ? multiplier -= 1 : multiplier;
      break;
    case 'w':
      pointDensity = pointDensity < 500 ? pointDensity += 1 : pointDensity;
      break;
    case 's':
      pointDensity = pointDensity > 0 ? pointDensity -= 1 : pointDensity;
      break;
  }   
}

void pointsOnCircle(int x, int y, int size, int mult) {
  push();
  translate(x,y);
  
  noFill();
  stroke(255);
  strokeWeight(1);
  circle(0,0,height-100);
  
  PVector[] points = new PVector[size];
  float angleDivisions = (2 * PI)/size;
  
  // Creating Points
  for (int n = 0; n < size; n++) {
    points[n] = new PVector(cos(angleDivisions*n)*(height-100)/2, sin(angleDivisions*n)*(height-100)/2);
    stroke(255,0,0);
    strokeWeight(10);
    point(points[n].x, points[n].y);
  }
  
  // Creating Lines
  for (int i = 0; i < points.length; i++) {
    if (i * mult < size) {
      strokeWeight(1);
      line(points[i].x, points[i].y, points[i*mult].x, points[i*mult].y);
    }
    else {
      int t = ((i*mult) - size);
      while (t >= points.length) {
        t -= size;
      }
      //println(t);
      line(points[i].x, points[i].y, points[t].x, points[t].y);
      
    }
  }
  
  
  pop();
}
