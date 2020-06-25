import java.util.Random;
PFont f;

boolean plantedTrees = false;
boolean plantedTreesInSteel = false; 

boolean collision = false;


class GameBoard {
  
  //2D 40x70 array of tile objects to represent the game board
  Tile[][] tiles = new Tile[40][70];
  Player[] players = new Player[10];
  PImage[] imageList; 
  
  int bulletSize = 10; 
  int score = 0; 
  
  String currentBiome = "grassland"; 
  
  boolean phalaxDeath = false; 
  
  boolean shotGunSickness = false;
  int shotGunAnimationTick = 0;
  
  boolean tommyGunSickness = false; 
  int tommyGunAnimationTick = 0; 
  
  //arrays to store items available for build
  //allocated with the max possible amount of available build options because they are very small in size
  Armor[] armorAvailable = new Armor[3];     //wood, iron, gold 
  Weapon[] weaponAvailable = new Weapon[7]; //wood, iron, gold versions of shotgun and tommy gun respectively
  
  //maximum number of bullets at once is 200,000 if there are any more then this
  
  //-> functionality needed: dump all bullets not on screen and restart bullet numbering
  
  //contains all of the bullets currently flying through the air
  Bullet[] bullets = new Bullet[20000];
  int bulletsInAction = 0; 
  
  ArrayList<Bullet> playerBullets = new ArrayList<Bullet>();
  
  
  //contains all of the flower bullets currently flying through the air
  ArrayList<FlowerBullet> flowerBullets = new ArrayList<FlowerBullet>();
  
  
  //contains all of the robot bullets currently flying through the air
  ArrayList<RobotBullet> robotBullets = new ArrayList<RobotBullet>();
  
  
  
  //contains all of the phalax bullets currently flying through the air
  ArrayList<PhalaxBullet> phalaxBullets = new ArrayList<PhalaxBullet>();
  
  
  
  //difficulty tracker
  
  //testing
  //int difficulty = 14400; 
  int difficulty = 0; 
  int difficultyStepper = 6; 
  int difficultyStepperFlower = 6;
  int difficultyStepperRobot = 6;
  int difficultyStepperEQuad = 6;
  
  //contations all of the enemies currently on the screen
  
  //TESTING ENEMIES
  //Enemy[] enemies = new Enemy[1000];
  int enemiesInAction = 1; 
  
  ArrayList<Enemy> enemies = new ArrayList<Enemy>(); 
  
  
  //TESTING ENEMIES
  boolean initialEnemies = false; 
  
  boolean spawningFlowers = false;
  boolean spawningRobots = false;
  boolean spawningElectroQuads = false;
  
  Random r;
  
  int spawner = 0; 
  
  int flowerSpawner = 0;
  
  int robotSpawner = 0; 
  
  int electroQuadSpawner = 0; 

  
     
    
  GameBoard() {
    
    
    //initialize all of the tiles in the array used to represent our gameboard
    for(int i = 0; i < 40; i++) {
      
      for(int j = 0; j < 70; j++) {
        tiles[i][j] = new Tile();
      }
      
    }
    
    //initialize the player array
    for(int i = 0; i < 10; i++) {
      players[i] = new Player();
    }
    
    //initialize the bullet array
    //for(int i = 0; i < 20000; i++) {
     // bullets[i] = new Bullet(); 
    //}
    
    
    //TESTING ENEMIES
    
    //TESTING ENEMIES
    
    //intialize the armor and weapon arrays
    
    //so far there are three types of armor upgrade
    armorAvailable[0] = new Armor("Wood", "Wood Armor", false, 100, 50, #836835); 
    armorAvailable[1] = new Armor("Iron", "Iron Armor", false, 100, 100, #B2A89C); 
    armorAvailable[2] = new Armor("Gold", "Gold Armor", false, 100, 200, #E6ED35); 
    
    //there are three tiers of each weapon, there are only two types of weapons as per design
    weaponAvailable[0] = new Weapon("Wood", "Wood Tommy", 3, 3, false, 100, 9, 40, 40, #836835, "Tommy"); 
    weaponAvailable[1] = new Weapon("Iron", "Iron Tommy", 4, 4, false, 100, 9, 50, 50, #B2A89C, "Tommy");
    weaponAvailable[2] = new Weapon("Gold", "Gold Tommy", 6, 6, false, 100, 10, 60, 60, #E6ED35, "Tommy");
    
    weaponAvailable[3] = new Weapon("Wood", "Wood Shotgun", 200, 25, false, 100, 3, 10, 2, #836835, "Shotgun");
    weaponAvailable[3].ammo = 20;
    weaponAvailable[4] = new Weapon("Iron", "Iron Shotgun", 300, 50, false, 100, 3, 10, 2, #B2A89C, "Shotgun");
    weaponAvailable[4].ammo = 20;
    weaponAvailable[5] = new Weapon("Gold", "Gold Shotgun", 500, 75, false, 100, 3, 12, 2, #E6ED35, "Shotgun");
    weaponAvailable[5].ammo = 20;
    weaponAvailable[6] = new Weapon("Gold", "Super Power", 100, 100, false, 100, 9, 1000, 1000, #836835, "Superpower");
    weaponAvailable[6].ammo = 1000;
  }
  
  void spawnInitialEnemies() {
    
    if(!initialEnemies) {
      initialEnemies = true;
      
      for(int i = 0; i < 1; i++) {
       //enemies.add(new Ant(0,0)); 
       //enemies.add(new Flower(200,200));
       //enemies[1] = new Ant(60,40); 
       //enemies[2] = new Ant(40,80);  
      
       
       
       //enemies.add(new Robot(100,100));
       //enemies.add(new Ant(0,0)); 
       //enemies.add(new Flower(200,200));
       //enemies.add(new Phalax(600,400));
      // enemies.add(new ElectroMan(400,400));
      // enemies.add(new ElectroDuo(500,400));
       //enemies.add(new ElectroQuad(300,300));
       
       //enemies.add(new Robot(0,0));
       //enemies.add(new Flower(0,0));
       //testing a phalax
      // enemies.add(new Phalax(600,400));
       
       //generateBiome();
       
       //enemies.add(new ElectroQuad(100,100));
       
       
      
    }
      
    }
    
  }
  
  void checkBiomeSwitch() {
    //System.out.println("Hello"); 
    
    if(phalaxDeath) { this.generateBiome(); }
    
  }
  
  //this function will spawn a new enemy somewhere on the map
  void spawnAnEnemy(int frame) {
    
    //System.out.println("Frame: " + frame); 
    
    //we are at the start of a biome
    if(difficulty == 0) {
      System.out.println("Biome start");
      if(currentBiome.equals("steel")) {
        spawningFlowers = false; 
        spawningRobots = false;
        spawningElectroQuads = false;
        difficultyStepper = 6;
      }
      
    }
    
    difficulty = difficulty + 1; 
    
    //after one minute, adjust the spawn rate of ants
    if( (difficulty == 1800)&(currentBiome.equals("grassland"))) {
      //speed up the ant spawn
      difficultyStepper = 4; 
    } else if ( (difficulty == 1800)&(currentBiome.equals("steel"))) {
      
      
      //after one minute in new biome start spawning electro quads and speed up ants a bit
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 4;
      spawningRobots = false;
      //difficultyStepperRobot = 4;
      spawningElectroQuads = true;
    }
    
    //after two minutes, adjust the spawn rate of ants
    if( (difficulty == 3600) &(currentBiome.equals("grassland"))) {
      //speed up the ant spawn
      difficultyStepper = 2; 
    } else if ( (difficulty == 3600)&(currentBiome.equals("steel"))) {
      
      
      //after two minutes in the new biome, start spawning robots again at middle speed, and speed up ants to max
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 2;
      spawningRobots = true;
      difficultyStepperRobot = 4;
      
    }
    
    //after 3 minutes, start spawning flower enemies
    if((difficulty == 5400) &(currentBiome.equals("grassland"))) {
      //slow down the ants a bit for now
      difficultyStepper = 2;
      difficultyStepperFlower = 6; 
      spawningFlowers = true;
    } else if ( (difficulty == 5400)&(currentBiome.equals("steel"))) {
      
      
      //after three minutes in the new biome, start spawning flowers, ants and robots at max speed
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 2;
      spawningRobots = true;
      spawningFlowers = true;
      difficultyStepperFlower = 2;
      difficultyStepperRobot = 2;
      
    }
    
    //after 4 minutes, adjust the spawn rate of flowers to be quicker
    if((difficulty == 7200) &(currentBiome.equals("grassland"))) {
      //speed up the ant spawn
      difficultyStepper = 2;
      difficultyStepperFlower = 4; 
      spawningFlowers = true;
    } else if ( (difficulty == 7200)&(currentBiome.equals("steel"))) {
     
      
      //after 4 minutes in the new biome slow down flowers, robots and ants a bit
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 4;
      spawningRobots = true;
      spawningFlowers = true;
      difficultyStepperFlower = 4;
      difficultyStepperRobot = 4;
      
    }
    
    //after 5 minutes, adjust the spawn rate of flowers to be max
    if ((difficulty == 9000) &(currentBiome.equals("grassland"))) {
      difficultyStepperFlower = 2;
      difficultyStepper = 2;
      spawningFlowers = true;
      
    } else if ( (difficulty == 9000)&(currentBiome.equals("steel"))) {
      
      //after 5 minutes in the new biome stop spawning flowers and robots, slow down ants a bit
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 6;
      spawningRobots = false;
      spawningFlowers = false;
      difficultyStepperFlower = 2;
      difficultyStepperRobot = 2;
     
    }
    
    //after 6 minutes, stop spawning enemies except for ants, let player empty the screen and grab some more resources
    if ((difficulty == 10800) &(currentBiome.equals("grassland"))) {
      //difficultyStepper = 100;\
      difficultyStepper = 2; 
      //difficultyStepperFlower = 100; 
      spawningFlowers = false; 
      spawningRobots = false; 
    } else if ( (difficulty == 10800)&(currentBiome.equals("steel"))) {
      
      //after 6 minutes in the new biome, stop spawning electro quads
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 6;
      spawningElectroQuads = false;
     
    }
    
    
    //after 7 minutes, start spawning robots
    if((difficulty == 12600) &(currentBiome.equals("grassland"))) {
      spawningRobots = true;
      difficultyStepperRobot = 4; 
      
    } else if ( (difficulty == 12600)&(currentBiome.equals("steel"))) {
      
      //after 7 minutes in the new biome, spawn a MINI BOSS
      System.out.println("Leveling up correctly in new biome"); 
      difficultyStepper = 6;

     
    }
    
    
    //after 8 minutes, start spawning flowers again, speed up robots to max
    if ((difficulty == 14400) &(currentBiome.equals("grassland"))) {
       difficultyStepper = 2; 
       difficultyStepperFlower = 4;
       difficultyStepperRobot = 2;
       spawningFlowers = true; 
       spawningRobots = true;
    }
    
    //after 9 minutes, flowers to max spawn rate
    if ((difficulty == 16200)  &(currentBiome.equals("grassland"))) {
      difficultyStepper = 2; 
      difficultyStepperFlower = 2; 
      difficultyStepperRobot = 2;
      spawningFlowers = true; 
      spawningRobots = true;
    }
    
    //10 minutes
    //stop spawning flowers and robots, ants at max spawn rate
    //spawn a phalax
    if ((difficulty == 18000) &(currentBiome.equals("grassland"))) {
      spawningFlowers = false; 
      spawningRobots = false; 
      difficultyStepper = 2; 
      
       int streamSize = 10; 
      int start = 0; 
      int bound = 9; 
      int xBound = 69;
      int yBound = 30;
      int xMin = 0; 
      int yMin = 0;
    
      Random r = new Random(); 
    
      r.ints(streamSize, start, bound);
      int spawnX = r.nextInt(xBound+1-xMin) + xMin;
      int spawnY = r.nextInt(yBound+1-yMin) + yMin;
    
      spawnX = spawnX*20; 
      spawnY = spawnY*20; 
      
      Phalax tempPhalax = new Phalax(spawnX, spawnY);
      enemies.add(tempPhalax);
      
    }
    
  
    
    int streamSize = 5; 
    int start = 0; 
    int bound = 9; 
    int xBound = 69;
    int yBound = 30;
    int xMin = 0; 
    int yMin = 0;
    
    Random r = new Random(); 
    
    r.ints(streamSize, start, bound);
    
    int spawnX = r.nextInt(xBound+1-xMin) + xMin;
    int spawnY = r.nextInt(yBound+1-yMin) + yMin;
    
    spawnX = spawnX*20; 
    spawnY = spawnY*20; 
    
    
    
    
    //spawn an enemy ant every 7-8 seconds, then 5-6 seconds, then 3-4 seconds
    if(frame==0) {
      spawner = spawner + 1; 
      
      if(spawner == difficultyStepper) {
        System.out.println("Spawning a new enemy ANT at: (" + spawnX + "," + spawnY + ")"); 
        //determine where the enemy is going to spawn
        Ant tempAnt = new Ant(spawnX, spawnY);
        
        enemies.add(tempAnt); 
        //increment the amount of enemies in action
        //enemiesInAction = enemiesInAction + 1; 
        
        
        //reset the ant spawner
        spawner = 0; 
      }
      
    }
    
    //spawn an enemy flower every 7-8 seconds
    if( (frame==0) & spawningFlowers) {
      flowerSpawner = flowerSpawner + 1;
      
      if( (flowerSpawner%difficultyStepperFlower) == 0) {
        System.out.println("Spawning a new enemy FLOWER at: (" + spawnX + "," + spawnY + ")");
        
        //spawn a flower here
        Flower tempFlower = new Flower(spawnX, spawnY);
        
        //add it to the enemies list
        enemies.add(tempFlower);
        
      }
      
    }
    
    
    //spawn an enemy robot every 7-8 seconds
    //spawn an enemy flower every 7-8 seconds
    if( (frame==0) & spawningRobots) {
      robotSpawner = robotSpawner + 1;
      
      int spawnRobotX = r.nextInt(xBound+1-xMin) + xMin;
      int spawnRobotY = r.nextInt(yBound+1-yMin) + yMin;
      
      spawnRobotX = spawnRobotX*20; 
      spawnRobotY = spawnRobotY*20; 
      
      if( (robotSpawner%difficultyStepperRobot) == 0) {
        System.out.println("Spawning a new enemy ROBOT at: (" + spawnRobotX + "," + spawnRobotY + ")");
        
        //spawn a robot here
        Robot tempRobot = new Robot(spawnRobotX, spawnRobotY);
        
        //add it to the enemies list
        enemies.add(tempRobot);
        
      }
      
    }
    
    
    if( (frame==0) & spawningElectroQuads) {
      electroQuadSpawner = electroQuadSpawner + 1;
      
      int spawnEQuadX = r.nextInt(xBound+1-xMin) + xMin;
      int spawnEQuadY = r.nextInt(yBound+1-yMin) + yMin;
      
      spawnEQuadX = spawnEQuadX*20; 
      spawnEQuadY = spawnEQuadY*20; 
      
      if( (electroQuadSpawner%difficultyStepperEQuad) == 0) {
        System.out.println("Spawning a new enemy ROBOT at: (" + spawnEQuadX + "," + spawnEQuadY + ")");
        
        //spawn a robot here
        ElectroQuad tempElectroQuad = new ElectroQuad(spawnEQuadX, spawnEQuadY);
        
        //add it to the enemies list
        enemies.add(tempElectroQuad);
        
      }
      
    }
    
    
  }
  
  
  //this function will call all of the current enemies movement function in order to update their attributes
  void moveEnemies(int frame) {
    
    //System.out.println("Frame: "+ frame);
    
    //make a decision to move 4 times a second
    if(frame==0 || frame==5 || frame==10 || frame==15 || frame==20 || frame==25 || frame==30) {
    
      //move the ants
      //System.out.println("Enemies taking a step");
      for(int i = 0; i < enemies.size(); i++) {
        //System.out.println("In the loop");
        enemies.get(i).move(players[0].getXC(), players[0].getYC());
      }
    }
    
  }
  
  //this function checks the health of all enemies 
  void checkEnemies() {
    for(int i = 0; i < enemies.size(); i++) {
       if(enemies.get(i).health <= 0) { 
       
        if(enemies.get(i).getEnemyType().equals("Phalax")) {
          System.out.println("BIOME SWITCH");
          
          
          phalaxDeath = true; 
          
         
        }
        enemies.get(i).status = false; 
        enemies.remove(enemies.get(i)); 
     }
    }
    
  }
  
  
  
  //this function will draw all of the current enemies using the new updated attributes
  void showEnemies() {
    
   // System.out.println("Enemies.size(): " + enemies.size()); 
    
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).show();
      
    }
      
    
    
  }
  
  //turns status to false of all bullets that are off the screen
  void checkBulletRedundancy() {
    for(int i = 0; i < playerBullets.size(); i++) {
       playerBullets.get(i).checkStatus(); 
       
       if(playerBullets.get(i).getStatus() == false) {
         playerBullets.remove(playerBullets.get(i));
       }
    }
    
    for(int i = 0; i < flowerBullets.size(); i++) {
       flowerBullets.get(i).checkStatus();
       
       
       if(flowerBullets.get(i).getStatus() == false) {
         flowerBullets.remove(flowerBullets.get(i));
       }
       
    }
    
    for(int i = 0; i < robotBullets.size(); i++) {
       robotBullets.get(i).checkStatus();
       
       if(robotBullets.get(i).getStatus() == false) {
         robotBullets.remove(robotBullets.get(i));
       }
    }
    
     for(int i = 0; i < phalaxBullets.size(); i++) {
       phalaxBullets.get(i).checkStatus();
    }
      
    
  }
  
  //checks each row and each column, if there are 5 or more enemies present on one given line, apply swarm intelligence
  void updateSwarmIntelligence() {
    
  }
  
  void checkEnemyAntsEating() {
    
    //for each enemy
    for (int i = 0; i < enemies.size(); i++) {
      
      int enemyXC = (int) enemies.get(i).getXC();
      int enemyYC = (int) enemies.get(i).getYC();
      
      //switched them by accident somewhere along the line
      int playerXC = players[0].getYC()*20;
      int playerYC = players[0].getXC()*20;
      
      //System.out.println("Player at: " + playerXC+ "," + playerYC);
      //System.out.println("Enemy at: " + enemyXC + "," + enemyYC);
      
      
      
      if((enemyXC == playerXC)&(enemyYC == playerYC)) {
       // System.out.println("COLLISION");
        
        //this enemy deals damage to that player if they are on the same square as them
        if(enemies.get(i).enemyType == "Ant" || enemies.get(i).enemyType == "ElectroMan") {
        boolean playerDied = enemies.get(i).dealDamage(players[0]);
        
        //if the playerDied
        if(playerDied) {
          
          System.out.println("Mission Failed, score: " + score); 
          
        }
        }
      }
      
      if((enemyXC == playerXC+20)&(enemyYC == playerYC)) {
       // System.out.println("COLLISION");
        
        //this enemy deals damage to that player if they are on the same square as them
        if(enemies.get(i).enemyType == "Ant" || enemies.get(i).enemyType == "ElectroMan") {
        boolean playerDied = enemies.get(i).dealDamage(players[0]);
        
        //if the playerDied
        if(playerDied) {
          
          System.out.println("Mission Failed, score: " + score); 
          
        }
        }
      }
      
      if((enemyXC == playerXC+20)&(enemyYC == playerYC+20)) {
       // System.out.println("COLLISION");
        
        //this enemy deals damage to that player if they are on the same square as them
        if(enemies.get(i).enemyType == "Ant" || enemies.get(i).enemyType == "ElectroMan") {
        boolean playerDied = enemies.get(i).dealDamage(players[0]);
        
        //if the playerDied
        if(playerDied) {
          
          System.out.println("Mission Failed, score: " + score); 
          
        }
        }
      }
      
      if((enemyXC == playerXC)&(enemyYC == playerYC+20)) {
       // System.out.println("COLLISION");
        
        //this enemy deals damage to that player if they are on the same square as them
        if(enemies.get(i).enemyType == "Ant" || enemies.get(i).enemyType == "ElectroMan") {
        boolean playerDied = enemies.get(i).dealDamage(players[0]);
        
        //if the playerDied
        if(playerDied) {
          
          System.out.println("Mission Failed, score: " + score); 
          
        }
        }
      }
    }  
  }
  
  
  
  //for each enemy in the arraylist that needs to shoot, expel their shot
  void checkEnemiesWhoShoot() {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      //if the enemy needs to shoot
      if(enemies.get(i).getShotExpulsion()) {
        
        //System.out.println("Generating enemy bullet");
        //create the bullet for the flower enemy type
        if(enemies.get(i).getEnemyType() == "Flower" || enemies.get(i).enemyType == "ElectroDuo") {
          //System.out.println("Generating flower bullet"); 
          
          
          //flipped them somewhere along the line
          int targetXC = players[0].getYC()*20;
          int targetYC = players[0].getXC()*20;
          int myXC = (int)enemies.get(i).getXC();
          int myYC = (int)enemies.get(i).getYC();
          
          //System.out.println("TargetXC: " + targetXC);
          //System.out.println("TargetYC: " + targetYC);
         // System.out.println("MYXC: " + myXC);
         // System.out.println("MYYC: " + myYC);
          
          
          //add the bullet
          if(enemies.get(i).enemyType == "Flower" || enemies.get(i).enemyType == "ElectroDuo") {
            
            if(enemies.get(i).enemyType == "Flower") {
              introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7, false);
            } else { 
              introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7, true);
            }
            
          } else if (enemies.get(i).enemyType == "Robot") {
            introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+3, false);
          }
          
      
          enemies.get(i).setNeedToShoot(false);
          
        } else if ( (enemies.get(i).getEnemyType() == "Robot") || (enemies.get(i).getEnemyType() == "ElectroQuad")) {
          
         // System.out.println("Generating robot bullet"); 
          
          
          //flipped them somewhere along the line
          int targetXC = players[0].getYC()*20;
          int targetYC = players[0].getXC()*20;
          int myXC = (int)enemies.get(i).getXC();
          int myYC = (int)enemies.get(i).getYC();
          
        //  System.out.println("TargetXC: " + targetXC);
        //  System.out.println("TargetYC: " + targetYC);
        //  System.out.println("MYXC: " + myXC);
        //  System.out.println("MYYC: " + myYC);
          
          
          //add the bullet
          if(enemies.get(i).enemyType == "Flower") {
            introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7, false);
          } else if (enemies.get(i).enemyType == "Robot" || enemies.get(i).enemyType == "ElectroQuad") {
            if(enemies.get(i).enemyType == "Robot") { 
              introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+3, false);
            } else { 
              introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+3, true);
            }
          }
          
      
          enemies.get(i).setNeedToShoot(false);
          
          
        } else if (enemies.get(i).getEnemyType() == "Phalax") {
          
        //  System.out.println("Generating Phalax bullet"); 
          
          
          //flipped them somewhere along the line
          int targetXC = players[0].getYC()*20;
          int targetYC = players[0].getXC()*20;
          int myXC = (int)enemies.get(i).getXC();
          int myYC = (int)enemies.get(i).getYC();
          
        //  System.out.println("TargetXC: " + targetXC);
        //  System.out.println("TargetYC: " + targetYC);
        //  System.out.println("MYXC: " + myXC);
        //  System.out.println("MYYC: " + myYC);
          
          
          //add the bullet
          if(enemies.get(i).enemyType == "Flower") {
            introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7, false);
          } else if (enemies.get(i).enemyType == "Robot") {
            introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+3, false);
          } else if (enemies.get(i).enemyType == "Phalax") {
            introducePhalaxBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+3);
          }
      
          enemies.get(i).setNeedToShoot(false);
        
        
      }
      
      }
      
    }
    
  }
  
  
  //called when the player receives fatal damage,
  boolean endGame() {
    
    if(players[0].getHealth() <= 0) {
      return true;
    } else {
      return false; 
    }
    
  }
  
  
  //resets all of the board game variables for game restart
  void resetBoardVariables() {
    players[0].reset();
    
    plantedTrees = false; 
    plantedTreesInSteel = false; 
    collision = false;
    
    bulletSize = 10;
    score = 0;
    bulletsInAction = 0;
    enemiesInAction = 1; 
    
    //reset the backing array holding the gameboard state
    for(int i = 0; i < 40; i++) {
      for(int j = 0; j < 70; j++) {
        //tiles[i][j] = null;
      }
    }
    
    for(int i = 0; i < 10; i++) {
      players[i] = null;
    }
    
    for(int i = 0; i < 20000; i++) {
      bullets[i] = null;
    }
    
    for (int i = 0; i < enemies.size(); i++) {
       enemies.remove(i); 
    }
    enemies.clear();
    
    for (int i = 0; i < flowerBullets.size(); i++) {
      flowerBullets.remove(i); 
    }
    flowerBullets.clear();
    
    for (int i = 0; i < robotBullets.size(); i++) {
      robotBullets.remove(i); 
    }
    robotBullets.clear();
    
    initialEnemies = false;
    spawner = 0; 
    
    //difficulty tracker
    difficulty = 0; 
    difficultyStepper = 6;
    difficultyStepperFlower = 6;
    difficultyStepperRobot = 6;
    difficultyStepperEQuad = 6; 
    spawningFlowers = false;
    spawningRobots = false;
    
  }
  
  //checks if the player is standing on any level and if so deals some damage to them
  void checkLavaDamage() {
    
    //System.out.println("Checking lava damage"); 
    
    int playerXC = players[0].getXC(); 
    int playerYC = players[0].getYC();
    
    
    //if the tile the player is standing on is lava
    if(tiles[playerXC][playerYC].getType().equals("Lava")) {
      System.out.println("Dealing damage to the player due to lava");
      players[0].setHealth(players[0].getHealth() - 1);
      
    }
    
    if(tiles[playerXC+1][playerYC].getType().equals("Lava")) {
      System.out.println("Dealing damage to the player due to lava");
      players[0].setHealth(players[0].getHealth() - 1);
      
    }
    
    if(tiles[playerXC+1][playerYC+1].getType().equals("Lava")) {
      System.out.println("Dealing damage to the player due to lava");
      players[0].setHealth(players[0].getHealth() - 1);
      
    }
    
    if(tiles[playerXC][playerYC+1].getType().equals("Lava")) {
      System.out.println("Dealing damage to the player due to lava");
      players[0].setHealth(players[0].getHealth() - 1);
      
    }
    
  }
  
  //simulates the constructor for this object, for a clean new game state
  void pseudoConstructor() {
    
    //initialize all of the tiles in the array used to represent our gameboard
    for(int i = 0; i < 40; i++) {
      
      for(int j = 0; j < 70; j++) {
        tiles[i][j] = new Tile();
      }
      
    }
    
    //initialize the player array
    for(int i = 0; i < 10; i++) {
      players[i] = new Player();
    }
    
    //initialize the bullet array
    for(int i = 0; i < 20000; i++) {
      bullets[i] = new Bullet(); 
    }
    
    
    //TESTING ENEMIES
    
    //TESTING ENEMIES
    
    //intialize the armor and weapon arrays
    
    //so far there are three types of armor upgrade
    armorAvailable[0] = new Armor("Wood", "Wood Armor", false, 100, 50, #836835); 
    armorAvailable[1] = new Armor("Iron", "Iron Armor", false, 100, 100, #B2A89C); 
    armorAvailable[2] = new Armor("Gold", "Gold Armor", false, 100, 200, #E6ED35); 
    
    //so far there are three types of each weapon and there are only two types of weapons as per design
    weaponAvailable[0] = new Weapon("Wood", "Wood Tommy", 6, 6, false, 100, 9, 150, 50, #836835, "Tommy"); 
    weaponAvailable[1] = new Weapon("Iron", "Iron Tommy", 8, 8, false, 100, 9, 150, 50, #B2A89C, "Tommy");
    weaponAvailable[2] = new Weapon("Gold", "Gold Tommy", 12, 12, false, 150, 10, 150, 50, #E6ED35, "Tommy");
    
    weaponAvailable[3] = new Weapon("Wood", "Wood Shotgun", 75, 150, false, 100, 3, 10, 2, #836835, "Shotgun");
    weaponAvailable[4] = new Weapon("Iron", "Iron Shotgun", 100, 175, false, 100, 3, 10, 2, #B2A89C, "Shotgun");
    weaponAvailable[5] = new Weapon("Gold", "Gold Shotgun", 125, 200, false, 100, 3, 12, 2, #E6ED35, "Shotgun");
    
    //difficulty tracker
    difficulty = 0; 
    difficultyStepper = 6; 
  }
  
  
  void checkRobotBulletCollisions() {
    
    //for each flower bullet that is in action
    for(int i = 0; i < robotBullets.size(); i++) {
      
      int bulletX = robotBullets.get(i).getXC();
      int bulletY = robotBullets.get(i).getYC(); 
      
      //switched them by accident somewhere along the line
      int playerXC = players[0].getYC()*20;
      int playerYC = players[0].getXC()*20;
      
      
      //translate the bulletX and bulletY to the index
      //System.out.println("FlowerBulletX: " + bulletX); 
      //System.out.println("FlowerBulletY: " + bulletY); 
      
      int timesLoopedX = 0; 
      int bulletXLooping = bulletX; 
      
      int timesLoopedY = 0; 
      int bulletYLooping = bulletY; 
      
      while(bulletXLooping > 0) {
        bulletXLooping = bulletXLooping - 20;
        timesLoopedX = timesLoopedX + 1;
      }
      
      while(bulletYLooping > 0) {
        bulletYLooping = bulletYLooping - 20; 
        timesLoopedY = timesLoopedY + 1;
      }
      
      
      //System.out.println("Estimating flower bullet location: [" + timesLoopedX + "," + timesLoopedY + "]");
      
      if( (timesLoopedX*20 == playerXC) & (timesLoopedY*20 == playerYC)) {
        System.out.println("There has been damage dealt from a robot bullet to the player"); 
        if(robotBullets.get(i).getStatus()) { players[0].takeDamage(robotBullets.get(i).getDamage()); }
      }
      
      if( (timesLoopedX*20 == playerXC+20) & (timesLoopedY*20 == playerYC)) {
        System.out.println("There has been damage dealt from a robot bullet to the player"); 
        if(robotBullets.get(i).getStatus()) { players[0].takeDamage(robotBullets.get(i).getDamage()); }
      }
      
      if( (timesLoopedX*20 == playerXC+20) & (timesLoopedY*20 == playerYC+20)) {
        System.out.println("There has been damage dealt from a robot bullet to the player"); 
        if(robotBullets.get(i).getStatus()) { players[0].takeDamage(robotBullets.get(i).getDamage()); }
      }
      
       if( (timesLoopedX*20 == playerXC) & (timesLoopedY*20 == playerYC+20)) {
        System.out.println("There has been damage dealt from a robot bullet to the player"); 
        if(robotBullets.get(i).getStatus()) { players[0].takeDamage(robotBullets.get(i).getDamage()); }
      }
      
    }
    
    
  }
  
  //checks if there are any collisions amongst the player and the flower bullets that are still in action
  void checkFlowerBulletCollisions() {
    
    
    //for each flower bullet that is in action
    for(int i = 0; i < flowerBullets.size(); i++) {
      
      int bulletX = flowerBullets.get(i).getXC();
      int bulletY = flowerBullets.get(i).getYC(); 
      
      //switched them by accident somewhere along the line
      int playerXC = players[0].getYC()*20;
      int playerYC = players[0].getXC()*20;
      
      
      //translate the bulletX and bulletY to the index
      //System.out.println("FlowerBulletX: " + bulletX); 
      //System.out.println("FlowerBulletY: " + bulletY); 
      
      int timesLoopedX = 0; 
      int bulletXLooping = bulletX; 
      
      int timesLoopedY = 0; 
      int bulletYLooping = bulletY; 
      
      while(bulletXLooping > 0) {
        bulletXLooping = bulletXLooping - 20;
        timesLoopedX = timesLoopedX + 1;
      }
      
      while(bulletYLooping > 0) {
        bulletYLooping = bulletYLooping - 20; 
        timesLoopedY = timesLoopedY + 1;
      }
      
      
      //System.out.println("Estimating flower bullet location: [" + timesLoopedX + "," + timesLoopedY + "]");
      
      if( (timesLoopedX*20 == playerXC) & (timesLoopedY*20 == playerYC)) {
        System.out.println("There has been damage dealt from a flower bullet to the player"); 
        if(flowerBullets.get(i).getStatus()) { players[0].takeDamage(flowerBullets.get(i).getDamage()); }
      }
      
      if( (timesLoopedX*20 == playerXC+20) & (timesLoopedY*20 == playerYC)) {
        System.out.println("There has been damage dealt from a flower bullet to the player"); 
        if(flowerBullets.get(i).getStatus()) { players[0].takeDamage(flowerBullets.get(i).getDamage()); }
      }
      
      if( (timesLoopedX*20 == playerXC+20) & (timesLoopedY*20 == playerYC+20)) {
        System.out.println("There has been damage dealt from a flower bullet to the player"); 
        if(flowerBullets.get(i).getStatus()) { players[0].takeDamage(flowerBullets.get(i).getDamage()); }
      }
      
      if( (timesLoopedX*20 == playerXC) & (timesLoopedY*20 == playerYC+20)) {
        System.out.println("There has been damage dealt from a flower bullet to the player"); 
        if(flowerBullets.get(i).getStatus()) { players[0].takeDamage(flowerBullets.get(i).getDamage()); }
      }
      
    }
    
    
  }
  
  
  //checks every active bullet and every active enemy for collision
  //processor demanding
  void checkCollisions() {
     
    //System.out.println("Checking collisions"); 
    
    //for each bullet
    for(int i = 0; i < playerBullets.size(); i++) {
      
      
      //for each enemy
      for (int e = 0; e < enemies.size(); e++) {
       
        //if the bullet is on the visible screen
        if(playerBullets.get(i).status) {
          //get the necessary variables in order to check collision
          float enemyX = enemies.get(e).xC;    
          float enemyY = enemies.get(e).yC;   
        
          float bulletX = playerBullets.get(i).xCoor; 
          float bulletY = playerBullets.get(i).yCoor;
          
          //System.out.println("Enemy XC: " + enemyX);
          //System.out.println("Enemy YC: " + enemyY);
          //System.out.println("Bullet XC: " + bulletX); 
          //System.out.println("Bullet YC: " + bulletY);
        
          //testing only
          //System.out.println("Collision: " + collision);
          //testing only
          
          
          //if the origin of the circle (the bullet) + the radius of the circle is within the square that is occupied by an enemy then there has been a collision
          if(  ( ((enemyX-bulletSize/2) < bulletX) & (bulletX < (enemyX+20+bulletSize/2)) ) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) & (enemies.get(e).getEnemyType() != "Phalax") & (enemies.get(e).getEnemyType() != "ElectroQuad") )  {
            
            //println("There has been a collision");
            collision = true;
            
            //deal the damage
            
            System.out.println(playerBullets.get(i).getDamage() + " damage dealt to enemy");
            
            boolean death = false;
            
            death = enemies.get(e).receiveDamage(playerBullets.get(i).getDamage());
            
            //if an enemy death has occured, remove it from the game
            if(death) {
              System.out.println("There has been a MURDER");
              
              //get the appropriate score to add
              int addedScore = enemies.get(e).getScore();
              score = score + addedScore; 
          
              //set the players score
              players[0].setScore(score);
              
              //remove the enemy from the game
              enemies.remove(enemies.get(e));
              
            }
            
          } else if (enemies.get(e).getEnemyType() == "Phalax") {
            
            boolean phalaxCollision = false; 
            
            //first hitbox (left of head)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) ) { phalaxCollision = true; }
              
            //second hitbox (right of head)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) ) { phalaxCollision = true; }
            
           
           
           
            //third hitbox (left of chin and neck)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY+20-bulletSize/2) < bulletY) & (bulletY < (enemyY+40+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //fourth hitbox (right of chin and neck)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY+20-bulletSize/2) < bulletY) & (bulletY < (enemyY+40+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            
            
            
            
            //fifth hitbox (left arm)
            if(   ((enemyX-bulletSize/2) < bulletX) & (bulletX < (enemyX+20+bulletSize/2)) & ( ((enemyY+40-bulletSize/2) < bulletY) & (bulletY < (enemyY+60+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //sixth hitbox (left shoulder)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY+40-bulletSize/2) < bulletY) & (bulletY < (enemyY+60+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //seventh hitbox (right shoulder)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY+40-bulletSize/2) < bulletY) & (bulletY < (enemyY+60+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //eighth hitbox (right arm)
            if(   ((enemyX+60-bulletSize/2) < bulletX) & (bulletX < (enemyX+80+bulletSize/2)) & ( ((enemyY+40-bulletSize/2) < bulletY) & (bulletY < (enemyY+60+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            
            
            
            //ninth hitbox (left knee and thigh)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY+60-bulletSize/2) < bulletY) & (bulletY < (enemyY+80+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //tenth hitbox (right knee and thigh)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY+60-bulletSize/2) < bulletY) & (bulletY < (enemyY+80+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            
            
            
            
            //eleventh hitbox (left chin and foot)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY+80-bulletSize/2) < bulletY) & (bulletY < (enemyY+100+bulletSize/2)) ) ) { phalaxCollision = true; }
            
            //twelvth hitbox (right chin and foot)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY+80-bulletSize/2) < bulletY) & (bulletY < (enemyY+100+bulletSize/2)) ) ) { phalaxCollision = true; }

              
            
            if(phalaxCollision) {
              
               System.out.println("PHALAX COLLISION");
              
               boolean death = false;
            
               death = enemies.get(e).receiveDamage(playerBullets.get(i).getDamage());
            
              //if an enemy death has occured, remove it from the game
              if(death) {
                System.out.println("There has been a MURDER");
              
                //get the appropriate score to add
                int addedScore = enemies.get(e).getScore();
                score = score + addedScore; 
          
                //set the players score
                players[0].setScore(score);
              
                //remove the enemy from the game
                enemies.remove(enemies.get(e));
                
                this.generateBiome();
              
              
              }
          
            
            }
          
         } else if (enemies.get(e).getEnemyType() == "ElectroQuad" || enemies.get(e).getEnemyType() == "ElectroDuo") {
           
           boolean electroQuadCollision = false;
           
           //first hitbox (left of head)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) ) { electroQuadCollision = true; }
              
            //second hitbox (right of head)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) ) { electroQuadCollision = true; }
            
           
           
           
            //third hitbox (left of body)
            if(   ((enemyX+20-bulletSize/2) < bulletX) & (bulletX < (enemyX+40+bulletSize/2)) & ( ((enemyY+20-bulletSize/2) < bulletY) & (bulletY < (enemyY+40+bulletSize/2)) ) ) { electroQuadCollision = true; }
            
            //fourth hitbox (right of body)
            if(   ((enemyX+40-bulletSize/2) < bulletX) & (bulletX < (enemyX+60+bulletSize/2)) & ( ((enemyY+20-bulletSize/2) < bulletY) & (bulletY < (enemyY+40+bulletSize/2)) ) ) { electroQuadCollision = true; }
            
            
            if(electroQuadCollision & enemies.get(e).getEnemyType().equals("ElectroQuad")) {
             
              
               System.out.println("ELECTRO QUAD COLLISION");
              
               boolean death = false;
            
               death = enemies.get(e).receiveDamage(playerBullets.get(i).getDamage());
            
              //if an enemy death has occured, remove it from the game
              if(death) {
                System.out.println("There has been a MURDER");
              
                //get the appropriate score to add
                int addedScore = enemies.get(e).getScore();
                score = score + addedScore; 
          
                //set the players score
                players[0].setScore(score);
                
                //spawn two electro duo's near where this electro quad died
                electroQuadDeath(enemyX, enemyY);
              
                //remove the enemy from the game
                enemies.remove(enemies.get(e));
                
                
                
              
              
              }
          
            
            } else if (electroQuadCollision & enemies.get(e).getEnemyType().equals("ElectroDuo")) {
              
              System.out.println("ELECTRO DUO COLLISION");
              
               boolean death = false;
            
               death = enemies.get(e).receiveDamage(playerBullets.get(i).getDamage());
            
              //if an enemy death has occured, remove it from the game
              if(death) {
                System.out.println("There has been a MURDER");
              
                //get the appropriate score to add
                int addedScore = enemies.get(e).getScore();
                score = score + addedScore; 
          
                //set the players score
                players[0].setScore(score);
                
                //spawn two electro duo's near where this electro quad died
                electroDuoDeath(enemyX, enemyY);
              
                //remove the enemy from the game
                enemies.remove(enemies.get(e));
                
              }
              
              
            }
           
           
           
         }
      }
      
     }
    }
    
    
  }
  
  void electroDuoDeath(float deathX, float deathY) {
    
    //TODO: make sure not outside of gameboard
      ElectroMan tempMan1 = new ElectroMan(deathX, deathY+40);
      
      ElectroMan tempMan2 = new ElectroMan(deathX, deathY-40);
      
      ElectroMan tempMan3 = new ElectroMan(deathX+40, deathY);
      
      ElectroMan tempMan4 = new ElectroMan(deathX-40, deathY);
      
      
      enemies.add(tempMan1);
      enemies.add(tempMan2);
      enemies.add(tempMan3);
      enemies.add(tempMan4);
      
    
  }
  
  void electroQuadDeath(float deathX, float deathY) {
    
    //TODO: make sure not outside of gameboard
      ElectroDuo tempDuo1 = new ElectroDuo(deathX, deathY+40);
      
      ElectroDuo tempDuo2 = new ElectroDuo(deathX, deathY-40);
      
     
      enemies.add(tempDuo1);
      enemies.add(tempDuo2);
      
    
  }
  
  
  void introducePhalaxBullet(int shootingAtX, int shootingAtY, int phalaxX, int phalaxY, int damage) {
    
    System.out.println("Phalax Shooting"); 
   
    introduceFlowerBullet(shootingAtX, shootingAtY, phalaxX, phalaxY, damage, false); 
    introduceFlowerBullet(shootingAtX+20, shootingAtY+20, phalaxX+20, phalaxY+20, damage, false);
    introduceFlowerBullet(shootingAtX+40, shootingAtY+40, phalaxX+40, phalaxY+40, damage, false);
    introduceFlowerBullet(shootingAtX+60, shootingAtY+60, phalaxX+60, phalaxY+60, damage, false);
    introduceFlowerBullet(shootingAtX+80, shootingAtY+80, phalaxX+80, phalaxY+80, damage, false);
    
    introduceRobotBullet(shootingAtX, shootingAtY, phalaxX, phalaxY, damage, false); 
    introduceRobotBullet(shootingAtX+20, shootingAtY+20, phalaxX+20, phalaxY+20, damage, false);
    introduceRobotBullet(shootingAtX+40, shootingAtY+40, phalaxX+40, phalaxY+40, damage, false);
    introduceRobotBullet(shootingAtX+60, shootingAtY+60, phalaxX+60, phalaxY+60, damage, false);
    introduceRobotBullet(shootingAtX+80, shootingAtY+80, phalaxX+80, phalaxY+80, damage, false);
    
  }
  
  void introduceRobotBullet(int shootingAtX, int shootingAtY, int robotX, int robotY, int damage, boolean electroQuad) {
    
    System.out.println("ROBOT SHOOTING");
    
    println("Shooting from (" + robotX + "," + robotY + ")");
    println("Shooting at (" + shootingAtX + "," + shootingAtY + ")");
    
    RobotBullet tempRobotBullet; 
    
    float a = 0; 
    float b = 0; 
    float hypotenuse = 0; 
    float theta = 0.0; 
    
    float ratio;
    float xPercentage;
    float yPercentage; 
    
    float xSpeed = 0; 
    float ySpeed = 0; 
    
    
    
    if (robotY >= shootingAtY) {   //the robot is shooting upwards or horizontally
      
      
      if(robotX <= shootingAtX) { //the robot is shooting to the right and up
         println("the robot is shooting to the right and up");
         
         //calculating lengths of sides of the right angle triangle
         b = shootingAtX - robotX; 
         a = robotY - shootingAtY; 
         
         //calculating the size of the hypotenuse
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         //calculating the angle of the bullet
         theta = asin(  (a/hypotenuse) );
         
         //println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
        // println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
        // System.out.println("X speed of bullet: " + xSpeed); 
       //  System.out.println("Y speed of bullet: " + ySpeed); 
         
         tempRobotBullet = new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX, robotY, (int)damage/2); 
      
      } else if (robotX > shootingAtX) { //the robot is shooting to the left and up
        // println("the robot is shooting to the left and up");
       //  
         
         b = robotX - shootingAtX; 
         a = robotY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
        // println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
        // println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
        // System.out.println("X speed of bullet: " + xSpeed); 
         //System.out.println("Y speed of bullet: " + ySpeed); 
         
         tempRobotBullet = new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX, robotY, (int)damage/2); 
      
      }
      
    } else if (robotY < shootingAtY) { //the player is shooting down
   
        if(robotX <= shootingAtX) { //the player is shooting to the right and down
         //  println("the player is shooting to the right and down");
           
           a = shootingAtY - robotY; 
           b = shootingAtX - robotX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
         //  println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
        //   println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
         //  System.out.println("X speed of bullet: " + xSpeed); 
         //  System.out.println("Y speed of bullet: " + ySpeed); 
           
           tempRobotBullet = new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX, robotY, (int)damage/2); 
           
        } else if (robotX > shootingAtX) { //the robot is shooting to the left and down
         //  println("the robot is shooting to the left and down");
         //  
           
           b = robotX - shootingAtX; 
           a = shootingAtY - robotY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
         //  println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
         //  println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
          // System.out.println("X speed of bullet: " + xSpeed); 
          // System.out.println("Y speed of bullet: " + ySpeed); 
           
           tempRobotBullet = new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX, robotY, (int)damage/2); 
        }
        
    }
    
    robotBullets.add(tempRobotBullet = new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX, robotY, (int)damage/2)); 
    
    if(electroQuad) { 
      
      robotBullets.add(new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX+20, robotY, (int)damage/2));
      robotBullets.add(new RobotBullet(xSpeed*2, ySpeed*2, 10, robotX+40, robotY, (int)damage/2));
    }
  }
    
  
  void introduceFlowerBullet(int shootingAtX, int shootingAtY, int flowerX, int flowerY, int damage, boolean electroDuo) {
    
   // println("Shooting from (" + flowerX + "," + flowerY + ")");
   // println("Shooting at (" + shootingAtX + "," + shootingAtY + ")");
    
    FlowerBullet tempFlowerBullet; 
    
    //flower is shooting either up or down
    if (flowerX == shootingAtX) {
       
      //flower is directly shooting downwards
       if(flowerY < shootingAtY) {
         
         //no xSpeed
         if(electroDuo) {
           tempFlowerBullet = new FlowerBullet(0,15,20,flowerX,flowerY, damage);
         } else {
           tempFlowerBullet = new FlowerBullet(0,15,10,flowerX,flowerY, damage);
         }
         
      
      //flower is directly shooting updwards
       } else {
         
         //no xSpeed.
         if(electroDuo) {
           tempFlowerBullet = new FlowerBullet(0,-30,20,flowerX,flowerY, damage);
         } else {
           tempFlowerBullet = new FlowerBullet(0,-30,10,flowerX,flowerY, damage);
         }
         
       }
      
     
    //flower is shooting eith left or right  
    } else {
      
      
      
      //flower is shooting directly to the left
      if (flowerX > shootingAtX) {
        
        //no ySpeed
        if(electroDuo) {
          tempFlowerBullet = new FlowerBullet(-30,0,20,flowerX,flowerY, damage);
        } else {
          tempFlowerBullet = new FlowerBullet(-30,0,10,flowerX,flowerY, damage);
        }
        
        
        
      //flower is shooting directly to the right  
      } else {
        
        //no ySpeed
        if(electroDuo) {
          tempFlowerBullet = new FlowerBullet(30,0,20,flowerX,flowerY, damage);
        } else {
          tempFlowerBullet = new FlowerBullet(30,0,10,flowerX,flowerY, damage);
        }
        
        
      }
      
      
      
    }
    
    
    flowerBullets.add(tempFlowerBullet); 
  
        
  }
  
  void superPowerApplied() {
    
    System.out.println("Power being applied to the board"); 
    
    //flipped them somewhere along the line
    int originXC = players[0].getYC();
    int originYC = players[0].getXC();
    
    introduceBullet(originXC+10, originYC, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+1, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+2, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+3, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+4, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+5, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+6, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+7, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+8, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC+9, originXC, originYC, weaponAvailable[6], false, true);
    
    
    introduceBullet(originXC+10, originYC, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-1, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-2, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-3, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-4, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-5, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-6, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-7, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-8, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC+10, originYC-9, originXC, originYC, weaponAvailable[6], false, true);
    
    
    introduceBullet(originXC-10, originYC, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+1, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+2, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+3, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+4, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+5, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+6, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+7, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+8, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC+9, originXC, originYC, weaponAvailable[6], false, true);
    
    
    introduceBullet(originXC-10, originYC, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-1, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-2, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-3, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-4, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-5, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-6, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-7, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-8, originXC, originYC, weaponAvailable[6], false, true);
    introduceBullet(originXC-10, originYC-9, originXC, originYC, weaponAvailable[6], false, true);
   // players[0].getTommy().addAmmo(30);
    
   
  }
  
  
  void introduceBullet(int shootingAtX, int shootingAtY, int playerX, int playerY, Weapon weaponUsed, Boolean shotgunBullet, Boolean superPowerBullet) {
    
   // println("Shooting from (" + playerX + "," + playerY + ")");
   // println("Shooting at (" + shootingAtX + "," + shootingAtY + ")");
    
    
    float a = 0; 
    float b = 0; 
    float hypotenuse = 0; 
    float theta = 0.0; 
    
    float ratio;
    float xPercentage;
    float yPercentage; 
    
    float xSpeed; 
    float ySpeed; 
    
    weaponUsed.useAmmo(1);
    
    
    //System.out.println("Max damage of weapon used: " + weaponUsed.getMaxDamage());
    
    if (playerY >= shootingAtY & (!shotgunBullet)) {   //the player is shooting upwards or horizontally
    
    
      
      
      if(playerX <= shootingAtX & ((players[0].activeTommy.ammo >= 1)||superPowerBullet)) { //the player is shooting to the right and up
       //  println("the player is shooting to the right and up");
         
         //calculating lengths of sides of the right angle triangle
         b = shootingAtX - playerX; 
         a = playerY - shootingAtY; 
         
         //calculating the size of the hypotenuse
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         //calculating the angle of the bullet
         theta = asin(  (a/hypotenuse) );
         
         //println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
       //  println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
       //  System.out.println("X speed of bullet: " + xSpeed); 
       //  System.out.println("Y speed of bullet: " + ySpeed); 
         
         
         if(!superPowerBullet) { players[0].activeTommy.useAmmo(1); }
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
        // bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
        // bulletsInAction++;
         
         
         Bullet tempBullet = new Bullet(xSpeed*3, ySpeed*3, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), weaponUsed.getName());
         
         playerBullets.add(tempBullet); 
         
         if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
    
         
         
      
      } else if (playerX > shootingAtX & ((players[0].activeTommy.ammo >= 1)||superPowerBullet)) { //the player is shooting to the left and up
       //  println("the player is shooting to the left and up");
         
         
         b = playerX - shootingAtX; 
         a = playerY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
        // println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
        // println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
        // System.out.println("X speed of bullet: " + xSpeed); 
       //  System.out.println("Y speed of bullet: " + ySpeed); 
         
        if(!superPowerBullet) { players[0].activeTommy.useAmmo(1); }
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
         
        // bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
        // bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
         
        // bulletsInAction++;
         
         
         Bullet tempBullet = new Bullet(xSpeed*3, ySpeed*3, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), weaponUsed.getName());
         
         playerBullets.add(tempBullet); 
         
         
         if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
         
      
      }
      
    } else if (playerY < shootingAtY & (!shotgunBullet) & ((players[0].activeTommy.ammo >= 1)||superPowerBullet)) { //the player is shooting down
   
        if(playerX <= shootingAtX) { //the player is shooting to the right and down
          // println("the player is shooting to the right and down");
           
           a = shootingAtY - playerY; 
           b = shootingAtX - playerX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
          // println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
        //   println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
         //  System.out.println("X speed of bullet: " + xSpeed); 
         //  System.out.println("Y speed of bullet: " + ySpeed); 
           
        if(!superPowerBullet) { players[0].activeTommy.useAmmo(1); }
           
        //   bullets[bulletsInAction].setSpeedX(xSpeed); 
         //  bullets[bulletsInAction].setSpeedY(ySpeed);
         //  bullets[bulletsInAction].setLocX(playerX*20); 
         //  bullets[bulletsInAction].setLocY(playerY*20);
           
         //  bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
         //  bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
        // 
        //   bulletsInAction++;
        
       Bullet tempBullet = new Bullet(xSpeed*3, ySpeed*3, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), weaponUsed.getName());
         
         playerBullets.add(tempBullet); 
         
           
           if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
           
      
        } else if (playerX > shootingAtX & ((players[0].activeTommy.ammo >= 1)||superPowerBullet)) { //the player is shooting to the left and down
          // println("the player is shooting to the left and down");
           
           
           b = playerX - shootingAtX; 
           a = shootingAtY - playerY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
         //  println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
          // println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
          // System.out.println("X speed of bullet: " + xSpeed); 
          // System.out.println("Y speed of bullet: " + ySpeed); 
           
          if(!superPowerBullet) { players[0].activeTommy.useAmmo(1); }
           
         //  bullets[bulletsInAction].setSpeedX(xSpeed); 
          // bullets[bulletsInAction].setSpeedY(ySpeed);
         //  bullets[bulletsInAction].setLocX(playerX*20); 
         //  bullets[bulletsInAction].setLocY(playerY*20);
           
         //  bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
        //   bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
        // 
         //  bulletsInAction++;
         
         Bullet tempBullet = new Bullet(xSpeed*3, ySpeed*3, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), weaponUsed.getName());
         
         playerBullets.add(tempBullet); 
         
           
           if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
           
        }
        
        checkTommySickness();
        
    }
       
    //the incoming coordinates are a shotgun bullet
    if (shotgunBullet & players[0].activeShotgun.ammo >= 1) {
      
      if (playerY >= shootingAtY) {   //the player is shooting upwards or horizontally
      
      
      if(playerX <= shootingAtX) { //the player is shooting to the right and up
       //  println("the player is shooting to the right and up");
         
         players[0].activeShotgun.useAmmo(1);
         
         
         //calculating lengths of sides of the right angle triangle
         b = shootingAtX - playerX; 
         a = playerY - shootingAtY; 
         
         //calculating the size of the hypotenuse
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         //calculating the angle of the bullet
         theta = asin(  (a/hypotenuse) );
         
        // System.out.println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
       //  println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
        // System.out.println("X speed of bullet: " + xSpeed); 
       //  System.out.println("Y speed of bullet: " + ySpeed); 
         
         if ( (theta < 0.39) ) {
           
          // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
         Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20+10);
       //  bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
      //   bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20+20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
          
          Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
         
      //   bullets[bulletsInAction].setSpeedX(xSpeed); 
     //    bullets[bulletsInAction].setSpeedY(ySpeed);
      //   bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20-10);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20-20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
         
         //extra
          Bullet tempBullet6 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet6); 
         
         Bullet tempBullet7 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet7); 
         
         Bullet tempBullet8 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet8); 
         
           
         shotGunSickness = true;
           
         
         } else { 
           
         //  bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
         //bulletsInAction++;
         
         
          Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20+10); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20+20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         
          Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20-10); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
      //   bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
      //   bulletsInAction++;
         
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20-20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
            Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
         
         
         //extra
          Bullet tempBullet6 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet6); 
         
         Bullet tempBullet7 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet7); 
         
         Bullet tempBullet8 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet8); 
         
         
         shotGunSickness = true;
           
           
         }
         
           
             
      } else if (playerX > shootingAtX) { //the player is shooting to the left and up
        // println("the player is shooting to the left and up");
         
          players[0].activeShotgun.useAmmo(1);
         
         b = playerX - shootingAtX; 
         a = playerY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
        // System.out.println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
      //   println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
        // System.out.println("X speed of bullet: " + xSpeed); 
         //System.out.println("Y speed of bullet: " + ySpeed); 
         
         
         if( (theta < 0.38) ) {
           
       //    bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
          Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20+10);
      //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20+20);
       //  bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
         Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20-10);
        // bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20-20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
           
         shotGunSickness = true;
        
         
         } else {
           
          //  bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
           Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20+10); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
         Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
         
      //   bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20+20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
            Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
        
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20-10); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
            Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20-20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
       
       Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
         shotGunSickness = true;
         
         
         
           
         }
        
      
      }
      
    } else if (playerY < shootingAtY) { //the player is shooting down
   
        if(playerX <= shootingAtX) { //the player is shooting to the right and down
         //  println("the player is shooting to the right and down");
           
            players[0].activeShotgun.useAmmo(1);
           
           a = shootingAtY - playerY; 
           b = shootingAtX - playerX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
          // System.out.println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
        //   println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
          // System.out.println("X speed of bullet: " + xSpeed); 
          // System.out.println("Y speed of bullet: " + ySpeed); 
           
           if ( (theta < 0.39) ) {
             
             //bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20+10);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20+20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
        // bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
           Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20-10);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20-20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
        // bulletsInAction++;
         
         
          Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
           
           shotGunSickness = true;
           
          
           } else {
             
             // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
           Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20+10); 
        // bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20+20); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
      
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20-10); 
        // bullets[bulletsInAction].setLocY(playerY*20);
        // bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20-20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
      //   bulletsInAction++;
         
         
         Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
         shotGunSickness = true;
         
             
           }
         
    
      
        } else if (playerX > shootingAtX) { //the player is shooting to the left and down
          // println("the player is shooting to the left and down");
           
           
            players[0].activeShotgun.useAmmo(1);
           
           
           b = playerX - shootingAtX; 
           a = shootingAtY - playerY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
         //  System.out.println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
        //   println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
          // System.out.println("X speed of bullet: " + xSpeed); 
          // System.out.println("Y speed of bullet: " + ySpeed); 
           
           if( (theta < 0.38) ) {
             
            // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
        // bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
        // bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20+10);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
      //   bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20+20);
       //  bullets[bulletsInAction].status = true;
         
      //   bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
      //  bulletsInAction++;
         
         
         Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20+20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
        // bullets[bulletsInAction].setLocX(playerX*20); 
       //  bullets[bulletsInAction].setLocY(playerY*20-10);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-10, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
        // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
        // bullets[bulletsInAction].setLocY(playerY*20-20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
      //   bulletsInAction++;
         
         
          Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20-20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
         
         
         shotGunSickness = true;
           
           
         
           } else {
             
             // bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20); 
      //   bullets[bulletsInAction].setLocY(playerY*20);
      //   bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
      //   bulletsInAction++;
         
         Bullet tempBullet = new Bullet(xSpeed*2, ySpeed*2, playerX*20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet); 
         
         
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20+10); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
          Bullet tempBullet2 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet2); 
         
       //  bullets[bulletsInAction].setSpeedX(xSpeed); 
       //  bullets[bulletsInAction].setSpeedY(ySpeed);
       //  bullets[bulletsInAction].setLocX(playerX*20+20); 
       //  bullets[bulletsInAction].setLocY(playerY*20);
       //  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
       //  bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         Bullet tempBullet3 = new Bullet(xSpeed*2, ySpeed*2, playerX*20+20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet3); 
         
  
      //   bullets[bulletsInAction].setSpeedX(xSpeed); 
      //   bullets[bulletsInAction].setSpeedY(ySpeed);
      //   bullets[bulletsInAction].setLocX(playerX*20-10); 
      //   bullets[bulletsInAction].setLocY(playerY*20);
       ///  bullets[bulletsInAction].status = true;
         
       //  bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
      //   bulletsInAction++;
         
         
          Bullet tempBullet4 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-10, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet4); 
         
         
         
      //   bullets[bulletsInAction].setSpeedX(xSpeed); 
      //   bullets[bulletsInAction].setSpeedY(ySpeed);
      //   bullets[bulletsInAction].setLocX(playerX*20-20); 
      //   bullets[bulletsInAction].setLocY(playerY*20);
      //   bullets[bulletsInAction].status = true;
         
      //   bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
      //   bullets[bulletsInAction].setShotFrom("Shotgun");
       //  bulletsInAction++;
         
         
         Bullet tempBullet5 = new Bullet(xSpeed*2, ySpeed*2, playerX*20-20, playerY*20, true, weaponUsed.getMaxDamage(), "Shotgun");
         
         playerBullets.add(tempBullet5); 
             
             shotGunSickness = true; 
             
             
           }
         
     
           
        }
        
    }
      
      
      
      
      
      
    }
    
  }
  
  void checkTommySickness() {
    
    
  }
  
  void grantShottyAmmo(int frame) {
    
    if(frame == 0) {
      
      players[0].activeShotgun.addAmmo(1);
      
    }
    
    
  }
  
  void drawRobotBullets() {
    
    //for each flower bullet currently in service
    for(int i = 0; i < robotBullets.size(); i++) {
      
      if(robotBullets.get(i).getStatus()) {
      
 
        fill(#F01B1B);
        
        robotBullets.get(i).setXC(robotBullets.get(i).getXC() + robotBullets.get(i).getSpeedX()); 
        robotBullets.get(i).setYC(robotBullets.get(i).getYC() + robotBullets.get(i).getSpeedY());
        
        //rect(robotBullets.get(i).getXC()+10, robotBullets.get(i).getYC()+10, robotBullets.get(i).getSize()+5, robotBullets.get(i).getSize()+5);
        
        circle(robotBullets.get(i).getXC()+10, robotBullets.get(i).getYC()+10, 10);
      
      }
    }
    
    
    
  }
  
  
  
  void drawFlowerBullets() {
    
    //for each flower bullet currently in service
    for(int i = 0; i < flowerBullets.size(); i++) {
      
      if(flowerBullets.get(i).getStatus()) {
      
 
        fill(#F01B1B);
        
        flowerBullets.get(i).setXC(flowerBullets.get(i).getXC() + flowerBullets.get(i).getSpeedX()); 
        flowerBullets.get(i).setYC(flowerBullets.get(i).getYC() + flowerBullets.get(i).getSpeedY());
        
        rect(flowerBullets.get(i).getXC()+10, flowerBullets.get(i).getYC()+10, flowerBullets.get(i).getSize()+5, flowerBullets.get(i).getSize()+5);
      
      }
    }
    
    
    
  }
  
  
  void drawBullets() {
    
    for(int i = 0; i < playerBullets.size(); i++) {
      
        if(playerBullets.get(i).status) {
        fill(#002AF2);
        
      
        playerBullets.get(i).timesAnimated = playerBullets.get(i).timesAnimated + 1;
        
        if( (playerBullets.get(i).timesAnimated == 6) & (playerBullets.get(i).getShotFrom() == "Shotgun")) {
          
          playerBullets.get(i).status = false;
          //this.checkBulletRedundancy();
        }
      
        if(playerBullets.get(i).status) {
        playerBullets.get(i).xCoor += (playerBullets.get(i).speedX); 
        playerBullets.get(i).yCoor += (playerBullets.get(i).speedY);
        }
        //line(i*20+10,j*20+10,i*20,j*20);
      
        circle(playerBullets.get(i).xCoor,playerBullets.get(i).yCoor,bulletSize);
       // line(bullets[i].xCoor,bullets[i].yCoor,bullets[i].xCoor-5,bullets[i].yCoor+5);
      
      }
    }
    
  }
      
      
      
 
  //gives the player the appropriate weapon based on where they clicked on the GUI
  //check for correct balance and remove materials from player in this function
  //wood weapons not implemented yet (implement once durability feature of weapons is introduced)
  void giveWeapon(String s) {
    
    if(s.equals("Iron Tommy")) {
      
      if(players[0].getIronAmount() >= weaponAvailable[1].getCost()) {
        
        println("Giving Iron Tommy"); 
        players[0].setTommy(weaponAvailable[1]); 
        players[0].addIron(-100); 
        
      }
      
    } else if (s.equals("Gold Tommy")) {
      
      if(players[0].getGoldAmount() >= weaponAvailable[2].getCost()) {
        
        println("Giving Gold Tommy"); 
        players[0].setTommy(weaponAvailable[2]); 
        players[0].addGold(-100); 
        
      }
      
    } else if (s.equals("Iron Shotgun")) {
      
      if(players[0].getIronAmount() >= weaponAvailable[4].getCost()) {
        
        println("Giving Iron Shotgun"); 
        players[0].setShotgun(weaponAvailable[4]); 
        players[0].getShotty().setMaxDamage(300);
        players[0].addIron(-100); 
        
      }
      
    } else if (s.equals("Gold Shotgun")) {
      
      
       if(players[0].getGoldAmount() >= weaponAvailable[5].getCost()) {
        
        println("Giving Gold Shotgun"); 
        players[0].setShotgun(weaponAvailable[5]); 
        players[0].addGold(-100); 
        
      }
      
    }
  }
  
  
  void addSuperPowerAnimateTick(int animateTick) {
    
     animateTick = (int) animateTick/9;
    //for each animateTick that is to be added ontop of the potion box
    for(int i = 0; i < animateTick; i++) {
      
      fill(100); 
      rect(320,890-i,80,1);
      
    }
    
    
  }
  
  //adds one of 300 ticks to the potion regeneration animation
  void addPotionAnimateTick(int animateTick) {
    
    animateTick = (int) animateTick/3;
    //for each animateTick that is to be added ontop of the potion box
    for(int i = 0; i < animateTick; i++) {
      
      fill(100); 
      rect(410,890-i,80,1);
      
    }
    
  }
  
  void addTommyGunAnimateTick(int animateTick) {
    
    if(animateTick == 80) {
      this.tommyGunSickness = false; 
      this.tommyGunAnimationTick = 0; 
      players[0].activeTommy.addAmmo(players[0].activeTommy.getClipSize());
    }
    
    for(int i = 0; i < animateTick; i++) {
      fill(1000); 
      rect(50,890-i,80,1);
      
    }
    
    this.tommyGunAnimationTick = this.tommyGunAnimationTick + 1;
    
    
    
    
  }
  
  //adds one of __ ticks to the shotgun regenaration animation
  void addShotGunAnimateTick(int animateTick) {
    //System.out.println("animating");
    
    if(animateTick == 60) {
      this.shotGunSickness = false; 
      this.shotGunAnimationTick = 0; 
    }
    
    for(int i = 0; i < animateTick; i++) {
      fill(1000); 
      rect(140,890-i,80,1);
      
    }
    
    this.shotGunAnimationTick = this.shotGunAnimationTick + 1; 
    
  }
  
  void checkAnimations() {
    
    if(this.shotGunSickness) {
      addShotGunAnimateTick(this.shotGunAnimationTick);
    }
    
    if(this.tommyGunSickness) {
      addTommyGunAnimateTick(this.tommyGunAnimationTick);
    }
    
    
  }
  
  void addPlayer(Player p) {
    players[0] = p;
    players[0].setWeapons(weaponAvailable[0], weaponAvailable[3]);
  }
  
  //displays the heads up display for the user
  void hud(Player player) {
    
    //START: makes the iron, gold, wood and score amounts appear
    rectMode(CENTER);
    fill(#E6ED35);
    rect(935,830,50,30);
    
    fill(0);
    text("Gold",920,830);
    text(playerone.goldAmount,985,830);
    
    
    fill(#B2A89C);
    rect(935,870,50,30);
    
    fill(0);
    text("Iron",920,870);
    text(playerone.ironAmount,985,870);
    
    fill(#397619);
    rect(1050,830,50,30);
    
    fill(0);
    text("Wood",1035,830);
    text(playerone.woodAmount,1100,830);
    
    fill(0); 
    text("Score",1035,870);
    text(playerone.score,1100,870);
    
    //END: make the iron, gold, wood and score amounts appear
    
    //START: makes the build options available
    //show the wood options
    if(playerone.woodAmount >= 100) {
       armorAvailable[0].setBuildable(true);
       weaponAvailable[0].setBuildable(true); 
       weaponAvailable[3].setBuildable(true);
    } else {
       
    }
    
    //show the iron options
    if(playerone.ironAmount >= 100) {
       armorAvailable[1].setBuildable(true);
       weaponAvailable[1].setBuildable(true); 
       weaponAvailable[4].setBuildable(true);
    } else {
      
    }
    
    //show the gold options
    if(playerone.goldAmount >= 100) {
       armorAvailable[2].setBuildable(true);
       weaponAvailable[2].setBuildable(true); 
       weaponAvailable[5].setBuildable(true);
    } else {
      
    }
    
    //set the buildable values of the armor based on the players available materials
    if(armorAvailable[0].getCost() > players[0].getWoodAmount()) {
      armorAvailable[0].setBuildable(false); 
    } 
    if(armorAvailable[1].getCost() > players[0].getIronAmount()) {
      armorAvailable[1].setBuildable(false); 
    }
    if(armorAvailable[2].getCost() > players[0].getGoldAmount()) {
      armorAvailable[2].setBuildable(false);
    }
    
    //makes the boxes for the available armors to be selected
    for(int i = 0; i < 3; i++) {
      if(armorAvailable[i].buildable) {
        fill(armorAvailable[i].colour);
        rect(1160+i*60, 820, 50, 20);
        fill(0);
        text("Armor", 1140+i*60, 825);
      }
    }
    
    //set the buildable values of the weapons based on the players available materials
    if(weaponAvailable[0].getCost() > players[0].getWoodAmount()) {
      weaponAvailable[0].setBuildable(false); 
    } 
    if(weaponAvailable[1].getCost() > players[0].getIronAmount()) {
      weaponAvailable[1].setBuildable(false); 
    }
    if(weaponAvailable[2].getCost() > players[0].getGoldAmount()) {
      weaponAvailable[2].setBuildable(false);
    }
    
    //makes the boxes for the available tommy guns to be selected
    for(int i = 0; i < 3; i++) {
      if(weaponAvailable[i].buildable) {
        fill(weaponAvailable[i].colour);
        rect(1160+i*60, 850, 50, 20);
        fill(0);
        text("Tommy", 1140+i*60, 855);
      }
    }
    
    //set the buildable values of the weapons based on the players available materials
    if(weaponAvailable[3].getCost() > players[0].getWoodAmount()) {
      weaponAvailable[3].setBuildable(false); 
    } 
    if(weaponAvailable[4].getCost() > players[0].getIronAmount()) {
      weaponAvailable[4].setBuildable(false); 
    }
    if(weaponAvailable[5].getCost() > players[0].getGoldAmount()) {
      weaponAvailable[5].setBuildable(false);
    }
    
    //makes the boxes for the available shot guns to be selected
    for(int i = 3; i < 6; i++) {
      if(weaponAvailable[i].buildable) {
        fill(weaponAvailable[i].colour);
        rect(1160+(i-3)*60, 880, 50, 20);
        fill(0);
        text("Shotgun", 1140+(i-3)*60, 885);
      }
    }
    
    //END: makes the build options available
    
    //START: makes the toolbar appear
    //tommy gun box
    fill(#B2A89C);
    fill(player.activeTommy.colour);
    if(player.active == 1) {
      fill(#00FCE5);
    } 
    rect(50,850,80,80);
    fill(0);
    
    if(player.activeTommy.tier=="Wood") {
    
       image(imageList[27],12,850);
       
    } else if (player.activeTommy.tier=="Iron") {
       
       image(imageList[28],12,850);
       
    } else {
       
       image(imageList[29],12,850);
       
    }
    
    //text("Gun",40,850);
    text(""+player.activeTommy.ammo,40,830);
    
    
    
    
    fill(#B2A89C);
    
    //shotgun box
    fill(player.activeShotgun.colour);
    if(player.active == 2) {
      fill(#00FCE5);
    }
    rect(140,850,80,80);
    fill(0);
    
    if(player.activeShotgun.tier=="Wood") {
    
       image(imageList[30],104,850);
       
    } else if (player.activeShotgun.tier=="Iron") {
       
       image(imageList[31],104,850);
       
    } else {
       
       image(imageList[32],104,850);
       
    }
    
    
    //text("Shotgun",120,850);
    text(""+player.activeShotgun.ammo,120,830);
    fill(#B2A89C);
    
    
    //pickaxe box
    if(player.active == 3) {
      fill(#00FCE5);
    } 
    rect(230,850,80,80);
    fill(0); 
    
    
    //pickaxe image
    image(imageList[26],197,817); 
    
    //text("Pickaxe",210,850);
    fill(#B2A89C);
    
    //hammer box
    if(player.active == 4) {
      fill(#00FCE5);
    } 
    rect(320,850,80,80);
    fill(0);
    
    //superpower image
    image(imageList[40],287,817);
    
    fill(#B2A89C);
    
    //potion box
    if(player.active == 5) {
      fill(#00FCE5);
    } else {
      fill(#B2A89C);
    }
    rect(410,850,80,80);
    fill(0);
    
    //potion image
    image(imageList[25],377,817);
    
    //text("Potion",400,850);
    fill(#B2A89C);
    //END: makes the toolbar appear
    
    
    //START: makes the health bar appear
    //health
    fill(255,0,0); 
    for(int i = 0; i < player.getHealth(); i++) {
      rect(480+(i*2),870,2,30);
    }
    
    //shield
    fill(0,0,255);
    for(int i = 0; i < player.getShield(); i++) {
      rect(480+(i*2),830,2,30);
    }
    //END: makes the health bar appear
    
  }
  
  //this displays all of the tiles on the gameboard
  void display() {
    
    
    //display all of the blocks
    for(int i = 0; i < 70; i++) {
      
      for(int j = 0; j < 40; j++) {
         fill(tiles[j][i].getColour());
         
         tiles[j][i].setXCoor(i*20+10);
         tiles[j][i].setYCoor(j*20+10);
         
         tiles[j][i].setIndexI(j);
         tiles[j][i].setIndexJ(i);
         
         //if the tile has already been mined
         if(tiles[j][i].health <= 0) {
           fill(#A0681F); 
           tiles[j][i].nothing();
         }
      
         
         
         //rect(i*20+10,j*20+10,20,20);
         
         
         //if the tile has been hit once
         //if(tiles[j][i].health == 75) {
           //line(i*20+10,j*20+10,i*20,j*20);
         //}
         //if the tile has been damaged halfway
         //if(tiles[j][i].health == 50) {
           //line(i*20+20,j*20+20,i*20,j*20);
         //}
         //if the tile has been damaged 3/4 of the way
        // if(tiles[j][i].health == 25) {
           //line(i*20+20,j*20+20,i*20,j*20);
           //line(i*20+20,j*20,i*20,j*20+20);
         //}
      }
    }
    
    
    showImages();
 }
 
 
 void generateBiome() {
   
   //reset the difficulty for the new biome's enemies to progress
   difficulty = 0; 
   
   Random r = new Random();
   
   System.out.println("Generating new biome");
    
   int streamSize = 2800; 
   int start = 0; 
   int bound = 2799; 
   int goldBound = 100;
   int ironBound = 200;
   int goldMin = 25; 
   int ironMin = 50;
   int resourceXYMin = 2; //so that cluster placed resources dont out of bounds error 
   int lavaMin = 50; 
   int lavaBound = 200;
   
   
   //generateBiome is only called after the initial biome has been defeated so the player should now have access to the potion and superpower upgrades
   int potionUpgradeMin = 10; 
   int potionUpgradeBound = 20;
   
   
   int superPowerMin = 10; 
   int superPowerBound = 20; 
    
   r.ints(streamSize, start, bound);
   
   //initialize all of the tiles in the array used to represent our gameboard
    for(int i = 0; i < 40; i++) {
      
      for(int j = 0; j < 70; j++) {
        tiles[i][j] = new Tile();
      }
      
    }
   
   
   //GENERATE THE NEW BIOME
   //reset all of the pieces to steel default
   for (int i = 0; i < 70; i++) {
     
     for(int j = 0; j < 40; j++) {
       
       tiles[j][i].steel();
       
     }
     
   }
   
   //GOLD GENERATION
    int goldPieces = r.nextInt(goldBound+1-goldMin) + goldMin;
    //println("gold pieces" + goldPieces);
    
    int goldplaceCounter = 0;
    
    int goldClusters = goldPieces/5; 
    
    //println("gold clusters" + goldClusters);
    while(goldplaceCounter < goldClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].gold();
      tiles[x+1][y+1].gold();
      tiles[x-1][y-1].gold();
      tiles[x][y+1].gold();
      tiles[x][y-1].gold();
      tiles[x+1][y].gold();
      tiles[x-1][y].gold();
      
      goldplaceCounter++;
    }
    //GOLD GENERATION DONE
    //IRON GENERATION
    int ironPieces = r.nextInt(ironBound+1-ironMin) + ironMin;
    //println("iron pieces" + ironPieces);
    
    int ironplaceCounter = 0;
    
    int ironClusters = ironPieces/5; 
    
    //println("iron clusters" + ironClusters);
    while(ironplaceCounter < ironClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].iron();
      tiles[x+1][y+1].iron();
      tiles[x-1][y-1].iron();
      tiles[x][y+1].iron();
      tiles[x][y-1].iron();
      tiles[x+1][y].iron();
      tiles[x-1][y].iron();
      
      ironplaceCounter++;
    }
    //IRON GENERATION DONE
    
    
    
    //LAVA GENERATION
    int lavaPieces = r.nextInt(lavaBound+1-lavaMin) + lavaMin;
    //println("lava tiles" + lavaPieces);
    
    int lavaplaceCounter = 0;
    
    int lavaClusters = lavaPieces/5; 
    
    //println("lava clusters" + lavaClusters);
    while(lavaplaceCounter < lavaClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].lava();
      tiles[x+1][y+1].lava();
      tiles[x-1][y-1].lava();
      tiles[x][y+1].lava();
      tiles[x][y-1].lava();
      tiles[x+1][y].lava();
      tiles[x-1][y].lava();
      
      lavaplaceCounter++;
    }
    //LAVA GENERATION DONE
    
    
    //SUPER POWER UPGRADE GENERATION
    int superPowerPieces = r.nextInt(superPowerBound+1-superPowerMin) + superPowerMin;
    //println("lava tiles" + lavaPieces);
    
    int superPowerplaceCounter = 0;
    
    int superPowerClusters = superPowerPieces/5; 
    
    //println("lava clusters" + lavaClusters);
    while(superPowerplaceCounter < superPowerClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].superPower();
      tiles[x+1][y+1].superPower();
      tiles[x-1][y-1].superPower();
      tiles[x][y+1].superPower();
      tiles[x][y-1].superPower();
      tiles[x+1][y].superPower();
      tiles[x-1][y].superPower();
      
      superPowerplaceCounter++;
    }
    
    
    
    
    //SUPER POWER UPGRADE GENERATION DONE
    
    
    //POTION UPGRADE GENERATION
    int potionUpgradePieces = r.nextInt(potionUpgradeBound+1-potionUpgradeMin) + potionUpgradeMin;
    //println("lava tiles" + lavaPieces);
    
    int potionUpgradeplaceCounter = 0;
    
    int potionUpgradeClusters = potionUpgradePieces/5; 
    
    //println("lava clusters" + lavaClusters);
    while(potionUpgradeplaceCounter < potionUpgradeClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].potionUpgrade();
      tiles[x+1][y+1].potionUpgrade();
      tiles[x-1][y-1].potionUpgrade();
      tiles[x][y+1].potionUpgrade();
      tiles[x][y-1].potionUpgrade();
      tiles[x+1][y].potionUpgrade();
      tiles[x-1][y].potionUpgrade();
      
      potionUpgradeplaceCounter++;
    }
    
    
    
    
    
    //POTION GENERATION DONE
   
   this.currentBiome = "steel";
   
   plantTreesInSteelBiome();
   
 }
 
 
  void createMap() {
    Random r = new Random();
    
    int streamSize = 2800; 
    int start = 0; 
    int bound = 2799; 
    int goldBound = 100;
    int ironBound = 200;
    int goldMin = 35; 
    int ironMin = 75;
    int resourceXYMin = 2; //so that cluster placed resources dont out of bounds error 
    int lavaMin = 30; 
    int lavaBound = 100;
    
    r.ints(streamSize, start, bound);
    
    
    //GENERATE THE MAP
    //GOLD GENERATION
    int goldPieces = r.nextInt(goldBound+1-goldMin) + goldMin;
    //println("gold pieces" + goldPieces);
    
    int goldplaceCounter = 0;
    
    int goldClusters = goldPieces/5; 
    
    //println("gold clusters" + goldClusters);
    while(goldplaceCounter < goldClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].gold();
      tiles[x+1][y+1].gold();
      tiles[x-1][y-1].gold();
      tiles[x][y+1].gold();
      tiles[x][y-1].gold();
      tiles[x+1][y].gold();
      tiles[x-1][y].gold();
      
      goldplaceCounter++;
    }
    //GOLD GENERATION DONE
    
    
    //IRON GENERATION
    int ironPieces = r.nextInt(ironBound+1-ironMin) + ironMin;
    //println("iron pieces" + ironPieces);
    
    int ironplaceCounter = 0;
    
    int ironClusters = ironPieces/5; 
    
    //println("iron clusters" + ironClusters);
    while(ironplaceCounter < ironClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].iron();
      tiles[x+1][y+1].iron();
      tiles[x-1][y-1].iron();
      tiles[x][y+1].iron();
      tiles[x][y-1].iron();
      tiles[x+1][y].iron();
      tiles[x-1][y].iron();
      
      ironplaceCounter++;
    }
    //IRON GENERATION DONE
    
    
    
    //LAVA GENERATION
    int lavaPieces = r.nextInt(lavaBound+1-lavaMin) + lavaMin;
    //println("lava tiles" + lavaPieces);
    
    int lavaplaceCounter = 0;
    
    int lavaClusters = lavaPieces/5; 
    
    //println("lava clusters" + lavaClusters);
    while(lavaplaceCounter < lavaClusters) {
      
      int x = r.nextInt(39-resourceXYMin) + resourceXYMin;
      int y = r.nextInt(69-resourceXYMin) + resourceXYMin;
      
      tiles[x][y].lava();
      tiles[x+1][y+1].lava();
      tiles[x-1][y-1].lava();
      tiles[x][y+1].lava();
      tiles[x][y-1].lava();
      tiles[x+1][y].lava();
      tiles[x-1][y].lava();
      
      lavaplaceCounter++;
    }
    //LAVA GENERATION DONE
 
    //tiles[0][0].showYourself();
    //tiles[1][0].showYourself();
    //tiles[0][1].showYourself();
    //tiles[39][69].showYourself();
    
    System.out.println("map generated"); 
   
    plantTrees();
    
    
    
  }
  
  void displayPlayers() {
    
    
    
  }
  
  void showImages() {
    
    for(int i = 0; i<40; i++) {
       
        for(int j = 0; j<70; j++) {
          
          tiles[i][j].hasPlayer = false;
          
        }
        
    }
    
    //find where the player is standing
    int playerI; 
    int playerJ; 
    
    playerI = players[0].indexI; 
    playerJ = players[0].indexJ;
    
    tiles[playerI][playerJ].hasPlayer = true; 
    
    for(int i = 0; i<40; i++) {
       
        for(int j = 0; j<70; j++) {
          
          //rect(i*20+10,j*20+10,20,20);
          
          if(tiles[i][j].getType().equals("Tree")) {
            
            if(tiles[i][j].getHealth() == 100) {
              image(imageList[0],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 75) {
              image(imageList[1],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 50) {
              image(imageList[2],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 25) {
              image(imageList[3],j*20,i*20);
            }
              
              
          } else if (tiles[i][j].getType().equals("Iron")) {
            
            if(tiles[i][j].getHealth() == 100) {
              image(imageList[4],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 75) {
              image(imageList[5],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 50) {
              image(imageList[6],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 25) {
              image(imageList[7],j*20,i*20);
            }
            
             
              
          } else if (tiles[i][j].getType().equals("Gold")) {
            
            if(tiles[i][j].getHealth() == 100) {
              image(imageList[8],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 75) {
              image(imageList[9],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 50) {
              image(imageList[10],j*20,i*20);
            } else if (tiles[i][j].getHealth() == 25) {
              image(imageList[11],j*20,i*20);
            }
             
          } else if (tiles[i][j].getType().equals("Lava")) {
            
            image(imageList[12],j*20,i*20);
            
          } else if (tiles[i][j].getType().equals("Dirt")) {
          
            image(imageList[13],j*20,i*20);
            
          } else if (tiles[i][j].getType().equals("Nothing")) {
            
            image(imageList[14],j*20,i*20);
            
          } else if (tiles[i][j].getType().equals("Steel")) {
            
            image(imageList[34],j*20,i*20);
            
          } else if (tiles[i][j].getType().equals("SuperPower")) {
            
            image(imageList[36],j*20,i*20); 
            
          } else if (tiles[i][j].getType().equals("PotionUpgrade")) {
            
            image(imageList[35],j*20,i*20);
            
          }
            
        }
        
    }
    
    //places the player in their spot
    image(imageList[15],playerJ*20,playerI*20);
      
  }
  
  void plantTrees() {
    int choice = 0;
    //TREE GENERATION START
    
    //start by finding all of the remaining spots that are not filled in, they are dirt. 
    //only plant trees once per match
    if(!plantedTrees) {
      println("Planting trees");
    
      for(int i = 0; i<40; i++) {
       
        for(int j = 0; j<70; j++) {
        
          //if the tile is dirt
          if(tiles[i][j].getType().equals("Dirt")) {
          
            //choose between 0,1,2,3,4,5,6
            choice = (int) random(7);
          
            //turn one seventh (probabilistically) of the dirt tiles to a tree tile
            if(choice == 0) {
               tiles[i][j].tree(); 
            }
            
          }
        
        
        }
      
      }
      plantedTrees = true;
    }
    
    
      //TREE GENERATION DONE
      
      
    
  }
  
  
  void plantTreesInSteelBiome() {
    
    int choice = 0;
    //TREE GENERATION START
    
    //start by finding all of the remaining spots that are not filled in, they are steel. 
    //only plant trees once per biome creation
    if(!plantedTreesInSteel) {
      println("Planting trees in steel");
    
      for(int i = 0; i<40; i++) {
       
        for(int j = 0; j<70; j++) {
        
          //if the tile is dirt
          if(tiles[i][j].getType().equals("Steel")) {
          
            //choose between 0,1,2,3,4,5,6 ... 15
            choice = (int) random(16);
          
            //turn one sixteenth (probabilistically) of the steel tiles to a tree tile
            if(choice == 0) {
               tiles[i][j].tree(); 
            }
            
          }
        
        
        }
      
      }
      plantedTreesInSteel = true;
    }
    
    
  }
  
 
}
