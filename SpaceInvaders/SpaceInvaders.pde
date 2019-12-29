



PGraphics pg;
EnemySquadron enemySquadron;
PlayerShip player;
PlayerBullet[] playerBullets;

int frameThrottle = 0;
int scale = 5;
char currentKey = ' ';
int shipDirection = 0;
boolean launchBullet = false;


void setup(){
 size(800,600); 
 pg = createGraphics(width, height);

 enemySquadron = new EnemySquadron(); 
 player = new PlayerShip();
 playerBullets = new PlayerBullet[50];
 for(int i=0;i<playerBullets.length; i++)
   playerBullets[i] = new PlayerBullet();
 frameThrottle = 0;
 
}

void draw(){
  background(204);
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
      updateBullets();
      detectAlienHits();
    }
    
    drawEnemySquadron();
    drawPlayer();
    drawBullets();

    pg.endDraw();
      
  }
  
  frameThrottle++;
}

void checkUserInput(){

  if(frameThrottle % 60 == 0){
    
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

void detectAlienHits(){
    Enemy[] enemies = enemySquadron.getSprites();

  for(Enemy s: enemies){
    for(PlayerBullet pb : playerBullets){
      if(!pb.isAlive() || !s.isAlive())
        continue;
        
       System.out.println("Made it here");
        
      if(pb.hitAlien(s.X, s.Y, s.Image[0].length, s.Image.length)){
         pb.killBullet();
         s.takeHit();
      }
    }
  }
}

void drawBullets(){
  for(Sprite s: playerBullets){
   fill(s.R, s.G, s.B);
   stroke(s.R, s.G, s.B);
   for(int i=0;i<s.Image.length; i++){
    for(int j=0; j<s.Image[i].length; j++){
      if(s.Image[i][j] == 0){
        stroke(0,0,0);
        fill(0,0,0);
      }
      else{
        stroke(s.R,s.G,s.B);
        fill(s.R, s.G, s.B); 
      }
      int newX = s.X*scale+j*scale+3*scale;
      int newY = s.Y*scale+i*scale+3*scale;
      rect(newX, newY, scale,scale);
    }
   }
  }
}

void drawEnemySquadron(){
  
  Enemy[] enemies = enemySquadron.getSprites();

  for(Enemy s: enemies){
    if(!s.isAlive())
      continue;
   fill(s.R, s.G, s.B);
   stroke(s.R, s.G, s.B);
   for(int i=0;i<s.Image.length; i++){
    for(int j=0; j<s.Image[i].length; j++){
      if(s.Image[i][j] == 0){
        stroke(0,0,0);
        fill(0,0,0);
      }
      else{
        stroke(s.R,s.G,s.B);
        fill(s.R, s.G, s.B); 
      }
      int newX = s.X*scale+j*scale+3*scale;
      int newY = s.Y*scale+i*scale+3*scale;
      rect(newX, newY, scale,scale);
    }
   }
  }
}

void drawPlayer(){
    
  PlayerShip s = player;
  
  fill(s.R, s.G, s.B);
  stroke(s.R, s.G, s.B);
   for(int i=0;i<s.Image.length; i++){
    for(int j=0; j<s.Image[i].length; j++){
      if(s.Image[i][j] == 0){
        stroke(0,0,0);
        fill(0,0,0);
      }
      else{
        stroke(s.R,s.G,s.B);
        fill(s.R, s.G, s.B); 
      }
      int newX = s.X*scale+j*scale+3*scale;
      int newY = s.Y*scale+i*scale+3*scale;
      rect(newX, newY, scale,scale);
      //System.out.print("\ndrawing ship " + newX + " " + newY);
    }
  }
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
  public int[][] Image;
  public Sprite(String name, int x, int y, int r, int g, int b, int dx, int dy){
    
   X = x;
   Y = y;
   R = r;
   G = g;
   B = b;
   DX = dx;
   DY = dy;
  }
  
  public void setImage(int[][] image){
    Image = image;
  }
}

class Enemy extends Sprite{
  
  int health;
  public Enemy() {
    
    super("Alien", 0,0,100,250,100, 1, 0);
    
    health = 3;  
     int[][] image = new int[][]{
       {0,1,1,1,1,1,1,0},
       {1,1,1,1,1,1,1,1},
       {1,0,0,1,1,0,0,1},
       {1,1,1,1,1,1,1,1},
       {1,1,0,0,0,0,1,1},
       {1,0,1,1,1,1,0,1},
       {1,1,1,1,1,1,1,1},
       {1,0,0,1,1,0,0,1},
      };
     setImage(image); 
  }
  
  public void update(int lowerX, int maxX){
    X += DX;
    if(X*scale+20*scale > maxX){
       DX *= -1; 
       Y += 5;
    }
    else if(X < 0){
      DX *= -1;
      Y += 5;
    }
  }
  
  public void takeHit(){
    if(health < 1)
      return;
      
    health--;
    
    if(health == 2){
       int[][] image = new int[][]{
         {0,0,0,0,1,1,1,0},
         {0,0,0,0,1,1,1,1},
         {0,0,0,1,1,0,0,1},
         {1,0,1,1,1,1,1,1},
         {1,1,0,0,0,0,1,1},
         {1,0,1,1,1,1,0,1},
         {1,1,1,1,1,1,1,1},
         {1,0,0,1,1,0,0,1},
        };
       setImage(image);
    }
    if(health == 1){
       int[][] image = new int[][]{
         {0,0,0,0,1,1,1,0},
         {0,0,0,0,1,1,1,1},
         {0,0,0,1,1,0,0,1},
         {1,0,1,1,1,0,0,1},
         {0,1,0,0,0,0,0,1},
         {0,0,1,0,0,1,0,1},
         {0,1,1,0,1,1,1,1},
         {0,0,0,1,1,0,0,1},
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
         sprites[k].X = j*8+3*j;
         sprites[k].Y = i*8+3*i;
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
    
     int[][] image = new int[][]{
       {0,0,0,1,0,0,0},
       {0,0,0,1,0,0,0},
       {0,0,1,1,1,0,0},
       {0,1,1,1,1,1,0},
       {1,1,1,1,1,1,1},
       {0,0,1,1,1,0,0},
       {0,0,0,1,0,0,0},
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

class PlayerBullet extends Sprite{
  
    public PlayerBullet() {
    
      super("Bullet", 0,0,250,250,250, 0, 0);
    
     int[][] image = new int[][]{
       {1},
       {1},
      };
     setImage(image); 
     X = -1;
     Y = -1;
     DX = -3;
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
