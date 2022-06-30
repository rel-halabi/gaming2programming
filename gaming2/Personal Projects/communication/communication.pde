Communicator c;
String message = "";

void setup()
{
  size(700,700);
  c = new Communicator("DATA.json", 0, 1);
}

void draw()
{
  background(0);
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text(c.getMessage(), width/2, height/2);
  text(message, width/2, height/2 + 100);
  c.update();
}

void keyPressed()
{
  if ((int(key) >= 65 && int(key) <= 65+26) || (int(key) >= 97 && int(key) <= 97+26) || int(key) == 32)
  {
    message = message + key;
  }
  if (key == BACKSPACE && message.length() > 0)
  {
    message = message.substring(0, message.length() - 1);
  }
  if (key == ENTER)
  {
    c.sendMessage(message);
  }
}
