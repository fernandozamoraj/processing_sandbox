PGraphics pg;
EnemySquadron enemySquadron;
PlayerShip player;
PlayerBullet[] playerBullets;
EnemyBullet[] enemyBullets;
Missile[] missiles;
int[][] startGameMessage;
AlienFonts alienFonts;

int frameThrottle = 0;
int scale = 3;
char currentKey = ' ';
int shipDirection = 0;
boolean launchBullet = false;
ScoreBoard scoreBoard;
PFont font;

int gameMode = 0;
int gameOverTimer = 0;
int squadronSpeed = 40;

void setup(){
 size(800,600); 
 pg = createGraphics(width, height);

 enemySquadron = new EnemySquadron(); 
 player = new PlayerShip();
 playerBullets = new PlayerBullet[50];
 enemyBullets = new EnemyBullet[10];
 missiles = new Missile[5];
 
 for(int i=0;i<playerBullets.length; i++)
   playerBullets[i] = new PlayerBullet();
   
 for(int i=0;i<enemyBullets.length; i++)
   enemyBullets[i] = new EnemyBullet();
   
 alienFonts = new AlienFonts();
 startGameMessage = alienFonts.getSprite("0123456789");
   
 frameThrottle = 0;
 scoreBoard = new ScoreBoard();
 scoreBoard.X = -1;
 scoreBoard.Y = -2;
 font = createFont("courier new", 32);
 
}

void draw(){

  switch(gameMode){
    
    case 0: screenSaver(); break;
    case 1: playGame(); break;
    case 2: 
      gameOver();
      break;
    
  }
}

void keyPressed(){
  
  if(gameMode == 0){
    if(key == 's'){
      scoreBoard.Lives = 3;
      scoreBoard.Score =0;
      player.reset();
      gameMode = 1; 
      player.X = 120;
      player.Y = 170;
    }
  }
  else if(gameMode == 1){
    currentKey = key; 
    if(key == 'j'){
      shipDirection = 1; 
    }
    if(key == 'k'){
      shipDirection = 2; 
    }
    if(key == 'f'){
      launchBullet = true; 
    }
  }
  else if(gameMode ==2){
    
  }
}

void keyReleased(){
  currentKey = ' '; 
}

/***********************************************

   Screens

************************************************/
void playGame(){
  
    background(204);
  
  if(scoreBoard.X == -1){
    scoreBoard.X = 40;
    scoreBoard.Y = height - 20;
  }
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    fill(0,0,0);
    stroke(0,0,0);
    rect(0,0,width,height);

    if(frameThrottle % squadronSpeed == 0){
      enemySquadron.update(scale,width,0,height);
      
      if(enemySquadron.DownSteps >= 2){
        squadronSpeed = 20;
      }
      else if(enemySquadron.DownSteps >= 4){
        squadronSpeed = 10;
      }
      else if(enemySquadron.DownSteps >= 6){
        squadronSpeed = 5;
      }
      else if(enemySquadron.DownSteps >= 7){
        squadronSpeed = 2;
      }
    }
    
    if(frameThrottle % 10 == 0){
      player.update(shipDirection, scale, width);
      checkUserInput();
    }
    
    if(frameThrottle %  40 == 0 || frameThrottle %  60 == 0){
      shootEnemyBullet();        
    }
  
    
    if(frameThrottle % 5 == 0){
      updateBullets(); 
    }
    
    detectAlienHits();
    detectPlayerHits();
    
    if(scoreBoard.Lives == 0){
      gameOverTimer = 80;
      gameMode = 2; 
    }
    
    drawEnemySquadron();
    drawPlayer();
    drawBullets();
    drawEnemyBullets();
    drawScoreBoard();
    pg.endDraw();
      
  }
  
  frameThrottle++;
}


void screenSaver(){
  
  background(204); //<>//
  
  if(scoreBoard.X == -1){
    scoreBoard.X = 40;
    scoreBoard.Y = height - 20;
  }
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    fill(0,0,0);
    stroke(0,0,0);
    rect(0,0,width,height);
    
    drawEnemySquadron();
    drawPlayer();
    drawBullets();
    drawScoreBoard();

    fill(255,255,255);
    drawSprite((width/2)/scale, ((height/2)/scale), startGameMessage, 2);
    pg.endDraw();
      
  }
  
  frameThrottle++;
}


void gameOver(){
  
  
  background(204);
  
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    fill(0,0,0);
    stroke(0,0,0);
    rect(0,0,width,height);
    
    drawGameOverText((width-200)/2, height/2);
    pg.endDraw();
    
  }
  
  frameThrottle++;
  
  gameOverTimer--;
  
  text(""+gameOverTimer, 200,200);
  if(gameOverTimer < 0){
    gameMode = 0; 
    
  }
}
//*************End of screens

/***********************************************************

    Actions... shoot bullets launch bullets etc


***********************************************************/

void checkUserInput(){

  if(frameThrottle % 30 == 0){
    
    if(launchBullet){
      for(PlayerBullet bullet : playerBullets){
        
        if(!bullet.isAlive()){
          bullet.launch(player.X+player.Image[0][0].length/2, player.Y+player.Image[0].length/2);
          break;
        }
      }
      launchBullet = false;
    }
  }
}

void detectAlienHits(){
    EnemyShip[] enemies = enemySquadron.getSprites();

  for(EnemyShip s: enemies){
    for(PlayerBullet pb : playerBullets){
      if(!pb.isAlive() || !s.isAlive())
        continue;
        
       //System.out.println("Made it here");
        
      if(pb.hitAlien(s.X, s.top(), s.Image[0][0].length, s.Image[0].length)){
         pb.killBullet();
         s.takeHit();
         scoreBoard.Score += 100;
      }
    }
  }
}

void detectPlayerHits(){

  for(EnemyBullet eb : enemyBullets){
    if(!eb.isAlive(width) || !player.isAlive())
      continue;

      
    if(eb.hitAlien(player.X, player.Y, player.Image[0][0].length, player.Image[0].length)){
       eb.killBullet();
       player.takeHit();
       scoreBoard.Lives--;
    }
  }
}

void shootEnemyBullet(){
 
  int randomEnemy = (int)random(enemySquadron.liveEnemiesCount());
  EnemyShip[] enemies = enemySquadron.getSprites();
  int count = -1;
  boolean shotFired = false;
  for(int i=0; i < enemies.length; i++){
   
    if(enemies[i].isAlive()){
        count++;
        if(randomEnemy == count){
           for(EnemyBullet bullet : enemyBullets){
               if(!bullet.isAlive(800)){
                 bullet.launch(enemies[i].X, enemies[i].Y); 
                 shotFired = false;
                 break;
               }
           }
        }
    }
    
    if(shotFired)
      break;
  }
}


void updateBullets(){

  for(PlayerBullet pb : playerBullets){
     pb.update(); 
  }
  
  for(EnemyBullet eb : enemyBullets){
     eb.update(); 
  }
}

//**************** End of actions

/***********************************************************

    Drawing Functions


***********************************************************/

void drawBullets(){
  Sprite first = playerBullets[0];
  fill(first.R, first.G, first.B);
  stroke(first.R, first.G, first.B);
  for(Sprite s: playerBullets){
    drawSprite(s.X, s.Y, s.Image[0]);
  }
}

void drawEnemyBullets(){
  Sprite first = enemyBullets[0];
  fill(first.R, first.G, first.B);
  stroke(first.R, first.G, first.B);
  for(Sprite s: enemyBullets){
    drawSprite(s.X, s.Y, s.Image[0]);
  }
}

void drawEnemySquadron(){
    
  EnemyShip[] enemies = enemySquadron.getSprites();

  EnemyShip first = enemies[0];
  fill(first.R, first.G, first.B);
  stroke(first.R, first.G, first.B);
  for(EnemyShip s: enemies){
    if(!s.isAlive())
      continue;
      drawSprite(s.X, s.Y, s.Image[s.currentImage]);
  }
}

void drawGameOverText(int x, int y){
   textFont(font);

  fill(100,100,200);
  text("Game Over!", x, y);
}

void drawPlayer(){
  if(player.isAlive()){
    fill(player.R, player.G, player.B);
    stroke(player.R, player.G, player.B);
    drawSprite(player.X, player.Y, player.Image[0]);
  }
}

void drawSprite(int x, int y, int[][] image){
  for(int i=0;i<image.length; i++){
    for(int j=0; j<image[i].length; j++){
      if(image[i][j] == 1){
        int newX = x*scale+j*scale+3*scale;
        int newY = y*scale+i*scale+3*scale;
        rect(newX, newY, scale,scale);
      }
    }
  }
}

void drawScoreBoard(){

  noStroke();
  fill(100,100,200);
  int offset = 0;
  int x = 20;
  int y = (height-50)/4;
  for(String line : scoreBoard.getLines()){
    int[][] message = alienFonts.getSprite(line);
    drawSprite(x, y, message, 4);
    x += 80;
  }
}

void drawSprite(int x, int y, int[][] image, int scale){
  for(int i=0;i<image.length; i++){
    for(int j=0; j<image[i].length; j++){
      if(image[i][j] == 1){
        int newX = x*scale+j*scale;
        int newY = y*scale+i*scale;
        rect(newX, newY, scale,scale);
      }
    }
  }
}

void drawStartScreenText(int x, int y){
  textFont(font);
  fill(100,100,200);

  text("Press s to start", x, y);
  text("use j and k to move left and right", x, y+30);
  text("use f to fire", x, y+60);
}
