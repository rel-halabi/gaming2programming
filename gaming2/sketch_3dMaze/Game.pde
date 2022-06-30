import processing.sound.*;

class Game
{
  SoundFile music;
  PImage[] gif = new PImage[180];
  PImage title;
  int stage;
  Player p;
  int startTime;
  int score;
  int gifTime = 0;
  int gifIndex = 0;
  boolean playmusic;
  
  Game(PApplet t, int stage)
  {
    this.stage = stage;
    p = new Player(30, 16);
    startTime = millis();
    initGif();
    title = loadImage("titlePng.png");
    music = new SoundFile(t, "doomMusic.mp3");
    music.stop();
    playmusic = false;
    println("constructed");
  }

  void initGif()
  {
    for(int i = 0; i < 180; i++)
    {
      if(i < 10) gif[i] = loadImage("gif/frame_00" + i + "_delay-0.03s.jpg");
      else if (i < 100) gif[i] = loadImage("gif/frame_0" + i + "_delay-0.03s.jpg");
      else gif[i] = loadImage("gif/frame_" + i + "_delay-0.03s.jpg");
    }
  }
  
  void playGif()
  {
    if(gifIndex >= 180) gifIndex = 0;
    image(gif[gifIndex], 0, 0, width, height);
    if(millis() - gifTime > 30)
    {
      gifIndex += 1;
      gifTime = millis();
    }
  }
  

  void display()
  {
    if(!music.isPlaying() && playmusic) music.loop();
    else if (!playmusic) music.stop();
    
    if(stage < 1)
    {
      playGif();
      startScreen();
      music.stop();
      playmusic = false;
    }
    else if(stage < 2)
    {
      instructions();
      music.stop();
      startTime = millis();
    }
    else if(stage < 5)
    {
      playmusic = true;
      runGame();
      updateTime();
    }
    else
    {
      endScreen();
    }
  }
  
  void startScreen()
  {
    //background(0);
    push();
    textSize(width/20);
    text("Play", width/2 -textWidth("Play")/2, 3*height/5);
    imageMode(CENTER);
    image(title, width/2, height/3);
    pop();
  }
  
  void instructions()
  {
    background(0);
    push();
    textSize(width/10);
    text("How To Play:", width/2 - textWidth("How To Play:")/2, height/4);
    textSize(width/50);
    text("You will navigate a series of mazes with the goal of clearing all of them in as little time as possible",
    width/2 - textWidth("You will navigate a series of mazes with the goal of clearing all of them in as little time as possible")/2, height/3);
    text("You will start at the red square and will try to find your way to the green square",
    width/2 - textWidth("You will start at the red square and will try to find your way to the green square")/2, height/3 + height/25);
    text("Use 'a' and 'd' to turn the camera and 'w' and 's' to move backwards and forwards",
    width/2 - textWidth("Use 'a' and 'd' to turn the camera and 'w' and 's' to move backwards and forwards")/2, height/3 + 2*height/25);
    textSize(width/20);
    text("Play", width/2 - textWidth("Play")/2, height/2 + 3*height/25);
    pop();
  }
  
  void endScreen()
  {
    background(0);
    push();
    textSize(50);
    text("You Win!",
    width/2 - textWidth("You Win!")/2, height/3);
    textSize(25);
    text("Time: ",
    width/2 - textWidth("Time: ")/2, height/3 + height/25);
    text((score/60) + ":" + (score%60),
    width/2 - textWidth((score/60) + ":" + (score%60))/2, height/3 + 2*height/25);
    pop();
  }
  
  void runGame()
  {
    push();
    noStroke();
    fill(10, 150, 255);
    rect(0, 0, width, height/2);
    fill(100, 150, 0);
    rect(0, height/2, width, height/2);
    pop();
    p.raycast(width);
    displayScore();
  }
  
  void displayScore()
  {
    push();
    fill(0);
    textSize(width/40);
    noStroke();
    rect(width/100, height/35, textWidth("Map: " + (stage-1)) + width/100, width/35);
    rect(width/100, 2*height/15, textWidth("Score: " + score) + width/100, width/35);
    fill(255);
    text("Time: " + score, width/80, 2*height/15 + width/45);
    text("Map: " + (stage-1), width/80, height/15);
    pop();
  }
  
  PVector getWinCoord(int[][] map)
  {
    PVector p = null;
    for(int i = 0; i < 32; i++)
    {
      for(int j = 0; j < 32; j++)
      {
        if(map[i][j] == 3)
        {
          p = new PVector(i, j); break;
        }
      }
    }
    
    return p;
  }
  
  float manhattanDist(float x1, float y1, float x2, float y2)
  {
    return abs(x2-x1)+abs(y2-y1);
  }
  
  boolean checkWin(int x, int y)
  {
    PVector w = getWinCoord(p.map);
    //println(manhattanDist(x, y, w.x, w.y));
    if(manhattanDist(x, y, w.x, w.y) < 2) return true;
    
    return false;
  }
  
  void updateMap()
  {
    switch(stage)
    {
      case 3: p.map = map2; p.vPos.set(16, 30); break;
      case 4: p.map = map3; p.vPos.set(1, 17); break;
      default: p.map = map1; break;
    }
  }
  
  void updateTime()
  {
    score = (millis() - startTime) / 1000;
  }
  
  void keyPressed()
  {
    if(stage > 1 && stage < 5)
    {
      p.keyPressed();
    }
    else if (stage < 5 && key == 'z') stage++; 
    int x = int(p.vPos.x);
    int y = int(p.vPos.y);
    if(checkWin(x, y) && stage < 5)
    {
      stage++;
      updateMap();
    }
    if(key == 'c') 
    {
      playmusic = false;
      music.stop();
      setup();
    }
  }
}
