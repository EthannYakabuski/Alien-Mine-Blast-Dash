class Armor {
  
  String tier = "null"; 
  String name = "null";
  boolean buildable; 
  int cost; 
  int armorValue = 0;
  int colour; 
  
  Armor() {
    
  }
  
  Armor(String t, String n, boolean build, int c, int aV, int col) {
  tier = t; 
  name = n; 
  buildable = build; 
  cost = c; 
  armorValue = aV;
  colour = col;
 }
 
 //getters 
  void setTier(String t) {
    tier = t; 
  }
 
  void setName(String n) {
    name = n;
  }
 
  void setBuildable(boolean b) {
    buildable = b; 
  }
  
  //setters
  int getCost() {
    return cost; 
  }
  
  boolean getBuildable() {
    return buildable; 
  }
 
  
}
