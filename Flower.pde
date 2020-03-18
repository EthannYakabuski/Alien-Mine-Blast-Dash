class Flower extends Enemy {
  
  
  //100 health
  //20 attack
  
  
  //for testing spawns a flower (0,0)
  Flower() {
    super(100, 10, 0, 0, 0, 0, "Flower", 25);
  }
  
  
  //for when the location is specified
  Flower(float x, float y) {
    super(100, 10, x, y, x/20, y/20, "Flower", 25);
  }
  
  
  
  
}
