class Vehicle {
  PVector pos,vel,acc;
  int r;
  float maxSpeed, maxForce;
  color c;
  
  Vehicle(int x, int y, color c) {
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    this.c = c;
    maxSpeed = 5;
    maxForce = 0.1;
    r = 10;
  }
  
  PVector evade(Vehicle vehicle) {
    PVector evasion = pursue(vehicle);
    evasion.mult(-1);
    return evasion;
  }
  
  PVector pursue(Vehicle vehicle) {
    PVector target = vehicle.pos.copy();
    PVector prediction = vehicle.vel.copy();
    target.add(prediction.mult(10));
    return seek(target);
  }
  
  PVector flee(PVector target) {
    return seek(target).mult(-1);
  }
  
  PVector seek(PVector target) {
    PVector desired = new PVector(target.x - pos.x, target.y - pos.y);
    desired.setMag(maxSpeed);
    PVector steering = new PVector(desired.x - vel.x, desired.y - vel.y);
    steering.limit(maxForce);
    
    return steering;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.set(0,0);
  }
  
  void show() {
    push();
    stroke(c);
    fill(c);
    translate(pos.x,pos.y);
    rotate(vel.heading());
    triangle(-r,-r/2,-r,r/2,r,0);
    pop();
  }
  
  void edges() {
    if(pos.x > width) {
      pos.x = 0;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if(pos.x < 0) {
      pos.x = width;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }
}
