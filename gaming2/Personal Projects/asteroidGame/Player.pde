class Player {
  int x,y;
  float angle;
  int a;
  boolean shooting = false;
  Bullet b;
  Player(int x, int y, float angle) {
    this.x = x;
    this.y = y;
    a = 0;
    b = new Bullet(x,y);
  }
  
  void draw() {
    model();
    if(keyPressed) {
      checkForKey();
    }
    if(shooting) {
      shoot();
    }
    if (b.x > width || b.x < 0 || b.y > height || b.y < 0) {
      shooting = false;
    }
    if (!shooting) {
      b.x = x;
      b.y = y;
    }
  }
  
  void checkForKey() {
    if(key == 'd') {
      angle += PI/15;
    }
    
    if(key == 'a') {
      angle -= PI/15;
    }
    
    if (key == ' ' && !shooting) {
      b.vel.x = sin(angle)*5;
      b.vel.y = -cos(angle)*5;
      shooting = true;
    }
  }
  
  void shoot() {
    b.x += b.vel.x;
    b.y += b.vel.y;
    b.draw();
  }

  
  void model() {
    push();
    translate(x, y);
    rotate(angle);
    scale(2);
    noFill();
    stroke(255);
    triangle(-10, 10, 10, 10, 0, -20);
    pop();
  }
  
}
