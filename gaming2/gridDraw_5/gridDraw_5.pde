int x;
int y;
int size = 7;
int inc;
int radius;
int[][] grid;
int index_x, index_y;
color c = color(255);
int px,py;
  
void setup() {
  size(700,700);
  inc = width/100;
  radius = 3;
  noStroke();
  grid = new int[100][100];
  for(int i = 0; i < 100; i++) {
    for(int j = 0; j < 100; j++) {
      grid[i][j] = color(120);
    }
  }
  
  x = round(mouseX/size)*size;
  y = round(mouseY/size)*size;
  index_x = x/size;
  index_y = y/size;
  px = index_x;
  py = index_y;
  
  drawGrid();
}

void draw() {
  x = round(mouseX/size)*size;
  y = round(mouseY/size)*size;
  index_x = x/size;
  index_y = y/size;
  myMouse();
  //println(index_x , index_y);
}

void keyPressed() {
  switch (key) {
    case ' ':
      clearGrid();
      break;
    case 'w':
      c = color(255);
      break;
    case 'r':
      c = color(255,0,0);
      break;
    case 'b':
      c = color(0,0,255);
      break;
    case 'g':
      c = color(0,255,0);
      break;
    case '1':
      radius = 0;
      break;
    case '2':
      radius = 1;
      break;
    case '3':
      radius = 2;
      break;
    case '4':
      radius = 3;
      break;
    case '5':
      radius = 4;
      break;
    
  }
}

void clearGrid() {
  for(int i = 0; i < 100; i++) {
    for(int j = 0; j < 100; j++) {
      grid[i][j] = color(120);
    }
  }
  drawGrid();
}

void drawGrid() {
  push();
  fill(120);
  stroke(255);
  //for (int i = 0; i < width; i += size) {
  //  for (int j = 0; j < height; j += size) {
  //    rect(i,j,size,size);
  //  }
  //}
  for(int i = 0; i < 100; i++) {
    for(int j = 0; j < 100; j++) {
      fill(grid[i][j]);
      rect(i*size,j*size,size,size);
    }
  }
  pop();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  size = (e == -1) ? (size - 7 > 0 ? size -= inc : size) : (size < 700 ? size += inc : size);
  drawGrid();
  //println(size);
}

void myMouse() {
  if(mousePressed && (px != index_x || py != index_y)) {
    for(int i = 0; i < 100; i++) {
      for(int j = 0; j < 100; j++) {
        if (index_x >= i - radius && index_x <= i + radius && index_y >= j - radius && index_y <= j + radius) {
          grid[i][j] = color(c);
        }
      }
    }
    drawGrid();
    px = index_x;
    py = index_y;
  }
  println("Previous: ", px, py, "Current: ", index_x, index_y);
}
