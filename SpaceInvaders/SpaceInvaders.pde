



PGraphics pg;
EnemySquadron enemySquadron;
PlayerShip player;
PlayerBullet[] playerBullets;

int frameThrottle = 0;
int scale = 5;
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
      enemySquadron.update(0,width,0,height);
      player.update(0, width);
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



class Sprite{

  public String Name;
  public int X;
  public int Y;
  public int R;
  public int G;
  public int B;
  public int DX;
  public int DY;
  public int[][][] Image;
  public Sprite(String name, int x, int y, int r, int g, int b, int dx, int dy){
    
   X = x;
   Y = y;
   R = r;
   G = g;
   B = b;
   DX = dx;
   DY = dy;
  }
  
  public void setImage(int[][][] image){
    Image = image;
  }
}

class Enemy extends Sprite{
  
  int health;
  public Enemy() {
    
    super("Alien", 0,0,100,250,100, 1, 0);
    
    health = 3;  
     int[][][] image = new int[][][]{
       {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,1,0,1,1,1,0,1,1,0},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,0,1,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,1,1,0,0}
      },
      {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,1,1,0,1,1,1,0,1,1,1},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,0,1,0,0,0,0,0,1,0,0},
       {0,1,1,0,0,0,0,0,1,1,0}
      }
      
    };
     setImage(image); 
  }
  
  public void update(int lowerX, int maxX){
    X += DX;
    if(X*scale+20*scale > maxX){
       DX *= -1; 
       Y += Image[0][0].length;
    }
    else if(X < 0){
      DX *= -1;
      Y += Image[0][0].length;
    }
  }
  
  public void takeHit(){
    if(health < 1)
      return;
      
    health--;
    
    if(health == 2){
       int[][][] image = new int[][][]{
         {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,0,0,1,1,1,0,1,1,0},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,1,1,0,0}
         },
      {
       {1,1,0,0,0,0,0,0,1,0,0},
       {0,1,0,0,0,0,0,0,1,0,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,0,0,1,1,1,0,1,1,0},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,1,1,1,1,1,1,0,0},
       {0,0,0,0,0,0,0,0,1,0,0},
       {0,0,0,1,1,0,0,0,1,1,0}
         },
        };
       setImage(image);
    }
    if(health == 1){
       int[][][] image = new int[][][]{
         {
       {1,0,0,0,0,0,0,0,0,0,0},
       {0,1,0,0,0,0,0,0,0,0,0},
       {0,0,1,1,1,0,0,1,1,0,0},
       {0,1,0,0,1,0,1,0,1,1,0},
       {0,0,0,1,1,0,0,0,0,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,0,0,0,0}
         },
                  {
       {1,0,0,0,0,0,0,0,0,0,0},
       {0,1,0,0,0,0,0,0,0,0,0},
       {0,0,1,1,1,0,0,1,1,0,0},
       {0,1,0,0,1,0,1,0,1,1,0},
       {0,0,0,1,1,0,0,0,0,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,0,0,0,0}
         }
         
        };
       setImage(image);
    }
  }
  
  public boolean isAlive(){
   return health > 0; 
  }
}

class EnemySquadron{
 
  Enemy[] sprites;
  
  public EnemySquadron(){
     
    sprites = new Enemy[18];
    int xOffsetSpace = 3;
    int k = 0;
    for(int i=0; i< 3; i++){
       for(int j=0; j<6;j++){
         sprites[k] = new Enemy();
         int w = sprites[k].Image[0].length;
         sprites[k].X = j*w+10*j;
         sprites[k].Y = i*w+10*i;
         k++;
       }
    }
  }
  public Enemy[] getSprites(){
    return sprites;    
  }
  
  public void update(int lowerX, int maxX, int lowerY, int maxY){
   
    for(Enemy sp: sprites){
      sp.update(lowerX, maxX);
    }
  }
}

class PlayerShip extends Sprite{
  
    public PlayerShip() {
    
      super("Player", 0,0,250,250,250, 0, 0);
    
     int[][][] image = new int[][][]{
       {
       {0,0,0,1,0,0,0},
       {0,0,0,1,0,0,0},
       {0,0,1,1,1,0,0},
       {0,1,1,1,1,1,0},
       {1,1,1,1,1,1,1},
       {0,0,1,1,1,0,0},
       {0,0,0,1,0,0,0}
       }
      };
     setImage(image); 
     X = 50;
     Y = 100;
     DX = 5;
  }
  
  public void update(int lowerX, int maxX){
    if(shipDirection == 1){
       if(X*scale > 0)
         X -= DX; 
    }
    else if(shipDirection == 2){
       if(X*scale + DX*scale + 7*scale < maxX)
         X += DX; 
    }
  }
}

class ScoreBoard{
 public int X;
 public int Y;
 public int Score;
 public int Lives;
 
 public ScoreBoard(){
   Score = 0;
   Lives = 3;
 }
 
 public String[] getLines(){
     String[] lines = new String[2];
     
     lines[0] = "SCORE: " + Score;
     lines[1] = "LIVES: " + Lives;
    
     return lines;
 }
}

class PlayerBullet extends Sprite{
  
    public PlayerBullet() {
    
      super("Bullet", 0,0,250,250,250, 0, 0);
    
     int[][][] image = new int[][][]{
       {
        {1},
        {1},
       }
      };
     setImage(image); 
     X = -1;
     Y = -1;
     DX = -4;
  }
  
  public void update(){
    if(isAlive()){
      Y += DX; 
    }
    else{
      Y = -10; 
    }
  }
  
  public void killBullet(){
    Y = -10; 
  }
  
  public boolean isAlive(){
    return Y > -1;
  }
  
  public void launch(int x, int y){
     X = x;
     Y = y;
  }
  
  public boolean hitAlien(int x, int y, int w, int l){
    
    if(X >= x && X <= x + w){
      if(Y >= y && Y <= y+l){
        return true; 
      }
    }
    
    return false;
  }
}
