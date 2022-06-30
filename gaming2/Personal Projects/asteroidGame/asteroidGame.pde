Player p;
Asteroid asteroids[];
Name n;

int score;
int state;
JSONObject json;
JSONArray scores;
ArrayList<Integer> values;
ArrayList<String> names;

void setup() {
  size(700,700);
  json = loadJSONObject("scoreBoard.json");
  scores = json.getJSONArray("scores");
  values = new ArrayList<Integer>();
  names = new ArrayList<String>();
  p = new Player(width/2, height/2, 0);
  n = new Name(width/2, height/2 + 100, 100);
  asteroids = new Asteroid[5];
  asteroids[0] = new Asteroid(250, -300, width/2, height/2);
  asteroids[1] = new Asteroid(-30, -1000, width/2, height/2);
  asteroids[2] = new Asteroid(800, 1000, width/2, height/2);
  asteroids[3] = new Asteroid(30, 800, width/2, height/2);
  asteroids[4] = new Asteroid(1000, -100, width/2, height/2);
  state = 0;
  score = 0;
  
  for (int i = 0; i < scores.size(); i++) {
    JSONObject item = scores.getJSONObject(i);
    values.add(item.getInt("value"));
    names.add(item.getString("name"));
  }
  
  
}

void draw() {
  background(0);
  if (state == 0) {
    textSize(90);
    text("Asteroid Game", width/2 - textWidth("Asteroid Game")/2, height/2);
    for(int i = 0; i < 3; i++) {
      textSize(50);
      text(names.get(i) + " " + values.get(i), width/2 - textWidth(names.get(i) + " " + str(values.get(i)))/2, height/2 + (50*(i+1)) + 100);
    }
    
  }
  if (state == 1) {
    p.draw();
    for (Asteroid a : asteroids) {
      a.draw();
    }
    collision();
  }
  if (state == 2) {
    textSize(100);
    text(score*500,width/2-textWidth(str(score*500))/2,height/2);
    n.draw();
  }

}

void saveData(String initials, int score) {
  JSONObject finalEntry = new JSONObject();
  JSONArray finalArray = scores;
  finalEntry.setString("name", initials);
  finalEntry.setInt("value", score);
  for(int i = 0; i < finalArray.size(); i++) { // Goes through each item in the array
    JSONObject tValue = finalArray.getJSONObject(i);
    if (tValue.getInt("value") < finalEntry.getInt("value")) { // Checking if current score is greater than score at index
       for(int j = finalArray.size()-1; j >= i; j--) { // If it is then it shifts all the scores from the current index to the size of the array down by one
         JSONObject store = finalArray.getJSONObject(j);
         finalArray.setJSONObject(j+1, store);
         println(j);
       }
       finalArray.setJSONObject(i, finalEntry);  // Sets the current score to the index
       break;                                    // Breaks because already found score lower than current score, no need to search further
    }
  }
 
  json.setJSONArray("scores", finalArray);
  saveJSONObject(json, "scoreBoard.json");
}

void keyPressed() {
  if(key == '6' && state == 0) {
    state = 1;
  }
  if(key == 'c' && state == 2) {
    saveData(n.initials, score*500);
    setup();
  }
}

void collision() {
  for (Asteroid a : asteroids) {
    if (p.b.x - 5 < a.pos.x + (5*a.scale) && p.b.x + 5 > a.pos.x + (-9*a.scale) && p.b.y - 5 < a.pos.y + (9*a.scale) && p.b.y + 5 > a.pos.y + (-10*a.scale)) {
      if (p.shooting) {
        a.destroyed = true;
        p.shooting = false;
        score++;
      }
      else {
        state = 2;
      }
    }
    
  }
}
