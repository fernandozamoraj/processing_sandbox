



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
      enemySquadron.update(scale,width,0,height);
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

void checkUserInput(){

  if(frameThrottle % 30 == 0){
    
    if(launchBullet){
      for(PlayerBullet bullet : playerBullets){
        
        if(!bullet.isAlive()){
          bullet.launch(player.X, player.Y);
          break;
        }
      }
      launchBullet = false;
    }
  }
}

void keyPressed(){
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

void keyReleased(){
  currentKey = ' '; 
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

void detectAlienHits(){
    Enemy[] enemies = enemySquadron.getSprites();

  for(Enemy s: enemies){
    for(PlayerBullet pb : playerBullets){
      if(!pb.isAlive() || !s.isAlive())
        continue;
        
       //System.out.println("Made it here");
        
      if(pb.hitAlien(s.X, s.Y, s.Image[0].length, s.Image.length)){
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
    
  Enemy[] enemies = enemySquadron.getSprites();

  Enemy first = enemies[0];
  fill(first.R, first.G, first.B);
  stroke(first.R, first.G, first.B);
  for(Enemy s: enemies){
    if(!s.isAlive())
      continue;
      drawSprite(s.X, s.Y, s.Image[currentEnemy]);
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
