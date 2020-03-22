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
  
  int flowerFlop = 0;
  
  boolean status = true; 
  boolean needToShoot = false;
  
  //enemy will move differently when playing in a swarm
  boolean intelligenceApplied = false; 
  
  
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
  
  boolean getShotExpulsion() {
    return needToShoot; 
  }
  
  boolean getIntelligence() {
    return intelligenceApplied; 
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
  
  int getAttack() {
    return attack; 
    
  }
  
  void setIntelligence(boolean i) {
    intelligenceApplied = i;
    
  }
  
  void setNeedToShoot(boolean b) {
    this.needToShoot = b; 
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
  
  boolean dealDamage(Player p) {
    if(status) {
      boolean death = p.takeDamage(attack);
      return death;
    }
    return false;
  }
  
  //issue: incoming targetX, targetY is in index, not graphics amount
  void move(int targetX, int targetY) {
    
    
    if(this.status) {
      flowerFlop = flowerFlop + 1;
      
      //make targetX and targetY into the graphics coordinate not index
      targetX = targetX*20; 
      targetY = targetY*20;
    
      //accidentaly switched them somewhere along the line
      int temp = targetY; 
      targetY = targetX; 
      targetX = temp;
    
      //System.out.println("Moving");
      
      //System.out.println("this.enemyType: " + this.enemyType);
    
    
      //movement algorithm for the ant enemy type
      if(this.enemyType == "Ant") { 
      
        int myLocX = (int)this.xC; 
        int myLocY = (int)this.yC;
      
        //System.out.println("MyLocX: " + myLocX); 
        //System.out.println("MyLocY: " + myLocY); 
        //System.out.println("TargetX: " + targetX); 
        //System.out.println("TargetY: " + targetY); 
      
      
        if( (targetX > myLocX)&(targetY > myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 1"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC+20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ+1; 
        
        } else if ( (targetX > myLocX)&(targetY<myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 2"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ-1; 
        
        } else if ( (targetX < myLocX)&(targetY < myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 3"); 
        
          this.xC = this.xC-20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI-1; 
          this.indexJ = this.indexJ-1; 
        
      } else if ( (targetX < myLocX)&(targetY > myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 4"); 
        
        this.xC = this.xC-20; 
        this.yC = this.yC+20;
        
        this.indexI = this.indexI-1; 
        this.indexJ = this.indexJ+1; 
        
      } else if ( (targetX == myLocX)&(targetY > myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 5");
        
        this.yC = this.yC+20; 
        
        this.indexJ = this.indexJ+1; 
        
      } else if ( (targetX == myLocX)&(targetY < myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 6");
        
        this.yC = this.yC-20; 
        
        this.indexJ = this.indexJ-1; 
        
      } else if ( (targetX > myLocX)&(targetY == myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 7"); 
        
        this.xC = this.xC+20;
        
        this.indexI = this.indexI+1; 
        
      } else if ( (targetX < myLocX)&(targetY == myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 8"); 
        
        this.xC = this.xC-20; 
        
        this.indexI = this.indexI-1; 
        
      }
      
      
      //movement algorithm for the flower enemy type
    } else if (this.enemyType == "Flower") {
      
      //flower moves half as fast as the ants
      if(0 == (flowerFlop%2)) {
      
        int myLocX = (int)this.xC; 
        int myLocY = (int)this.yC;
        
        //System.out.println("MyLocX: " + myLocX); 
        //System.out.println("MyLocY: " + myLocY); 
        //System.out.println("TargetX: " + targetX); 
        //System.out.println("TargetY: " + targetY);
        
        /* 1
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxTxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
        if( (targetX > myLocX)&(targetY > myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 1"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC+20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ+1; 
        
        
        
        /* 2
        xxxxxxxxxxx
        xxxxxxxxxTx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
        } else if ( (targetX > myLocX)&(targetY<myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 2"); 
        
          this.xC = this.xC+20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI+1; 
          this.indexJ = this.indexJ-1; 
        
        
        /* 3
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxMxx
        xxxxxxxxxxx
        */
        } else if ( (targetX < myLocX)&(targetY < myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 3"); 
        
          this.xC = this.xC-20; 
          this.yC = this.yC-20;
        
          this.indexI = this.indexI-1; 
          this.indexJ = this.indexJ-1; 
        
        
        /* 4
        xxxxxxxxxxx
        xxxxxxxxMxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX < myLocX)&(targetY > myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 4"); 
        
        this.xC = this.xC-20; 
        this.yC = this.yC+20;
        
        this.indexI = this.indexI-1; 
        this.indexJ = this.indexJ+1; 
        
        
        /* 5
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxTxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX == myLocX)&(targetY > myLocY) ) {
        
        //flower shoots down the lane
        System.out.println("Flower shooting");
        
        this.needToShoot = true;
        
        /* 6
        xxxxxxxxxxx
        xxxxTxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX == myLocX)&(targetY < myLocY) ) {
        
        //flower shoots up the lane
        System.out.println("Flower shooting");
        
        this.needToShoot = true;
        
        /* 7
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxMxxxxxTxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX > myLocX)&(targetY == myLocY) ) {
        
        //flower shoots the the right horizontally
        System.out.println("Flower shooting");
        
        this.needToShoot = true;
        
        /* 8
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxMxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX < myLocX)&(targetY == myLocY) ) {
        
        //flower shoot to the left horizontally
        System.out.println("Flower shooting");
        
        this.needToShoot = true;
      }
      
      
    } //flower movement done here
    
    //movement algorithm for the robot
    } else if (this.enemyType == "Robot") {
      
      System.out.println("Robot MOVING");
      
      int myLocX = (int)this.xC; 
        int myLocY = (int)this.yC;
        
        //System.out.println("MyLocX: " + myLocX); 
        //System.out.println("MyLocY: " + myLocY); 
        //System.out.println("TargetX: " + targetX); 
        //System.out.println("TargetY: " + targetY);
        
        /* 1
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxTxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
        if( (targetX > myLocX)&(targetY > myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 1"); 
          
          int xDifference = (int)(targetX - myLocX)/20;
          int yDifference = (int)(targetY - myLocY)/20;
          
          if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
          int totalDifference = xDifference + yDifference; 
          
          //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
             this.xC = this.xC+20; 
             this.yC = this.yC+20;
        
             this.indexI = this.indexI+1; 
             this.indexJ = this.indexJ+1;
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
          
     
        /* 2
        xxxxxxxxxxx
        xxxxxxxxxTx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
        } else if ( (targetX > myLocX)&(targetY<myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 2"); 
          int xDifference = (int)(targetX - myLocX)/20;
          int yDifference = (int)(targetY - myLocY)/20;
          
          if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
          int totalDifference = xDifference + yDifference; 
          
          //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
            this.xC = this.xC+20; 
            this.yC = this.yC-20;
        
            this.indexI = this.indexI+1; 
            this.indexJ = this.indexJ-1; 
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
          
        
        /* 3
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxMxx
        xxxxxxxxxxx
        */
        } else if ( (targetX < myLocX)&(targetY < myLocY) ) {
        
          //System.out.println("TOOK A STEP FOR REAL 3"); 
          
          
          int xDifference = (int)(targetX - myLocX)/20;
          int yDifference = (int)(targetY - myLocY)/20;
          
          if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
          int totalDifference = xDifference + yDifference; 
          
          //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
            this.xC = this.xC-20; 
            this.yC = this.yC-20;
        
            this.indexI = this.indexI-1; 
            this.indexJ = this.indexJ-1; 
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        
        
        /* 4
        xxxxxxxxxxx
        xxxxxxxxMxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX < myLocX)&(targetY > myLocY) ) {
        
        //System.out.println("TOOK A STEP FOR REAL 4"); 
        
         int xDifference = (int)(targetX - myLocX)/20;
         int yDifference = (int)(targetY - myLocY)/20;
         
         if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
         int totalDifference = xDifference + yDifference; 
          
        
        //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
             this.xC = this.xC-20; 
             this.yC = this.yC+20;
        
             this.indexI = this.indexI-1; 
             this.indexJ = this.indexJ+1; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        

        /* 5
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxTxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX == myLocX)&(targetY > myLocY) ) {
        
         int xDifference = (int)(targetX - myLocX)/20;
         int yDifference = (int)(targetY - myLocY)/20;
         
         if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
         int totalDifference = xDifference + yDifference; 
          
        
        //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
              
             this.yC = this.yC+20;
             this.indexJ = this.indexJ+1; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        
        
       
        
        /* 6
        xxxxxxxxxxx
        xxxTxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxMxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX == myLocX)&(targetY < myLocY) ) {
        
        int xDifference = (int)(targetX - myLocX)/20;
         int yDifference = (int)(targetY - myLocY)/20;
         
         if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
         int totalDifference = xDifference + yDifference; 
          
        
        //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
              
             this.yC = this.yC-20;
             this.indexJ = this.indexJ-1; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
      
       
        
        /* 7
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxMxxxxxTxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX > myLocX)&(targetY == myLocY) ) {
        
        int xDifference = (int)(targetX - myLocX)/20;
         int yDifference = (int)(targetY - myLocY)/20;
         
         if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
         int totalDifference = xDifference + yDifference; 
          
        
        //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
              
             this.xC = this.xC+20;
             this.indexI = this.indexI+1; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        
        
       
        
        /* 8
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxTxxxxxMxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        xxxxxxxxxxx
        */
      } else if ( (targetX < myLocX)&(targetY == myLocY) ) {
        
         int xDifference = (int)(targetX - myLocX)/20;
         int yDifference = (int)(targetY - myLocY)/20;
         
         if(xDifference < 0) {
            xDifference = xDifference*-1; 
          }
          
          if(yDifference < 0) {
            yDifference = yDifference*-1; 
          }
          
         int totalDifference = xDifference + yDifference; 
          
        
        //if the target is somewhat far away, move towards them
          if(totalDifference >=  10) {
          
              
             this.xC = this.xC - 20;
             this.indexI = this.indexI-1; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        
        
        
      }
      
      
    }
    
    }
    
    
    
  }
  
  
 
  void die() {
    System.out.println("Dying"); 
    status = false; 
  }
  
  
}
