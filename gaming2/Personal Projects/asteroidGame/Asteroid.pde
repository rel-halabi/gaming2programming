class Asteroid {
  boolean destroyed;
  float scale = 8;
  PVector target;
  PVector vel;
  PVector acc;
  PVector pos;
  PVector initial;
  
  Asteroid(int x, int y, int tx, int ty) {
    pos = new PVector(x,y);
    initial = new PVector(x,y);
    target = new PVector(tx,ty);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    destroyed = false;
  }
  
  void draw() {
    if (!destroyed) {
      model();
    }
    else {
      pos.x = initial.x + int(random(100, 500));
      pos.y = initial.y + int(random(100, 500));
      destroyed = false;
    }
    applyForce(seek());
    update();
  }
  
  PVector seek() {
    PVector desired = new PVector(target.x - pos.x, target.y - pos.y);
    desired.setMag(1);
    PVector steering = new PVector(desired.x - vel.x, desired.y - vel.y);
    steering.limit(1);
    return steering;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(1);
    pos.add(vel);
    acc.set(0,0);
  }
  
  void model() {
    push();
    noFill();
    stroke(0,255,0);
    strokeWeight(0.2);
    translate(pos.x,pos.y);
    scale(scale);
    beginShape();
    vertex(-9, 0);
    vertex(-5, -7);
    vertex(0, -10);
    vertex(5, -5);
    vertex(3, 0);
    vertex(5, 3);
    vertex(4, 9);
    vertex(-4, 8);
    endShape(CLOSE);
    stroke(0,0,255);
    //rect(-9,-10,14,19);
    pop();
  }
}
