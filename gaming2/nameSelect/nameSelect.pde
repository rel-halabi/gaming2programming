Name n;

void setup() {
  size(500,500);
n = new Name(width/2, height/2, 100);
}

void draw() {
  background(0);
  stroke(255);
  
  
  n.draw();
}

class Name {
  int selection = 65;
  int[] result = {65, 65, 65};
  String initials = "";
  boolean wait = false;
  int time = 0;
  int index = 0;
  int x,y;
  PFont font;
  int size;
  
  Name(int x, int y, int size) {
    this.x = x;
    this.y = y;
    font = createFont("zig.ttf", 133); // Monospaced font to make my life easier with the cursor
    this.size = size;
  }
  
  void draw() {
    selecting(); // Basically my own keyPressed
    setSelection(); // Sets the index to the selection
    waiting(); // To stop the program from cycling all the way down to z or up to a when pressing button once
    setInitials(); // Sets the initials string to the result array
    drawText(); // Draws the text
    drawCursor(); // Draws the cursor
    println(result[0], result[1], result[2]); // Debug code
  }
  
  void setSelection() {
    result[index] = selection; // Sets the character at the index
  }
  
  void setInitials() {
    initials = "" + char(result[0])+char(result[1])+char(result[2]); // Final String
  }
  
  void drawText() {
    push();
    textFont(font);
    textSize(size);
    text(initials, x - (textWidth(initials)/2), y); // Draws the text
    pop();
  }
  
  void drawCursor() {
    rect((x-textWidth(initials)/2) + (textWidth(char(result[index]))*index), y + 10, textWidth(char(result[index])), 10); // Draws a cursor
    //Sets cursor to start of text, then this moves cursor based on index, basic spacing, sets width of cursor to width of char at index, basic height
  }
  
  void waiting() {
    if (wait) {
      time++;
    }
    if (time == 10) {
      wait = false;
      time = 0;
    }
  }
  
  void selecting() {
    if (keyPressed) {
      switch(key) {
        case 'w':
          if (selection > 65 && !wait) {
            selection--;
            wait = true;
          }
          break;
        case 's':
          if (selection < 65 + 25 && !wait) {
            selection++;
            wait = true;
          }
          break;   
        case 'd':
          if (index < 2 && !wait) {
            index++;
            selection = int(result[index]);
            wait = true;
          }
          break;
        case 'a':
          if (index > 0 && !wait) {
            index--;
            selection = int(result[index]);
            wait = true;
          }
          break;
      }
    } 
  }
  
}
