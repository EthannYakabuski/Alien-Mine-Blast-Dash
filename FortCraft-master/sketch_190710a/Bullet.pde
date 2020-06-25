class Bullet {
  
  float speedX; 
  float speedY;
  
  int speedXMultiple; 
  int speedYMultiple; 
  int size; 
  int timesAnimated; 
  
  float xCoor; 
  float yCoor; 
  
  int damage; 
  String shotFrom; 
  
  boolean status = true;
  
  Bullet() {
    speedX = 0; 
    speedY = 0;
    speedXMultiple = 5;
    speedYMultiple = 5;
  }
  
  Bullet(float speedXIN, float speedYIN, int shotFromX, int shotFromY, boolean alive, int dmg, String sf) {
    speedX = speedXIN; 
    speedY = speedYIN; 
    xCoor = shotFromX;
    yCoor = shotFromY; 
    status = alive; 
    damage = dmg; 
    //System.out.println(damage); 
    shotFrom = sf; 
    
  }
  
  void setSpeedX(float sx) {
    speedX = sx*speedXMultiple; 
  }
  
  void setSpeedY(float sy) {
    speedY = sy*speedYMultiple; 
  }
  
  void setLocX(float lx) {
    xCoor = lx; 
  }
  
  void setLocY(float ly) {
    yCoor = ly; 
  }
  
  void setDamage(int d) {
    damage = d;
  }
  
  void setShotFrom(String s) {
    shotFrom = s; 
  }
  
  
  int getDamage() { 
    return damage; 
  }
  
  String getShotFrom() {
    return shotFrom; 
  }
  
  boolean getStatus() { 
    return status; 
  }
  
  //determines if the bullet is on the screen or not
  void checkStatus() {
    
    if (xCoor < 0) {
      this.status = false; 
    }
    
    if (yCoor < 0) {
      this.status = false; 
    }
    
    if (xCoor > 1400) {
      this.status = false; 
    }
    
    if (yCoor > 800) {
      this.status = false; 
    }
    
    
  }
  
  Bullet(float spX, float spY, int sze, int x, int y) {
    speedX = spX;
    speedY = spY; 
    size = sze; 
    xCoor = x; 
    yCoor = y; 
    
  }
  
}
