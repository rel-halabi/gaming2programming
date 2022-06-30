Target target;
Vehicle pursuer;
Vehicle v;

PVector t;


void setup() {
  size(700,700);
  target = new Target(width/2, height/2,color(255,0,0));
  pursuer = new Vehicle(width/2,height/2,color(0,255,0));
  v = new Vehicle(width/2 + 1, height/2 + 1, color(255,0,0));
}

void draw() {
  background(0);
  t = new PVector(mouseX,mouseY);
  fill(255,0,0);
  noStroke();
  circle(t.x,t.y,10);
  PVector seek = pursuer.seek(target.pos);
  pursuer.applyForce(pursuer.pursue(v));
  pursuer.update();
  pursuer.edges();
  pursuer.show();
  v.applyForce(v.seek(t));
  v.update();
  v.edges();
  v.show();
  
}

void tell() {
  PVector test = new PVector(40,40);
  PVector test2 = new PVector(10,10);
  PVector test3 = new PVector(test2.x - test.x, test2.y - test.y);
  println(test,test2,test3);
}
