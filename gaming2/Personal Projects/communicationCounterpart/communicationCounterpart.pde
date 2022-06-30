Communicator c;
String message = "";

void setup()
{
  size(700,700);
  c = new Communicator("C:/Users/rel-halabi/Documents/GitHub/gaming2/Personal Projects/communication/DATA.json", 1, 0);
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

class Communicator
{
  JSONObject json;
  JSONArray members;
  int id, recipientId;
  String jsonFileName;
  
  Communicator(String jsonFileName, int id, int recipientId)
  {
    json = loadJSONObject(jsonFileName);
    members = json.getJSONArray("members");
    this.id = id;
    this.recipientId = recipientId;
    this.jsonFileName = jsonFileName;
  }
  
  void update()
  {
    json = loadJSONObject(jsonFileName);
    members = json.getJSONArray("members");
  }
  
  String getMessage()
  {
    JSONObject profile = members.getJSONObject(id);
    String message = profile.getString("message");
    
    return message;
  }
  
  void sendMessage(String message)
  {
    JSONObject recipient = members.getJSONObject(recipientId);
    recipient.setString("message", message);
    recipient.setInt("sender", id);
    members.setJSONObject(recipientId, recipient);
    saveJson();
  }
  
  void saveJson()
  {
    json.setJSONArray("members", members);
    saveJSONObject(json,"DATA.json");
  }
  
  
}
