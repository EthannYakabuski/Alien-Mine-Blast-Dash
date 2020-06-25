class Phalax extends Enemy {
  
   PImage[] images = new PImage[3];
  
  //100 health
  //20 attack
  
  
  //for testing spawns a Phalax (0,0)
  Phalax() {
    super(2000, 20, 0, 0, 0, 0, "Phalax", 250);
    
    images[0] = loadImage("phalax.png");
    
    
    images[0].resize(100,100);
  }
  
  
  //for when the location is specified
  Phalax(float x, float y) {
    super(2000, 20, x, y, x/20, y/20, "Phalax", 250);
    
    images[0] = loadImage("phalax.png");
    
    
    images[0].resize(100,100);
  }
  
  void show() {
    
    image(images[0], this.xC, this.yC);
    
  }
  
  
  //issue: incoming targetX, targetY is in index, not graphics amount
  void move(int targetX, int targetY) {
      
      //make targetX and targetY into the graphics coordinate not index
      targetX = targetX*20; 
      targetY = targetY*20;
    
      //accidentaly switched them somewhere along the line
      int temp = targetY; 
      targetY = targetX; 
      targetX = temp;
      
      
      int myLocX = (int)this.xC; 
      int myLocY = (int)this.yC;
      
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
          
             this.xC = this.xC+40; 
             this.yC = this.yC+40;
        
             this.indexI = this.indexI+2; 
             this.indexJ = this.indexJ+2;
            
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
          
            this.xC = this.xC+40; 
            this.yC = this.yC-40;
        
            this.indexI = this.indexI+2; 
            this.indexJ = this.indexJ-2; 
            
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
          
            this.xC = this.xC-40; 
            this.yC = this.yC-40;
        
            this.indexI = this.indexI-2; 
            this.indexJ = this.indexJ-2; 
         
            
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
          
             this.xC = this.xC-40; 
             this.yC = this.yC+40;
        
             this.indexI = this.indexI-2; 
             this.indexJ = this.indexJ+2; 
        
         
            
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
          
              
             this.yC = this.yC+40;
             this.indexJ = this.indexJ+2; 
        
         
            
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
          
              
             this.yC = this.yC-40;
             this.indexJ = this.indexJ-2; 
        
         
            
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
          
              
             this.xC = this.xC+40;
             this.indexI = this.indexI+2; 
        
         
            
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
          
              
             this.xC = this.xC - 40;
             this.indexI = this.indexI-2; 
        
         
            
          //if the target is close, take shots   
          } else {
            
            this.needToShoot = true;
            
            
          }
        
        
        
      }
      
     
    }
    
}
    
  
  
  
