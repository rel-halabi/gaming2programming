Name name;
int score;

void setup()
{
  size(500,500);
  name = new Name(width/2-100, height/2 - 100, 50);
}

void draw()
{
  background(255);
  displayScores("scoreBoard.json", "scores");
  push();
  fill(0);
  textSize(50);
  text(score, width/2 + 100 - textWidth(str(score))/2, height/2-100);
  name.draw();
  pop();
}

void keyPressed() 
{
  if (keyCode == UP) 
  {
    score += 100;
  }
  if (keyCode == DOWN && score > 0)
  {
    score -= 100;
  }
  if (key == ' ')
  {
    saveData(name.initials, score, "scoreBoard.json", "scores");
  }
  name.selecting();
}




void saveData(String initials, int score, String fileName, String arrayName) 
{
  JSONObject json = loadJSONObject(fileName);
  JSONArray scores = json.getJSONArray(arrayName);
  JSONObject finalEntry = new JSONObject();
  JSONArray finalArray = scores;
  finalEntry.setString("name", initials);
  finalEntry.setInt("value", score);
  for(int i = 0; i < finalArray.size(); i++) // Goes through each item in the array
  { 
    JSONObject tValue = finalArray.getJSONObject(i);
    if (tValue.getInt("value") < finalEntry.getInt("value")) // Checking if current score is greater than score at index
    { 
       for(int j = finalArray.size()-1; j >= i; j--) // If it is then it shifts all the scores from the current index to the size of the array down by one
       {
         JSONObject store = finalArray.getJSONObject(j);
         finalArray.setJSONObject(j+1, store);
         println(j);
       }
       finalArray.setJSONObject(i, finalEntry);  // Sets the current score to the index
       break;                                    // Breaks because already found score lower than current score, no need to search further
    }
  }
 
  json.setJSONArray(arrayName, finalArray);
  saveJSONObject(json, fileName);
}

void displayScores(String fileName, String arrayName)
{
  JSONObject json = loadJSONObject(fileName);
  JSONArray scores = json.getJSONArray(arrayName);
  push();
  noStroke();
  fill(0,0,0,120);
  rect(width/2-100, height/2, 200, height/2);
  pop();
  for (int i = 0; i < 10; i++)
  {
    JSONObject entry = scores.getJSONObject(i);
    text(entry.getString("name") + " " + entry.getInt("value"), width/2 - (textWidth(entry.getString("name") + " " + entry.getInt("value"))/2), height/2+15 + 25*i);
  }
  
}
