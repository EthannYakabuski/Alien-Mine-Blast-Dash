abstract class Enemy {
  
  int health; 
  int attack; 
  
  float xC;
  float yC;
  
  float indexI;
  float indexJ;
  
  int score; 
  
  String enemyType; 
  
  int id; 
  
  boolean status = true; 
  
  Enemy() {
    
    
  }
  
  Enemy(int h, int a, float coorX, float coorY, float iI, float iJ, String eT, int sc) {
    health = h; 
    attack = a; 
    xC = coorX; 
    yC = coorY; 
    indexI = iI; 
    indexJ = iJ; 
    enemyType = eT;
    status = true;
    score = sc;
  }
  
  String getEnemyType() {
    return enemyType;  
  }
  
  int getScore() {
    return score; 
  }
  
  float getXC() {
    return xC; 
  }
  
  float getYC() {
    return yC; 
  }
  
  boolean receiveDamage(int damage) {
    
    //take the damage off the the enemies health
    this.health = this.health - damage; 
    
    System.out.println("Enemies current health: " + this.health);
    
    //if this enemy has died
    if(this.health <= 0) {
      //trigger the death function
      this.status = false;
      
      return true;
    }
    
    return false;
    
  }
  
  void dealDamage(Player p) {
    if(status) {
      p.takeDamage(attack);
    }
    
  }
  
  //issue: incoming targetX, targetY is in index, not graphics amount
  void move(int targetX, int targetY) {
    
    if(this.status) {
      //make targetX and targetY into the graphics coordinate not index
      targetX = targetX*20; 
      targetY = targetY*20;
    
      //accidentaly switched them somewhere along the line
      int temp = targetY; 
      targetY = targetX; 
      targetX = temp;
    
      System.out.println("Moving");
    
      if(this.enemyType == "Ant") { 
      
        int myLocX = (int)this.xC; 
        int myLocY = (int)this.yC;
      
        //System.out.println("MyLocX: " + myLocX); 
        //System.out.println("MyLocY: " + myLocY); 
        //System.out.println("TargetX: " + targetX); 
        //System.out.println("TargetY: " + targetY); 
      
      
        if( (targetX > myLocX)&(targetY > myLocY) ) {
        
          System.out.println("TOOK A STEP FOR REAL 1"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC+20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ+1; 
        
        } else if ( (targetX > myLocX)&(targetY<myLocY) ) {
        
          System.out.println("TOOK A STEP FOR REAL 2"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ-1; 
        
        } else if ( (targetX < myLocX)&(targetY < myLocY) ) {
        
          System.out.println("TOOK A STEP FOR REAL 3"); 
        
          this.xC = this.xC-20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI-1; 
          this.indexJ = this.indexJ-1; 
        
      } else if ( (targetX < myLocX)&(targetY > myLocY) ) {
        
        System.out.println("TOOK A STEP FOR REAL 4"); 
        
        this.xC = this.xC-20; 
        this.yC = this.yC+20;
        
        this.indexI = this.indexI-1; 
        this.indexJ = this.indexJ+1; 
        
      } else if ( (targetX == myLocX)&(targetY > myLocY) ) {
        
        System.out.println("TOOK A STEP FOR REAL 5");
        
        this.yC = this.yC+20; 
        
        this.indexJ = this.indexJ+1; 
        
      } else if ( (targetX == myLocX)&(targetY < myLocY) ) {
        
        System.out.println("TOOK A STEP FOR REAL 6");
        
        this.yC = this.yC-20; 
        
        this.indexJ = this.indexJ-1; 
        
      } else if ( (targetX > myLocX)&(targetY == myLocY) ) {
        
        System.out.println("TOOK A STEP FOR REAL 7"); 
        
        this.xC = this.xC+20;
        
        this.indexI = this.indexI+1; 
        
      } else if ( (targetX < myLocX)&(targetY == myLocY) ) {
        
        System.out.println("TOOK A STEP FOR REAL 8"); 
        
        this.xC = this.xC-20; 
        
        this.indexI = this.indexI-1; 
        
      }
      
      
    }
    }
    
    
    
  }
  
  void die() {
    System.out.println("Dying"); 
    status = false; 
  }
  
  
}
