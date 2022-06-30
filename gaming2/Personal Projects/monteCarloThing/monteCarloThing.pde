ArrayList<Integer> xcomponent;
ArrayList<Integer> ycomponent;

long numerator = 0;
long denominator = 0;
long iterations = 0;

void setup() {
  size(700,700);
  xcomponent = new ArrayList<Integer>();
  ycomponent = new ArrayList<Integer>();
}

void draw() {
  background(0);
  stroke(255,0,0);
  noFill();
  circle(width/2, height/2, 700);
  drawPoints();
  createPoint(10);
  calcPi();
  iterations++;
}

void createPoint(int limit) {
  int n = 0;
  while (n < limit) {
    int x = (int) random(0,width);
    int y = (int) random(0,height);
    xcomponent.add(x);
    ycomponent.add(y);
    n++;
  }
  for (int i = 0; i < xcomponent.size(); i++) {
    if (dist(xcomponent.get(i),ycomponent.get(i),width/2,height/2) <= 700/2) {
      numerator++;
    }
    else {
      denominator++;
    }
  }
}

double calcPi() {
  double pi;
  long total = numerator + denominator;
  if (denominator != 0) {
    pi = 4 * ((double) numerator/total);
    println(pi, total, iterations);
  }
  else {
    pi = 1;
  }
  return pi;
}

void drawPoints() {
  for (int i = 0; i < xcomponent.size(); i++) {
    if (dist(xcomponent.get(i),ycomponent.get(i),width/2,height/2) <= 700/2) {
      stroke(255,0,0);
    }
    else {
      stroke(0,0,255);
    }
    point(xcomponent.get(i),ycomponent.get(i));
  }
}
