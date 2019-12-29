



PGraphics pg;
EnemySquadron enemySquadron;
PlayerShip player;
PlayerBullet[] playerBullets;

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
 for(int i=0;i<playerBullets.length; i++)
   playerBullets[i] = new PlayerBullet();
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
    
      gameOverTimer = 200;
      gameOver();
      break;
    
  }
}

void keyPressed(){
  
  if(gameMode == 0){
    if(key == 's'){
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
    
    if(frameThrottle % 10 == 0){
      
      if(frameThrottle % squadronSpeed == 0){
        enemySquadron.update(scale,width,0,height);
      }
      
      player.update(shipDirection, scale, width);
      checkUserInput();
    }
    
    if(frameThrottle % 5 == 0){
      updateBullets(); 
    }
    
    detectAlienHits();
    
    drawEnemySquadron();
    drawPlayer();
    drawBullets();
    drawScoreBoard();
    pg.endDraw();
      
  }
  
  frameThrottle++;
}

void screenSaver(){
  
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
    
    drawEnemySquadron();
    drawPlayer();
    drawBullets();
    drawScoreBoard();
    drawStartScreenText(20, height/2-100);
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
  if(gameOverTimer < 0){
    gameMode = 0; 
  }
}

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



void updateBullets(){

  for(PlayerBullet pb : playerBullets){
     pb.update(); 
  }
}

void drawScoreBoard(){
  textFont(font);
  //textSize(20);
  fill(100,100,200);
  int offset = 0;
  for(String line : scoreBoard.getLines()){
    text(line, scoreBoard.X + offset, scoreBoard.Y);
    offset += 400;
  }
}

void drawStartScreenText(int x, int y){
  textFont(font);
  

  fill(100,100,200);

  text("Press s to start", x, y);
  text("use j and k to move left and right", x, y+30);
  text("use f to fire", x, y+60);

}

void drawGameOverText(int x, int y){
   textFont(font);

  fill(100,100,200);
  text("Game Over!", x, y);
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

void drawBullets(){
  Sprite first = playerBullets[0];
  fill(first.R, first.G, first.B);
  stroke(first.R, first.G, first.B);
  for(Sprite s: playerBullets){
    drawSprite(s.X, s.Y, s.Image[0]);
  }
}

int currentEnemy = 1;
void drawEnemySquadron(){
  
  if(frameThrottle % 40 == 0){
    if(currentEnemy == 1)
      currentEnemy = 0;
    else
      currentEnemy = 1;
  }
    
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

void drawPlayer(){
  fill(player.R, player.G, player.B);
  stroke(player.R, player.G, player.B);
  drawSprite(player.X, player.Y, player.Image[0]);
}
