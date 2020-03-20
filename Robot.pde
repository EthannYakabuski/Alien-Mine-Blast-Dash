class Robot extends Enemy {
  
  
  //100 health
  //20 attack
  
  
  //for testing spawns a flower (0,0)
  Robot() {
    super(150, 3, 0, 0, 0, 0, "Robot", 25);
  }
  
  
  //for when the location is specified
  Robot(float x, float y) {
    super(150, 3, x, y, x/20, y/20, "Robot", 25);
  }
  
  
  
  
}
