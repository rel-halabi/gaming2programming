int x,y;
float xVelocity,yVelocity;
int diameter;
int radius;
float angle;
float angle2;
PImage star;

void setup() {
  fullScreen();
  x = 75;
  y = 150;
  xVelocity = 75/5;
  yVelocity = 75/5;
  diameter = 150;
  radius = diameter/2;
  star = loadImage("starzyk.png");
  imageMode(CENTER);
}

void draw() {
  background(#314234);
  starzyk();
  checkToMove();
  
}
void starzyk() {
  push();
  translate(x,y);
  rotate(degrees(angle));
  image(star,0,0,diameter,diameter);
  pop();
  angle+= -0.001;
}

// Checks
void checkToMove() {
  if (!touchingRight() && touchingTop()) {
    goRight();
  
  }
  if (!touchingBottom() && touchingRight()) {
    goDown();
  
  }
  if (!touchingLeft() && touchingBottom()) {
    goLeft();
  
  }
  if (!touchingTop() && touchingLeft()) {
    goUp();
  
  } 

}


// Movement
void goLeft() {
  x -= xVelocity;
}
void goRight() {
  x += xVelocity;
}
void goDown() {
  y += yVelocity;
}
void goUp() {
  y -= yVelocity;
}

//Conditions
boolean touchingLeft() {
  return x - radius == 0;
}

boolean touchingRight() {
  return x + radius == width;
}

boolean touchingTop() {
  return y - radius == 0;
}

boolean touchingBottom() {
  return y + radius == height;
}
