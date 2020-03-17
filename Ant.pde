class Ant extends Enemy {
  
  
  //100 health
  //20 attack
  
  
  //for testing spawns an ant (0,0)
  Ant() {
    super(100, 1, 0, 0, 0, 0, "Ant", 10);
  }
  
  
  //for when the location is specified
  Ant(float x, float y) {
    super(100, 1, x, y, x/20, y/20, "Ant", 10);
  }
  
  //the ants movement algorithm specifically
  
  
}
