Network net;
Voronoi v;
int i = 0;
boolean amServer = true;
String name = "Bob";
int time = millis();

boolean gameStart = false;

void setup()
{
  size(1280, 720);
  v = new Voronoi();
  net = new Network(this);
  net.startServer();
  net.startClient("127.0.0.1");
}

void draw()
{
  background(0);
  if(!gameStart)
  {
    String s = "Voronoi Visualization";
    String s2 = "Press space to start";
    textSize(50);
    text(s, width/2 - textWidth(s)/2, height/2);
    textSize(25);
    text(s2, width/2 - textWidth(s2)/2, height/2 + 50);
    return;
  }
  if(amServer)
  {
    String s;
    s = net.getNext();
    if(s != null) net.broadcast(s);
  }
  
  v.draw();
  if(millis() - time >= 200) 
  {
    net.putString(name + ":" + mouseX + ":" + mouseY);
    time = millis(); 
  }
  thread("updateData");
  //updateData();
}

void keyPressed()
{
  if(key == ' ') gameStart = true;
}

void updateData()
{
  String data = net.getString();
  if(data == null) return;
  String[] d = split(data, ':');
  if(d.length != 3) return;
  //println(d);
  v.addPoint(d[0], float(d[1]), float(d[2]));
}
