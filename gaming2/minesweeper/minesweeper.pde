Minesweeper m;

void setup()
{
  size(1280, 720);
  m = new Minesweeper(10, 10, 10, 50);
}

void draw()
{
  background(#1c1c1c);
  m.display();
}

void mouseClicked()
{
  m.mouseClicked();
  //thread("search");  // Part of the cool visualization
}

void search()        // Cool visualization, can remove when done
{
  m.expandSearch((int)mouseX/50, (int)mouseY/50);
}
