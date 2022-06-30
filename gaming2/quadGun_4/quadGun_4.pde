PVector pos,vel;
float dir;
float dir2;
float px,py;
boolean shoot,shoot2;
float h = 100;

void setup() {
  size(700,700);
  pos = new PVector(width/2,height/2);
  px = pos.x;
  py = pos.y;
  vel = new PVector(5,5);
  shoot = false;
  shoot2 = false;
  colorMode(RGB);
}

void draw() {
  background(255);
  thingy(pos.x,pos.y, 1, 0);
  if(shoot) {
    shootFour(px,py);
    dir ++;
  }
  if (dir > 300) {
    shoot = false;
    px = pos.x;
    py = pos.y;
    dir = 0;
  }
  if(shoot2) {
    shootArc(px,py);
    dir2++;
  }
  if (dir2 > 300) {
    shoot2 = false;
    px = pos.x;
    py = pos.y;
    dir2 = 0;
  }
  println(shoot2);
  health(pos.x - h, pos.y - 100, h);
  h -= 0.1;
}

void shootFour(float x, float y) {
  bullet(x + dir, y);
  bullet(x + -dir, y);
  bullet(x, y + dir);
  bullet(x, y + -dir);
  
}

void shootArc(float x, float y) {
  push();
  translate(x,y);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  rotate(PI/12);
  bullet(0,0 - dir2);
  
  pop();
  

}

void bullet(float x, float y) {
  push();
  translate(x,y);
  fill(255,0,0);
  noStroke();
  rect(-10,-10,20,20);
  pop();
}

void keyPressed() {
  switch(key) {
    case 'w':
      pos.y += -vel.y;
      break;
    case 'a':
      pos.x += -vel.x;
      break;
    case 's':
      pos.y += vel.y;
      break;
    case 'd':
      pos.x += vel.x;
      break;
    case ' ':
      shoot2 = true;
      break;
    default:
      shoot = true;
      break;
  }
  if (!shoot && !shoot2) {
    dir = 0;
    dir2 = 0;
    px = pos.x;
    py = pos.y;
  }
  
  
}

void health(float x, float y, float h) {
  float prog = map(h,0,100,0,200);
  if (h < 0 || h > 100) {
    return;
  }
  push();
  fill(255,0,0);
  rect(x,y,prog,20);
  pop();
}



//Raja’s Thingy
void thingy(float x, float y, float scale, float rotation) {
  //Do not remove
  float a = map(mouseX, 0, width, 0, 255);
  float b = map(mouseX, 0, width, 255, 0);
  push();
  rectMode(CORNER);
  translate(x, y);
  scale(scale);
  rotate(rotation);
  colorMode(HSB);
  //start editing here
  push();
  colorMode(HSB);
  fill(b,255,255);
  circle(0,0,150);
  colorMode(RGB);
  fill(255);
  circle(0,0,125);
  pop();
  push();
  fill(0, 255, 255, 10);
  rect(0,-25, 25, -20);
  rotate(PI/3);
  fill(25, 255, 255,50);
  rect(0,-25, 25, -20);
  rotate(PI/3);
  fill(50, 255, 255,100);
  rect(0,-25, 25, -20);
  rotate(PI/3);
  fill(75, 255, 255,150);
  rect(0,-25, 25, -20);
  rotate(PI/3);
  fill(100, 255, 255,200);
  rect(0,-25, 25, -20);
  rotate(PI/3);
  fill(125, 255, 255,250);
  rect(0,-25, 25, -20);
  fill(a,255,255);
  circle(0,0, 25);
  pop();
  //do not remove
  pop();
}
