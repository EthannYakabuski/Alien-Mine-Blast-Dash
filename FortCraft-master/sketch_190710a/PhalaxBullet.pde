class PhalaxBullet {
  
  float speedX; 
  float speedY;
  
  int speedXMultiple; 
  int speedYMultiple; 
  int size; 
  
  float xCoor; 
  float yCoor; 
  
  int damage; 
  
  boolean status = true;
  
  PhalaxBullet() {
    speedX = 0; 
    speedY = 0;
    speedXMultiple = 5;
    speedYMultiple = 5;
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
  
  void setXC(int xc) {
    xCoor = xc; 
  }
  
  void setYC(int yc) {
    yCoor = yc; 
  }
  
  int getDamage() { 
    return damage; 
  }
  
  int getSpeedX() {
    return (int)speedX;  
  }
  
  int getSpeedY() {
    return (int)speedY; 
  }
  
  int getXC() {
    return (int)xCoor; 
  }
  
  int getYC() {
    return (int)yCoor; 
  }
  
  int getSize() {
    return size; 
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
  
  PhalaxBullet(float spX, float spY, int sze, int x, int y, int d) {
    speedX = spX;
    speedY = spY; 
    size = sze; 
    xCoor = x; 
    yCoor = y; 
    damage = d;
  }
  
}
