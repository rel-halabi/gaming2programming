Box b;

void setup() {
  size(800, 600);
  b = new Box(width/2, height/2, 100, 100);
}

void draw() {
  background(90);
  b.display();
}

void keyPressed() {
  switch(key) {
    case 'd':
      b.moveRight();
    break;
    case 'a':
      b.moveLeft();
    break;
    case 'w':
      b.moveUp();
    break;
    case 's':
      b.moveDown();
    break;
    case 'i':
      b.growTaller();
    break;
    case 'k':
      b.growShorter();
    break;
    case 'l':
      b.growWider();
    break;
    case 'j':
      b.growSkinnier();
    break;
    case '.':
      b.rotateRight();
    break;
    case ',':
      b.rotateLeft();
    break;
    case 'f':
      b.fadeALittle();
    break;
    case 'g':
      b.getMoreSolid();
    break;
  }
}

//-------------------------------------------
class Box {

  float x,y,w,h,r,a;
  
  Box(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    a = 255;
    r = 0;
  }

  void display() {
    push();
    translate(x + w/2, y + h/2);
    rotate(r);
    fill(255, 255, 255, a);
    rect(-w/2, -h/2, w, h);
    pop();
  }
  
  void moveRight() {
    x++;
  }
  void moveLeft() {
    x--;
  }
  void moveUp() {
    y--;
  }
  void moveDown() {
    y++;
  }
  void growTaller()
  {
    h++;
  }
  void growShorter()
  {
    h--;
  }
  void growWider()
  {
    w++;
  }
  void growSkinnier()
  {
    w--;
  }
  void rotateRight()
  {
    r -= PI/10;
  }
  void rotateLeft()
  {
    r += PI/10;
  }
  void fadeALittle()
  {
    a = a > 0 ? a - 1 : a;
  }
  void getMoreSolid()
  {
    a = a < 255 ? a + 1 : a;
  }
  
}
