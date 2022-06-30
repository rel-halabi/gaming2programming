class Button {
  
  int x,y,c,size;
  String s;
  boolean lit;
  float time;
  
  Button(int _x, int _y, int _c, String _s) {
    x = _x;
    y = _y;
    c = _c;
    s = _s;
    lit = true;
    size = 600;
  }
  
  void model() {
    noStroke();
    fill(lit ? c : 50);
    switch(s) {
      case "topLeft":
        arc(x, y, size, size, PI, 3*PI/2, PIE);
        break;
      case "topRight":
        arc(x, y, size, size, 3*PI/2, 2*PI, PIE);
        break;
      case "bottomRight":
        arc(x, y, size, size, 0, PI/2, PIE);
        break;
      case "bottomLeft":
        arc(x, y, size, size, PI/2, PI, PIE);
        break;
        
    }
    if (lit) {
      time += 0.1;
    }
    if(time > 5 || !lit) {
      time = 0;
      lit = false;
    }
  }
  
  void clicked(int mx, int my) {
    switch(s) {
      case "topLeft":
        if (mx < x && mx > x - size/2 && my > y - size/2 && my < y && dist(mx,my,x,y) < size) {
          lit = !lit;
        }
        break;
      case "topRight":
        if (mx > x && mx < x + size/2 && my > y - size/2 && my < y && dist(mx,my,x,y) < size) {
          lit = !lit;
        }
        break;
      case "bottomLeft":
        if (mx < x && mx > x - size/2 && my < y + size/2 && my > y && dist(mx,my,x,y) < size) {
          lit = !lit;
        }
        break;
      case "bottomRight":
        if (mx > x && mx < x + size/2 && my < y + size/2 && my > y && dist(mx,my,x,y) < size) {
          lit = !lit;
        }
        break;
    }
  }
  
}
