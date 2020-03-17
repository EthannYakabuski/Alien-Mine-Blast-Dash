class Weapon {
  
  //need to add reload time, shoot delay for shotgun
  
 String tier = "null"; 
 String name = "null";
 String className = "null";
 int maxDamage = 0; 
 int minDamage = 0; 
 int ammo; 
 int clipSize;
 int colour; 
 int durability; 
 
 boolean buildable; 
 int cost; 
 int range; 
 
 Weapon() {
   
 }
 
 Weapon(String t, String n, int max, int min, boolean build, int c, int r, int a, int clip, int col, String classN) {
  tier = t; 
  name = n; 
  maxDamage = max; 
  minDamage = min; 
  buildable = build; 
  cost = c; 
  range = r; 
  ammo = a;
  clipSize = clip;
  colour = col;
  className = classN;
 }
 
 //setters
 void setTier(String t) {
   tier = t; 
 }
 
 void setName(String n) {
   name = n;
 }
 
 void setMaxDamage(int max) {
   maxDamage = max; 
 }
 
 void setMinDamage(int min) {
   minDamage = min; 
 }
 
 void setBuildable(boolean b) {
    buildable = b; 
  }
 
 //getters
 String getTier() {
   return tier; 
 }
 
 String getName() {
   return name; 
 }
 
 int getMaxDamage() {
   return maxDamage; 
 }
 
 int getMinDamage() {
   return minDamage; 
 }
 
 int getCost() {
   return cost; 
 }
 
 boolean getBuildable() {
   return buildable; 
 }
 
 
}
