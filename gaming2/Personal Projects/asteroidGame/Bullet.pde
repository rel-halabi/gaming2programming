class Bullet {
  int x,y;
  PVector vel = new PVector(0,0);
  Bullet(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void draw() {
    model();
  }
  
  void model() {
    push();
    translate(x, y);
    rectMode(CENTER);
    noFill();
    stroke(255,0,0);
    rect(0,0, 10, 10);
    pop();
  }
}
