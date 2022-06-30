//option 4: most customizable

Follower[] snake;

void setup() {
  size(800, 600); 
  int snkLen = 10;
  float startingSize = 100;
  snake = new Follower[snkLen];
  for(int i = 0; i < snkLen; i++)
  {
    snake[i] = new Follower(width/2, height/2, width, height, color(0, int(255 - ((float)i/snkLen)*255), 0), snkLen*5 - ((float)i/snkLen)*(snkLen*5) + 10, (startingSize - ((float)i/snkLen)*startingSize) + 10);
    println(255 - ((float)i/snkLen)*255, snkLen*5 - ((float)i/snkLen)*(snkLen*5) + 10, (startingSize - ((float)i/snkLen)*startingSize) + 10, i);
  }
}

void draw() {
  background(80);
  for(int i = 0; i < snake.length; i++)
  {
    if (i > 0) snake[i].followMe(snake[i-1].x, snake[i-1].y);
    else snake[i].followMe(mouseX, mouseY);
    
    snake[i].draw();
  }
}

class Follower {
  float x;
  float y;
  float speed;
  float size;
  float followX;
  float followY;
  float rangeX;
  float rangeY;
  int myColor;

  Follower(float x, float y, float rangeX, float rangeY) {
    this.x = x;
    this.y = y;
    this.speed = 5;
    this.size = 80;
    this.followX = x;
    this.followY = y;
    this.rangeX = rangeX;
    this.rangeY = rangeY;
    this.myColor = #888888;
  }

  //long version of Constructor
    Follower(
      float x, float y, float rangeX, 
      float rangeY, int myColor, float speed, float size) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.size = size;
    this.followX = x;
    this.followY = y;
    this.rangeX = rangeX;
    this.rangeY = rangeY;
    this.myColor = myColor;
  }

  void followMe(float followX, float followY) {
    this.followX = followX;
    this.followY = followY;
    x += (followX - x)/rangeX * speed;
    y += (followY - y)/rangeY * speed;
  }

  void draw() {
    stroke(255);
    strokeWeight(3);
    fill(myColor);
    ellipse(x, y, size, size);
    followMe(followX, followY);
  }
  
  void setSpeed(float speed) {
    this.speed = speed;
  }
  
  void setColor(int myColor) {
    this.myColor = myColor;
  }
  
  void setSize(float size) {
    this.size = size;
  }
}
