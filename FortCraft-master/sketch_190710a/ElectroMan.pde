class ElectroMan extends Enemy {
  
   PImage[] images = new PImage[3];

  ElectroMan() {
    super(250, 2, 0, 0, 0, 0, "ElectroMan", 15);
    
    images[0] = loadImage("electroMan.JPG");
    images[1] = loadImage("electroMan75.JPG"); 
    images[2] = loadImage("electroMan50.JPG");
  
    images[0].resize(20,20);
    images[1].resize(20,20);
    images[2].resize(20,20);
  }
  
  
  //for when the location is specified
  ElectroMan(float x, float y) {
    super(250, 2, x, y, x/20, y/20, "ElectroMan", 15);
    
    images[0] = loadImage("electroMan.JPG");
    images[1] = loadImage("electroMan75.JPG"); 
    images[2] = loadImage("electroMan50.JPG");
  
    images[0].resize(20,20);
    images[1].resize(20,20);
    images[2].resize(20,20);
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
    
    //make targetX and targetY into the graphics coordinate not index
      targetX = targetX*20; 
      targetY = targetY*20;
    
      //accidentaly switched them somewhere along the line
      int temp = targetY; 
      targetY = targetX; 
      targetX = temp;
      
      
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
    
  }
  
  
}
