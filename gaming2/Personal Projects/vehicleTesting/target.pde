class Target extends Vehicle {
  Target(int x, int y, color c) {
    super(x,y,c);
  }
  
  void show() {
    push();
    stroke(c);
    fill(c);
    translate(pos.x,pos.y);
    rotate(vel.heading());
    circle(0,0, r*2);
    pop();
  }
}
