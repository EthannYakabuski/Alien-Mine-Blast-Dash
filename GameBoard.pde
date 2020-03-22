import java.util.Random;
PFont f;

boolean plantedTrees = false;

boolean collision = false; 


class GameBoard {
  
  //2D 40x70 array of tile objects to represent the game board
  Tile[][] tiles = new Tile[40][70];
  Player[] players = new Player[10];
  PImage[] imageList; 
  
  int bulletSize = 10; 
  int score = 0; 
  
  boolean shotGunSickness = false;
  int shotGunAnimationTick = 0;
  
  boolean tommyGunSickness = false; 
  int tommyGunAnimationTick = 0; 
  
  //arrays to store items available for build
  //allocated with the max possible amount of available build options because they are very small in size
  Armor[] armorAvailable = new Armor[3];     //wood, iron, gold 
  Weapon[] weaponAvailable = new Weapon[6]; //wood, iron, gold versions of shotgun and tommy gun respectively
  
  //maximum number of bullets at once is 200,000 if there are any more then this
  
  //-> functionality needed: dump all bullets not on screen and restart bullet numbering
  
  //contains all of the bullets currently flying through the air
  Bullet[] bullets = new Bullet[20000];
  int bulletsInAction = 0; 
  
  
  //contains all of the flower bullets currently flying through the air
  ArrayList<FlowerBullet> flowerBullets = new ArrayList<FlowerBullet>();
  
  
  //contains all of the robot bullets currently flying through the air
  ArrayList<RobotBullet> robotBullets = new ArrayList<RobotBullet>();
  
  
  //difficulty tracker
  int difficulty = 0; 
  int difficultyStepper = 6; 
  int difficultyStepperFlower = 6;
  int difficultyStepperRobot = 6;
  
  //contations all of the enemies currently on the screen
  
  //TESTING ENEMIES
  //Enemy[] enemies = new Enemy[1000];
  int enemiesInAction = 1; 
  
  ArrayList<Enemy> enemies = new ArrayList<Enemy>(); 
  
  
  //TESTING ENEMIES
  boolean initialEnemies = false; 
  
  boolean spawningFlowers = false;
  boolean spawningRobots = false;
  
  Random r;
  
  int spawner = 0; 
  
  int flowerSpawner = 0;
  
  int robotSpawner = 0; 
  

  
     
    
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
    weaponAvailable[0] = new Weapon("Wood", "Wood Tommy", 5, 5, false, 100, 9, 40, 40, #836835, "Tommy"); 
    weaponAvailable[1] = new Weapon("Iron", "Iron Tommy", 7, 7, false, 100, 9, 50, 50, #B2A89C, "Tommy");
    weaponAvailable[2] = new Weapon("Gold", "Gold Tommy", 10, 10, false, 100, 10, 60, 60, #E6ED35, "Tommy");
    
    weaponAvailable[3] = new Weapon("Wood", "Wood Shotgun", 25, 25, false, 100, 3, 10, 2, #836835, "Shotgun");
    weaponAvailable[3].ammo = 20;
    weaponAvailable[4] = new Weapon("Iron", "Iron Shotgun", 50, 50, false, 100, 3, 10, 2, #B2A89C, "Shotgun");
    weaponAvailable[4].ammo = 20;
    weaponAvailable[5] = new Weapon("Gold", "Gold Shotgun", 75, 75, false, 100, 3, 12, 2, #E6ED35, "Shotgun");
    weaponAvailable[5].ammo = 20;
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
    }
      
    }
    
  }
  
  //this function will spawn a new enemy somewhere on the map
  void spawnAnEnemy(int frame) {
    
    //System.out.println("Frame: " + frame); 
    
    difficulty = difficulty + 1; 
    
    //after one minute, adjust the spawn rate of ants
    if(difficulty == 1800) {
      //speed up the ant spawn
      difficultyStepper = 4; 
    }
    
    //after two minutes, adjust the spawn rate of ants
    if(difficulty == 3600) {
      //speed up the ant spawn
      difficultyStepper = 2; 
    }
    
    //after 3 minutes, start spawning flower enemies and slow down ant spawns
    if(difficulty == 5400) {
      //slow down the ants a bit for now
      difficultyStepper = 4;
      difficultyStepperFlower = 6; 
      spawningFlowers = true;
    }
    
    //after 4 minutes, adjust the spawn rate of ants to be quicker again, and flowers to be quicker too
    if(difficulty == 7200) {
      //speed up the ant spawn
      difficultyStepper = 2;
      difficultyStepperFlower = 4; 
      spawningFlowers = true;
    }
    
    //after 5 minutes, adjust the spawn rate of flowers
    if(difficulty == 9000) {
      difficultyStepperFlower = 2;
      spawningFlowers = true;
      
    }
    
    //after 6 minutes, stop spawning enemies, let player empty the screen
    if(difficulty == 10800) {
      difficultyStepper = 100;
      difficultyStepperFlower = 100; 
      spawningFlowers = false; 
      spawningRobots = false; 
    }
    
    
    //after 7 minutes, start spawning robots
    if(difficulty == 12600) {
      spawningRobots = true;
      difficultyStepperRobot = 6; 
    }
    
    
    //after 8 minutes, start spawning ants and flowers again
    if(difficulty == 14400) {
       difficultyStepper = 4; 
       difficultyStepperFlower = 4; 
       spawningFlowers = true; 
    }
    
    //after 9 minutes, increase ants and flowers to max spawn rate
    if(difficulty == 16200) {
      difficultyStepper = 2; 
      difficultyStepperFlower = 2; 
      spawningFlowers = true; 
    }
    
    //after 10 minutes, start spawning more robots
    if(difficulty == 18000) {
      difficultyStepperRobot = 4; 
    }
    
    //after 11 minutes, max spawn rate of robots
    if(difficulty == 19800) {
      difficultyStepperRobot = 2;  
    }
    
    //after 12 minutes, stop spawning robots
    if(difficulty == 21600) {
      spawningRobots = false; 
    }
    
    //after 13 minutes, stop spawning other enemies let player clear the screen
    if(difficulty == 23400) {
      spawningFlowers = false; 
      difficultyStepper = 100;
      
    }
    
    //after 14 minutes continue spawning all enemies at max rate
    
    
    //after 10,000 score spawn a Phalax
    
    
    //after Phalax is half health start spawning ants again at max speed, and flowers somewhat slow
    
    
    //after Phalax is 1/3 health, stop spawning all enemies
    
    
    //after the user beats the Phalax, award score and enter ENDLESS MODE
    
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
      
      if( (robotSpawner%difficultyStepperRobot) == 0) {
        System.out.println("Spawning a new enemy ROBOT at: (" + spawnX + "," + spawnY + ")");
        
        //spawn a flower here
        Robot tempRobot = new Robot(spawnX, spawnY);
        
        //add it to the enemies list
        enemies.add(tempRobot);
        
      }
      
    }
    
    
  }
  
  
  //this function will call all of the current enemies movement function in order to update their attributes
  void moveEnemies(int frame) {
    
    //System.out.println("Frame: "+ frame);
    
    //make a decision to move 4 times a second
    if(frame==0 | frame==10 | frame==20 | frame==30) {
    
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
       if(enemies.get(i).health <= 0) { enemies.get(i).status = false; }
    }
    
  }
  
  //this function will draw all of the current enemies using the new updated attributes
  void showEnemies() {
   
    for(int i = 0; i < enemies.size(); i++) {
      //System.out.println("Showing an enemy"); 
      if(enemies.get(i).status & enemies.get(i).getEnemyType().equals("Ant")) {
        if(enemies.get(i).health > 75) {
          image(imageList[16], enemies.get(i).xC, enemies.get(i).yC);
        } else if ( (enemies.get(i).health <= 75) & (enemies.get(i).health > 50)) {
          image(imageList[17], enemies.get(i).xC, enemies.get(i).yC);  
        } else if(enemies.get(i).health <= 50 & (enemies.get(i).health > 0)) {
          image(imageList[18], enemies.get(i).xC, enemies.get(i).yC);
        } else if(enemies.get(i).health <= 0) {
          enemies.get(i).die();
        }
      
      }
    }
    
    for(int i = 0; i < enemies.size(); i++) {
      //System.out.println("Showing an enemy"); 
      if(enemies.get(i).status & enemies.get(i).getEnemyType().equals("Flower")) {
        if(enemies.get(i).health > 75) {
          image(imageList[19], enemies.get(i).xC, enemies.get(i).yC);
        } else if ( (enemies.get(i).health <= 75) & (enemies.get(i).health > 50)) {
          image(imageList[20], enemies.get(i).xC, enemies.get(i).yC);  
        } else if(enemies.get(i).health <= 50 & (enemies.get(i).health > 0)) {
          image(imageList[21], enemies.get(i).xC, enemies.get(i).yC);
        } else if(enemies.get(i).health <= 0) {
          enemies.get(i).die();
        }
      
      }
    }
    
    for(int i = 0; i < enemies.size(); i++) {
      //System.out.println("Showing an enemy"); 
      if(enemies.get(i).status & enemies.get(i).getEnemyType().equals("Robot")) {
        if(enemies.get(i).health > 100) {
          image(imageList[22], enemies.get(i).xC, enemies.get(i).yC);
        } else if ( (enemies.get(i).health <= 100) & (enemies.get(i).health > 50)) {
          image(imageList[23], enemies.get(i).xC, enemies.get(i).yC);  
        } else if(enemies.get(i).health <= 50 & (enemies.get(i).health > 0)) {
          image(imageList[24], enemies.get(i).xC, enemies.get(i).yC);
        } else if(enemies.get(i).health <= 0) {
          enemies.get(i).die();
        }
      
      }
    }
    
  }
  
  //turns status to false of all bullets that are off the screen
  void checkBulletRedundancy() {
    for(int i = 0; i < bulletsInAction; i++) {
       bullets[i].checkStatus(); 
    }
    
    for(int i = 0; i < flowerBullets.size(); i++) {
       flowerBullets.get(i).checkStatus();
    }
    
    for(int i = 0; i < robotBullets.size(); i++) {
       robotBullets.get(i).checkStatus();
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
        System.out.println("COLLISION");
        
        //this enemy deals damage to that player if they are on the same square as them
        if(enemies.get(i).enemyType == "Ant") {
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
        
        System.out.println("Generating enemy bullet");
        //create the bullet for the flower enemy type
        if(enemies.get(i).getEnemyType() == "Flower") {
          System.out.println("Generating flower bullet"); 
          
          
          //flipped them somewhere along the line
          int targetXC = players[0].getYC()*20;
          int targetYC = players[0].getXC()*20;
          int myXC = (int)enemies.get(i).getXC();
          int myYC = (int)enemies.get(i).getYC();
          
          System.out.println("TargetXC: " + targetXC);
          System.out.println("TargetYC: " + targetYC);
          System.out.println("MYXC: " + myXC);
          System.out.println("MYYC: " + myYC);
          
          
          //add the bullet
          if(enemies.get(i).enemyType == "Flower") {
            introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7);
          } else if (enemies.get(i).enemyType == "Robot") {
            introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7);
          }
          
      
          enemies.get(i).setNeedToShoot(false);
          
        } else if (enemies.get(i).getEnemyType() == "Robot") {
          
          System.out.println("Generating robot bullet"); 
          
          
          //flipped them somewhere along the line
          int targetXC = players[0].getYC()*20;
          int targetYC = players[0].getXC()*20;
          int myXC = (int)enemies.get(i).getXC();
          int myYC = (int)enemies.get(i).getYC();
          
          System.out.println("TargetXC: " + targetXC);
          System.out.println("TargetYC: " + targetYC);
          System.out.println("MYXC: " + myXC);
          System.out.println("MYYC: " + myYC);
          
          
          //add the bullet
          if(enemies.get(i).enemyType == "Flower") {
            introduceFlowerBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7);
          } else if (enemies.get(i).enemyType == "Robot") {
            introduceRobotBullet(targetXC, targetYC, myXC, myYC, enemies.get(i).getAttack()+7);
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
    weaponAvailable[0] = new Weapon("Wood", "Wood Tommy", 5, 5, false, 100, 9, 150, 50, #836835, "Tommy"); 
    weaponAvailable[1] = new Weapon("Iron", "Iron Tommy", 7, 7, false, 100, 9, 150, 50, #B2A89C, "Tommy");
    weaponAvailable[2] = new Weapon("Gold", "Gold Tommy", 10, 10, false, 150, 10, 150, 50, #E6ED35, "Tommy");
    
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
        players[0].takeDamage(robotBullets.get(i).getDamage());
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
        players[0].takeDamage(flowerBullets.get(i).getDamage());
      }
      
    }
    
    
  }
  
  
  //checks every active bullet and every active enemy for collision
  //processor demanding
  void checkCollisions() {
     
    //System.out.println("Checking collisions"); 
    
    //for each bullet
    for(int i = 0; i < bulletsInAction; i++) {
      
      
      //for each enemy
      for (int e = 0; e < enemies.size(); e++) {
       
        //if the bullet is on the visible screen
        if(bullets[i].status) {
          //get the necessary variables in order to check collision
          float enemyX = enemies.get(e).xC;    
          float enemyY = enemies.get(e).yC;   
        
          float bulletX = bullets[i].xCoor; 
          float bulletY = bullets[i].yCoor;
          
          //System.out.println("Enemy XC: " + enemyX);
          //System.out.println("Enemy YC: " + enemyY);
          //System.out.println("Bullet XC: " + bulletX); 
          //System.out.println("Bullet YC: " + bulletY);
        
          //testing only
          //System.out.println("Collision: " + collision);
          //testing only
          
          
          //if the origin of the circle (the bullet) + the radius of the circle is within the square that is occupied by an enemy then there has been a collision
          if(  ( ((enemyX-bulletSize/2) < bulletX) & (bulletX < (enemyX+20+bulletSize/2)) ) & ( ((enemyY-bulletSize/2) < bulletY) & (bulletY < (enemyY+20+bulletSize/2)) ) ) {
            
            //println("There has been a collision");
            collision = true;
            
            //deal the damage
            
            boolean death = false;
            
            death = enemies.get(e).receiveDamage(bullets[i].getDamage());
            
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
            
          }
         
        
        }
          
        
      }
      
    }
    
    
  }
  
  
  void introduceRobotBullet(int shootingAtX, int shootingAtY, int robotX, int robotY, int damage) {
    
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
         
         println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         tempRobotBullet = new RobotBullet(xSpeed, ySpeed, 10, robotX, robotY, (int)damage/2); 
      
      } else if (robotX > shootingAtX) { //the robot is shooting to the left and up
         println("the robot is shooting to the left and up");
         
         
         b = robotX - shootingAtX; 
         a = robotY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
         println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         tempRobotBullet = new RobotBullet(xSpeed, ySpeed, 10, robotX, robotY, (int)damage/2); 
      
      }
      
    } else if (robotY < shootingAtY) { //the player is shooting down
   
        if(robotX <= shootingAtX) { //the player is shooting to the right and down
           println("the player is shooting to the right and down");
           
           a = shootingAtY - robotY; 
           b = shootingAtX - robotX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           tempRobotBullet = new RobotBullet(xSpeed, ySpeed, 10, robotX, robotY, (int)damage/2); 
           
        } else if (robotX > shootingAtX) { //the robot is shooting to the left and down
           println("the robot is shooting to the left and down");
           
           
           b = robotX - shootingAtX; 
           a = shootingAtY - robotY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           tempRobotBullet = new RobotBullet(xSpeed, ySpeed, 10, robotX, robotY, (int)damage/2); 
        }
        
    }
    
    robotBullets.add(tempRobotBullet = new RobotBullet(xSpeed, ySpeed, 10, robotX, robotY, (int)damage/2)); 
    
  }
    
  
  void introduceFlowerBullet(int shootingAtX, int shootingAtY, int flowerX, int flowerY, int damage) {
    
    println("Shooting from (" + flowerX + "," + flowerY + ")");
    println("Shooting at (" + shootingAtX + "," + shootingAtY + ")");
    
    FlowerBullet tempFlowerBullet; 
    
    //flower is shooting either up or down
    if (flowerX == shootingAtX) {
       
      //flower is directly shooting downwards
       if(flowerY < shootingAtY) {
         
         //no xSpeed
         tempFlowerBullet = new FlowerBullet(0,15,10,flowerX,flowerY, damage);
         
      
      //flower is directly shooting updwards
       } else {
         
         //no xSpeed.
         tempFlowerBullet = new FlowerBullet(0,-15,10,flowerX,flowerY, damage);
         
       }
      
     
    //flower is shooting eith left or right  
    } else {
      
      
      
      //flower is shooting directly to the left
      if (flowerX > shootingAtX) {
        
        //no ySpeed
        tempFlowerBullet = new FlowerBullet(-15,0,10,flowerX,flowerY, damage);
        
        
        
      //flower is shooting directly to the right  
      } else {
        
        //no ySpeed
        tempFlowerBullet = new FlowerBullet(15,0,10,flowerX,flowerY, damage);
        
        
      }
      
      
      
    }
    
    
    flowerBullets.add(tempFlowerBullet); 
  
        
  }
    
  
  void introduceBullet(int shootingAtX, int shootingAtY, int playerX, int playerY, Weapon weaponUsed, Boolean shotgunBullet) {
    
    println("Shooting from (" + playerX + "," + playerY + ")");
    println("Shooting at (" + shootingAtX + "," + shootingAtY + ")");
    
    
    float a = 0; 
    float b = 0; 
    float hypotenuse = 0; 
    float theta = 0.0; 
    
    float ratio;
    float xPercentage;
    float yPercentage; 
    
    float xSpeed; 
    float ySpeed; 
    
    
    if (playerY >= shootingAtY & (!shotgunBullet)) {   //the player is shooting upwards or horizontally
    
    
      
      
      if(playerX <= shootingAtX & (players[0].activeTommy.ammo >= 1)) { //the player is shooting to the right and up
         println("the player is shooting to the right and up");
         
         //calculating lengths of sides of the right angle triangle
         b = shootingAtX - playerX; 
         a = playerY - shootingAtY; 
         
         //calculating the size of the hypotenuse
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         //calculating the angle of the bullet
         theta = asin(  (a/hypotenuse) );
         
         println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         players[0].activeTommy.useAmmo(1);
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
         bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
         bulletsInAction++;
         
         if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
    
         
         
      
      } else if (playerX > shootingAtX & (players[0].activeTommy.ammo >= 1)) { //the player is shooting to the left and up
         println("the player is shooting to the left and up");
         
         
         b = playerX - shootingAtX; 
         a = playerY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
         println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         players[0].activeTommy.useAmmo(1);
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         
         bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
         bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
         
         bulletsInAction++;
         
         if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
         
      
      }
      
    } else if (playerY < shootingAtY & (!shotgunBullet) & (players[0].activeTommy.ammo >= 1)) { //the player is shooting down
   
        if(playerX <= shootingAtX) { //the player is shooting to the right and down
           println("the player is shooting to the right and down");
           
           a = shootingAtY - playerY; 
           b = shootingAtX - playerX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           players[0].activeTommy.useAmmo(1);
           
           bullets[bulletsInAction].setSpeedX(xSpeed); 
           bullets[bulletsInAction].setSpeedY(ySpeed);
           bullets[bulletsInAction].setLocX(playerX*20); 
           bullets[bulletsInAction].setLocY(playerY*20);
           
           bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
           bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
         
           bulletsInAction++;
           
           if(players[0].activeTommy.ammo <= 0) {
      
           this.tommyGunSickness = true; 
      
         }
           
      
        } else if (playerX > shootingAtX & (players[0].activeTommy.ammo >= 1)) { //the player is shooting to the left and down
           println("the player is shooting to the left and down");
           
           
           b = playerX - shootingAtX; 
           a = shootingAtY - playerY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           players[0].activeTommy.useAmmo(1);
           
           bullets[bulletsInAction].setSpeedX(xSpeed); 
           bullets[bulletsInAction].setSpeedY(ySpeed);
           bullets[bulletsInAction].setLocX(playerX*20); 
           bullets[bulletsInAction].setLocY(playerY*20);
           
           bullets[bulletsInAction].setDamage(weaponUsed.getMaxDamage());
           bullets[bulletsInAction].setShotFrom(weaponUsed.getName());
         
           bulletsInAction++;
           
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
         println("the player is shooting to the right and up");
         
         players[0].activeShotgun.useAmmo(1);
         
         
         //calculating lengths of sides of the right angle triangle
         b = shootingAtX - playerX; 
         a = playerY - shootingAtY; 
         
         //calculating the size of the hypotenuse
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         //calculating the angle of the bullet
         theta = asin(  (a/hypotenuse) );
         
         System.out.println("Theta: " + theta); 
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         if ( (theta < 0.39) ) {
           
           bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
           
         shotGunSickness = true;
           
         
         } else { 
           
           bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         shotGunSickness = true;
           
           
         }
         
           
             
      } else if (playerX > shootingAtX) { //the player is shooting to the left and up
         println("the player is shooting to the left and up");
         
          players[0].activeShotgun.useAmmo(1);
         
         b = playerX - shootingAtX; 
         a = playerY - shootingAtY; 
         
         hypotenuse = sqrt( (b*b) + (a*a) );
         
         theta = asin(  (a/hypotenuse) );
         
         System.out.println("Theta: " + theta);
         
         
         //These next lines essentially calculate the appropriate X and Y components
         //of the bullet, in order to generate the appropriate X and Y speeds,
         //to feel as though one has the ability to shoot at any angle desired
         
         ratio = theta / 1.570796326;  //pi/2 
         
         println("Ratio: " + ratio); 
         ratio = ratio*100;
         
         yPercentage = ratio; 
         xPercentage = 100 - yPercentage; 
         
         ySpeed = yPercentage/10; 
         xSpeed = xPercentage/10;
         
         //get negative Y speed for this case
         ySpeed = ySpeed - ySpeed*2;
         
         //get negative X speed for this case
         xSpeed = xSpeed - xSpeed*2; 
         
         System.out.println("X speed of bullet: " + xSpeed); 
         System.out.println("Y speed of bullet: " + ySpeed); 
         
         
         if( (theta < 0.38) ) {
           
           bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
           
         shotGunSickness = true;
        
         
         } else {
           
            bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
        
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         shotGunSickness = true;
           
         }
        
      
      }
      
    } else if (playerY < shootingAtY) { //the player is shooting down
   
        if(playerX <= shootingAtX) { //the player is shooting to the right and down
           println("the player is shooting to the right and down");
           
            players[0].activeShotgun.useAmmo(1);
           
           a = shootingAtY - playerY; 
           b = shootingAtX - playerX;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           System.out.println("Theta: " + theta);
           
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           if ( (theta < 0.39) ) {
             
             bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
           
           shotGunSickness = true;
           
          
           } else {
              bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
      
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         shotGunSickness = true;
         
             
           }
         
    
      
        } else if (playerX > shootingAtX) { //the player is shooting to the left and down
           println("the player is shooting to the left and down");
           
           
            players[0].activeShotgun.useAmmo(1);
           
           
           b = playerX - shootingAtX; 
           a = shootingAtY - playerY;
           
           hypotenuse = sqrt( (b*b) + (a*a) );
         
           theta = asin(  (a/hypotenuse) );
         
           System.out.println("Theta: " + theta);        
           
           //These next lines essentially calculate the appropriate X and Y components
           //of the bullet, in order to generate the appropriate X and Y speeds,
           //to feel as though one has the ability to shoot at any angle desired
         
           ratio = theta / 1.570796326;  //pi/2 
         
           println("Ratio: " + ratio); 
           ratio = ratio*100;
         
           yPercentage = ratio; 
           xPercentage = 100 - yPercentage; 
         
           ySpeed = yPercentage/10; 
           xSpeed = xPercentage/10;
         
           //negative X speed for this case
           xSpeed = xSpeed - xSpeed*2; 
         
           System.out.println("X speed of bullet: " + xSpeed); 
           System.out.println("Y speed of bullet: " + ySpeed); 
           
           if( (theta < 0.38) ) {
             
             bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20+20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-10);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20-20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         shotGunSickness = true;
           
           
         
           } else {
             
              bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20+20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
  
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-10); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
         
         
         bullets[bulletsInAction].setSpeedX(xSpeed); 
         bullets[bulletsInAction].setSpeedY(ySpeed);
         bullets[bulletsInAction].setLocX(playerX*20-20); 
         bullets[bulletsInAction].setLocY(playerY*20);
         bullets[bulletsInAction].status = true;
         
         bullets[bulletsInAction].setDamage(players[0].activeShotgun.getMaxDamage());;
         bullets[bulletsInAction].setShotFrom("Shotgun");
         bulletsInAction++;
             
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
    
    for(int i = 0; i < bulletsInAction; i++) {
      
        if(bullets[i].status) {
        fill(#002AF2);
        
      
        bullets[i].timesAnimated = bullets[i].timesAnimated + 1;
        
        if( (bullets[i].timesAnimated == 6) & (bullets[i].getShotFrom() == "Shotgun")) {
          
          bullets[i].status = false;
          this.checkBulletRedundancy();
        }
      
        bullets[i].xCoor += (bullets[i].speedX); 
        bullets[i].yCoor += (bullets[i].speedY);
      
        //line(i*20+10,j*20+10,i*20,j*20);
      
        circle(bullets[i].xCoor,bullets[i].yCoor,bulletSize);
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
    text("Gun",40,850);
    text(""+player.activeTommy.ammo,40,870);
    fill(#B2A89C);
    
    //shotgun box
    fill(player.activeShotgun.colour);
    if(player.active == 2) {
      fill(#00FCE5);
    }
    rect(140,850,80,80);
    fill(0);
    text("Shotgun",120,850);
    text(""+player.activeShotgun.ammo,120,870);
    fill(#B2A89C);
    
    
    //pickaxe box
    if(player.active == 3) {
      fill(#00FCE5);
    } 
    rect(230,850,80,80);
    fill(0);
    text("Pickaxe",210,850);
    fill(#B2A89C);
    
    //hammer box
    if(player.active == 4) {
      fill(#00FCE5);
    } 
    rect(320,850,80,80);
    fill(0);
    text("Hammer",300,850);
    fill(#B2A89C);
    
    //potion box
    if(player.active == 5) {
      fill(#00FCE5);
    } else {
      fill(#B2A89C);
    }
    rect(410,850,80,80);
    fill(0);
    text("Potion",400,850);
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
         
         
         rect(i*20+10,j*20+10,20,20);
         
         
         //if the tile has been hit once
         if(tiles[j][i].health == 75) {
           line(i*20+10,j*20+10,i*20,j*20);
         }
         //if the tile has been damaged halfway
         if(tiles[j][i].health == 50) {
           line(i*20+20,j*20+20,i*20,j*20);
         }
         //if the tile has been damaged 3/4 of the way
         if(tiles[j][i].health == 25) {
           line(i*20+20,j*20+20,i*20,j*20);
           line(i*20+20,j*20,i*20,j*20+20);
         }
      }
    }
    
    showImages();
 }
 
 
  void createMap() {
    Random r = new Random();
    
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
  
 
}
