class Player {
 
  float xC;
  float yC;
  float xSpeed;
  
  int indexI;
  int indexJ;
  
  int score = 0; 
  
  int goldAmount =100; 
  int ironAmount =200; 
  int woodAmount =200;
  int active = 0;
  
  Tile activeTile;
  Armor activeArmor; 
  
  Weapon activeTommy; 
  Weapon activeShotgun; 
  
  int health = 200;
  int shield = 00;
  
  Player() {
    xC = 10;
    yC = 10;
    xSpeed = 0;
    this.startLoc();
  }
  
  //setters START
  void setXC(float x_coor) {
    xC = x_coor;
  }
  void setYC(float y_coor) {
    yC = y_coor;
  }
  void setXSpeed(float s) {
    xSpeed = s;
  }
  
  void setScore(int s) {
    score = s; 
  }
  
  void setHealth(int h) {
    health = h; 
  }
  
  void addGold(int g) {
    goldAmount = goldAmount + g;
  }
  
  void addIron(int i) {
    ironAmount = ironAmount + i; 
  }
  
  void addWood(int w) {
    woodAmount = woodAmount + w; 
  }
  
  void setTile(Tile t) {
    activeTile = t;
  }
  
  void setWeapons(Weapon t, Weapon s) {
    activeTommy = t; 
    activeShotgun = s; 
  }
  
  void setTommy(Weapon t) {
    activeTommy = t; 
  }
  
  void setShotgun(Weapon s) {
    activeShotgun = s; 
  }
  
  int getXC() {
    return indexI; 
  }
  
  int getYC() {
    return indexJ; 
  }
  
  int getWoodAmount() {
    return woodAmount; 
  }
  
  int getIronAmount() {
    return ironAmount; 
  } 
  
  int getGoldAmount() {
    return goldAmount; 
  }
  
  Weapon getTommy() {
    return activeTommy;
  }
  
  
  //setters END
  
  //getters START
  int getHealth() {
    return health; 
  }
  int getShield() {
    return shield;
  }
  Tile getCurrentTile() {
    return activeTile;
  }
  
  
  //getters END
  
  void reset() {
  
    score = 0; 
  
    goldAmount =100; 
    ironAmount =200; 
    woodAmount =200;
    active = 0;
  
    health = 200;
    shield = 0;
    
    this.startLoc();
    
  }
  
  void startLoc() {
    Random r = new Random();
    int streamSize = 2800; 
    int start = 0; 
    int bound = 2799; 
     
    r.ints(streamSize, start, bound);
    
    int i = r.nextInt(39);
    int j = r.nextInt(69);
    
    indexI = i; 
    indexJ = j;
    
    //println("i =" + i);
    //println("j =" + j);
    
    //*1.1
    xC = j*20+10; 
    yC = i*20+10;
  }
  
  void display() {
   rectMode(CENTER);
   //fill(255,156,82);
   //rect(xC,yC,20,20);
    
  }
  
  void improveWeapon(Weapon w) {
    if(w.className.equals("Tommy")) {
      println("Upgrading tommy gun"); 
    } else if (w.className.equals("Shotgun")) {
      println("Upgrading shotgun");
    }
  }
  
  //handles WASD movement
  void keyHandler(String key) {
    
    println("indexI before movement: " + indexI); 
    println("indexJ before moevement: " + indexJ);
    
    String forward = "w";
    String left = "a";
    String down = "s";
    String right = "d";
    
    String hotkeyOne = "1"; 
    String hotkeyTwo = "2"; 
    String hotkeyThree = "3"; 
    String hotkeyFour = "4"; 
    String hotkeyFive = "5"; 
    
    if(forward.equals(key)) {
      //top of the screen boundary
      if(indexI - 1 >= 0) {
        setYC(yC-20);
      }
    } else if (left.equals(key)) {
      //left side screen boundary
      if(indexJ - 1 >= 0) {
        setXC(xC-20);
      }
    } else if (down.equals(key)) {
      //bottom of the screen boundary
      if(indexI + 1 < 40) {
        setYC(yC+20);
      }
    } else if (right.equals(key)) {
      //right side screen boundary
      if(indexJ + 1 < 70) {
        setXC(xC+20);
      }
      
    } else if (hotkeyOne.equals(key)) {
      active = 1;
    } else if (hotkeyTwo.equals(key)) {
      active = 2;
    } else if (hotkeyThree.equals(key)) {
      active = 3;
    } else if (hotkeyFour.equals(key)) {
      active = 4;
    } else if (hotkeyFive.equals(key)) {
      //active = 5;
      this.drinkPotion();
    }
    
    indexI = (int)yC/20;
    indexJ = (int)xC/20;
    
    println("indexI after movement: " + indexI); 
    println("indexJ after movement: " + indexJ);
    
  }
  
  void drinkPotion() {
    
    this.health = this.health + 50; 
    if(this.health > 200) { this.health = 200; }
    
    
  }
  
  boolean takeDamage(int i) {
    
    int leftover = 0; 
    
    //if the amount of damage being received is more than the available shields of the player
    if(i > this.shield) {
      
      //calculate leftover and set shields to 0
      leftover = i - this.shield;
      this.shield = 0;
      
      //rest of the damage to the health
      this.health = this.health - leftover; 
      
    //the amount of damage being received will only affect the players shields
    } else if (i <= this.shield) {
      
      //remove the damage
      this.shield = this.shield - i;
      
    }
    
    return checkDeath();
    
  }
  
  boolean checkDeath() {
    
    if(0 >= this.health) { 
      return true;
    } else {
      return false; 
    }
    
  }
  
  void applyArmor(int i) {
     println("Applying armor to player");  
     
     //wood can restore a player to a maximum of 100 shield
     //wood restores 50 shield at a time
     if(i == 1 && woodAmount >= 100) {
       println("Applying wood"); 
       if(shield <= 50) { 
         shield += 50; 
         woodAmount = woodAmount - 100;
       } else if (shield > 51 && shield < 100) {
         shield = 100; 
         woodAmount = woodAmount - 100;
       } else {
         println("You cannot heal any further with wood"); 
       }
       
     //iron can restore a player to a maximum of 150 shield
     //iron restores 100 shield at a time
     } else if (i == 2 && ironAmount >= 100) {
       println("Applying iron"); 
       if(shield <= 50) {
         shield += 100;
         ironAmount = ironAmount - 100;
       } else if (shield >51 && shield < 150) {
         shield = 150; 
         ironAmount = ironAmount - 100;
       } else {
         println("You cannot heal any further with iron"); 
       }
       
     //gold can restore a player to a maximum of 200 shield
     //gold restores 200 shield at a time
     } else if (i == 3 && goldAmount >= 100) {
       println("Applying gold"); 
       shield += 200; 
       goldAmount = goldAmount - 150;
       if (shield > 200) {
         shield = 200; 
       }
       
     }
  }
  
  
}

/*

1.1
using the array index, the squares location can be found on screen by multiplying by 20 (for the block size) and adding 10 (a pixel offset)




*/
