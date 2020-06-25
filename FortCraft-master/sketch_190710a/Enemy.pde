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
    
     //System.out.println("Enemies current health: " + this.health);
    
    //take the damage off the the enemies health
    this.health = this.health - damage; 
    
    //System.out.println("Enemies current health after damage: " + this.health);
    
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
  void move(int targetX, int targetY) { }
  
  void show() {}
  
  
 
  void die() {
    System.out.println("Dying"); 
    status = false; 
    
    if(this.enemyType == "Phalax") {
      //trigger a biome switch due to grassland mini boss defeat
      System.out.println("A Phalax mini boss has been defeated");
    }
    
    
    
  }
  
  
}
