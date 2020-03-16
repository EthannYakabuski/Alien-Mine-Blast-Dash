class Ant extends Enemy {
  
  
  //100 health
  //20 attack
  
  
  //for testing spawns an ant (0,0)
  Ant() {
    super(100, 20, 0, 0, 0, 0, "Ant");
  }
  
  
  //for when the location is specified
  Ant(float x, float y) {
    super(100, 20, x, y, x/20, y/20, "Ant");
  }
  
  //the ants movement algorithm specifically
  
  //receive damage
  void receiveDamage(int damage) {
    
    super.receiveDamage(damage);
    
  }
 
  
}
