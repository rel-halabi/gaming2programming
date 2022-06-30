Game game;

void setup()
{
  fullScreen();
  game = new Game(this, 0);
}

void draw()
{
  game.display();
}

void keyPressed()
{
  game.keyPressed();
}
