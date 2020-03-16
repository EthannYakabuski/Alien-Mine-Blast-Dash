Player playerone = new Player();
GameBoard board = new GameBoard();

PImage[] images = new PImage[100];

int width = 1400;
int height = 900;



void setup() {
  
  //setting the framerate
  frameRate(1);
  
  //tiles
  images[0] = loadImage("tree100.PNG");
  images[1] = loadImage("tree75.PNG");
  images[2] = loadImage("tree50.PNG");
  images[3] = loadImage("tree25.PNG");
  
  images[4] = loadImage("iron100.PNG");
  images[5] = loadImage("iron75.PNG");
  images[6] = loadImage("iron50.PNG");
  images[7] = loadImage("iron25.PNG");
  
  images[8] = loadImage("gold100.PNG");
  images[9] = loadImage("gold75.PNG");
  images[10] = loadImage("gold50.PNG");
  images[11] = loadImage("gold25.PNG");
  
  images[12] = loadImage("lava100.PNG");
  images[13] = loadImage("grass100.PNG");
  images[14] = loadImage("dirt100.PNG");
  
  
  //characters
  //players
  images[15] = loadImage("lenny100.PNG");
  
  //enemies
  images[16] = loadImage("ant100.PNG");
  images[17] = loadImage("ant75.PNG"); 
  images[18] = loadImage("ant50.PNG");
  
  
  images[0].resize(20,20);
  images[1].resize(20,20);
  images[2].resize(20,20);
  images[3].resize(20,20);
  images[4].resize(20,20);
  images[5].resize(20,20);
  images[6].resize(20,20);
  images[7].resize(20,20);
  images[8].resize(20,20);
  images[9].resize(20,20);
  images[10].resize(20,20);
  images[11].resize(20,20);
  images[12].resize(20,20);
  images[13].resize(20,20);
  images[14].resize(20,20);
  images[15].resize(20,20);
  images[16].resize(20,20);
  images[17].resize(20,20);
  images[18].resize(20,20);
  
  
  board.imageList = images;
  board.addPlayer(playerone);
  board.createMap();
  size(1400,900);
  smooth();
  

}

void draw() {
  //basic layout
  background(255);
  gridDisplay();
  
  //shows game graphics and other
  //important information for the player concerning the game state
  board.hud(playerone);
  board.display();
  board.spawnInitialEnemies();
  
  //updates enemies
  board.checkEnemies();
  board.moveEnemies();
  board.showEnemies();
  
  //updates player bullets
  board.checkBulletRedundancy();
  board.drawBullets();
  board.checkCollisions();
  
  
  //update enemy bullets
  
}

void gridDisplay() {
  
  //vertical lines
  int i = 0;
  while (i < 1400) {
    line(i,0,i,800);
    i = i + 20;
  }
  //horizontal lines
  int j = 0;
  while (j < 801) {
    line(0,j,1400,j);
    j = j + 20;
  }
}

void keyPressed() {
       
  //handles WASD movement and hotkey bar START
  if (key == 119) {
    playerone.keyHandler("w");
    
  } else if (key == 97) {
    playerone.keyHandler("a");
    
  } else if (key == 115) {
    playerone.keyHandler("s");
    
  } else if (key == 100) {
    playerone.keyHandler("d");
    
  } else if (key == 49) {
    playerone.keyHandler("1"); 
    
  } else if (key == 50) {
    playerone.keyHandler("2"); 
  } 
  else if (key == 51) {
    playerone.keyHandler("3"); 
  }
  else if (key == 52) {
    playerone.keyHandler("4"); 
  }
  else if (key == 53) {
    playerone.keyHandler("5"); 
  }
  //handles WASD movement and hotkey bar END
  
}

void mousePressed() {
  
  println(mouseX);
  println(mouseY);
  
  int x = (mouseX/20);
  int y = (mouseY/20);
  
  //proves the clicking is on the correct square
  /*
  if(x < 70 && y < 40) {
    board.tiles[y][x].showYourself();
    println("I: " + y);
    println("J: " + x);
  }
  */
  //SHOOTING
  //if the player is clicking in the board and the tommy gun is active
  if(x < 70 && y < 40 && playerone.active == 1) {
    println(playerone.getXC());
    println(playerone.getYC());
    println("bullet");
    board.introduceBullet(x,y, playerone.getYC(), playerone.getXC(), playerone.getTommy());  
  }
  
  
  
  //if the player is clicking in the board and the pickaxe is active
  if(x < 70 && y < 40 && playerone.active == 3) {
    board.tiles[y][x].clicked(playerone);
  }

  //this section holds the code to handle the user clicks in the HUD area
  if(mouseY > 800) {
    println("The user has clicked the HUD area"); 
    
    
    //handles armor upgrade choices
    if(mouseY >= 810 && mouseY <= 830) {
      println("Armor upgrade chosen"); 
      
      //handles which tier of armor upgrade was chosen
      if(mouseX >= 1135 && mouseX <= 1185) {
        println("Wood armor"); 
        playerone.applyArmor(1); 
      } else if (mouseX >= 1195 && mouseX <= 1245) {
        println("Iron armor"); 
        playerone.applyArmor(2); 
      } else if (mouseX >= 1255 && mouseX <= 1305) {
        println("Gold armor");  
        playerone.applyArmor(3);
      }
      
    //handles tommy gun upgrades  
    } else if (mouseY >= 840 && mouseY <=860) {
      println("Tommy Gun upgrade chosen"); 
      
      //handles which tier of tommy upgrade was chosen
      if(mouseX >= 1135 && mouseX <= 1185) {
        println("Wood Tommy"); 
      } else if (mouseX >= 1195 && mouseX <= 1245) {
        println("Iron Tommy"); 
        board.giveWeapon("Iron Tommy"); 
      } else if (mouseX >= 1255 && mouseX <= 1305) {
        println("Gold Tommy");  
        board.giveWeapon("Gold Tommy");
      }
      
      
    //handles shotgun upgrades
    } else if (mouseY >= 870 && mouseY <= 890) {
      println("Shotgun upgrade chosen"); 
      
      
      //handles which tier of shotgun upgrade was chosen
      if(mouseX >= 1135 && mouseX <= 1185) {
        println("Wood Shotgun"); 
      } else if (mouseX >= 1195 && mouseX <= 1245) {
        println("Iron Shotgun");
        board.giveWeapon("Iron Shotgun");
      } else if (mouseX >= 1255 && mouseX <= 1305) {
        println("Gold Shotgun");  
        board.giveWeapon("Gold Shotgun");
      }
    }
    
  }
  
}
