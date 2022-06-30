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
