class ElectroDuo extends Enemy {
  
  
  //100 health
  //20 attack
  
  PImage[] images = new PImage[3];
  
 
  ElectroDuo() {
    super(500, 10, 0, 0, 0, 0, "ElectroDuo", 25);
    
    images[0] = loadImage("electroDuo.JPG");
    images[1] = loadImage("electroDuo75.JPG"); 
    images[2] = loadImage("electroDuo50.JPG");
  
    images[0].resize(40,40);
    images[1].resize(40,40);
    images[2].resize(40,40);
  }
  
  
  //for when the location is specified
  ElectroDuo(float x, float y) {
    super(500, 10, x, y, x/20, y/20, "ElectroDuo", 25);
    
    images[0] = loadImage("electroDuo.JPG");
    images[1] = loadImage("electroDuo75.JPG"); 
    images[2] = loadImage("electroDuo50.JPG");
  
    images[0].resize(40,40);
    images[1].resize(40,40);
    images[2].resize(40,40);
  }
  
  
   void show() {
    
      if(this.health > 75) {
        image(images[0], this.xC, this.yC);
      } else if ( (this.health <= 75) & (this.health > 50)) {
        image(images[1], this.xC, this.yC);  
      } else if(this.health <= 50 & (this.health > 0)) {
        image(images[2], this.xC, this.yC);
      } else if(this.health <= 0) {
        this.die();
      }
    
    
  }
  
  void move(int targetX, int targetY) {
    this.flowerFlop = this.flowerFlop + 1; 
    
    //make targetX and targetY into the graphics coordinate not index
    targetX = targetX*20; 
    targetY = targetY*20;
    
    //accidentaly switched them somewhere along the line
    int temp = targetY; 
    targetY = targetX; 
    targetX = temp;
      
      
    int myLocX = (int)this.xC; 
    int myLocY = (int)this.yC;
    
    
    if(0 == (flowerFlop%2)) {
      
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
     
      
    }
    
    
  }
  
}
