class Simon {
  
  Button red,green,blue,yellow;
  int x,y;
  float time;
  boolean wait;
  boolean w;
  ArrayList<Integer> pattern;
  ArrayList<Integer> input;
  int round;
  int iter;
  Simon(int _x, int _y) {
    x = _x;
    y = _y;
    red = new Button(x+4,y-4,#FF0000,"topRight");
    blue = new Button(x+4,y+4,#0000FF,"bottomRight");
    green = new Button(x-4,y-4,#00FF00,"topLeft");
    yellow = new Button(x-4,y+4,#FFFF00,"bottomLeft");
    pattern = new ArrayList<Integer>();
    input = new ArrayList<Integer>();
    w = false;
    round = 1;
    iter = 0;
  }
  
  void draw() {
    fill(0);
    circle(x,y,635);    
    red.model();
    blue.model();
    green.model();
    yellow.model();
    fill(0);
    circle(x,y,300);
    if (mousePressed && !wait) {
      clicked();
      check();
    }
    if(wait) {
      time += 0.1;
    }
    if(time > 1) {
      wait = false;
      time = 0;
    }
    if(!green.lit && !red.lit && !blue.lit && !yellow.lit) {
      w = false;
    }
    game();
  }
  
  void check() {
    if (!w) {
      if (green.lit) {
        input.add(0);
        w = true;
      }
      if (red.lit) {
        input.add(1);
        w = true;
      }
      if (blue.lit) {
        input.add(2);
        w = true;
      }
      if (yellow.lit) {
        input.add(3);
        w = true;
      }
    }
  }
  
  
  void game() {
    for(int i = 0; i < pattern.size(); i++) {
      print(pattern.get(i));
    }
    println();
    while (iter < round) {
      pattern.add(int(random(3)));
      iter++;
    }
    
  }
  
  void display() {
    
  }
  
  void clicked() {
    if (dist(mouseX,mouseY,x,y) > 300/2 && dist(mouseX,mouseY,x,y) < 635/2) {
      if (!red.lit && !blue.lit && !green.lit && !yellow.lit) {
        red.clicked(mouseX,mouseY);
        blue.clicked(mouseX,mouseY);
        green.clicked(mouseX,mouseY);
        yellow.clicked(mouseX,mouseY);
      }
      wait = true;
    } 
  }
}
