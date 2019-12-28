
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
  
  public Enemy() {
    
    super("Alien", 0,0,100,250,100, 1, 0);
    
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
    if((X + 8)*scale > maxX){
       DX *= -1; 
       Y += 5;
    }
    else if(X < 0){
      DX *= -1;
      Y += 5;
    }
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
     Y = 60;
     DX = 5;
  }
  
  public void update(int lowerX, int maxX){
    if(key == 'j'){
       if(X*scale - DX*scale > 0)
         X -= DX; 
    }
    else if(key == 'k'){
       if(X*scale + DX*scale < maxX)
         X += DX; 
    }
  }
}


PGraphics pg;
EnemySquadron enemySquadron;
PlayerShip player;
int frameThrottle = 0;
int scale = 10;

void setup(){
 size(800,800); 
 pg = createGraphics(width, height);

 enemySquadron = new EnemySquadron(); 
 player = new PlayerShip();
 frameThrottle = 0;
 
}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    if(frameThrottle % 10 == 0){
      enemySquadron.update(0,width,0,height);
      player.update(0, width);
    }
    
    drawEnemySquadron();
    drawPlayer();

    pg.endDraw();
      
  }
  
  frameThrottle++;
}

void drawEnemySquadron(){
  
  Sprite[] enemies = enemySquadron.getSprites();

  for(Sprite s: enemies){
   fill(s.R, s.G, s.B);
   stroke(s.R, s.G, s.B);
   for(int i=0;i<s.Image.length; i++){
    for(int j=0; j<s.Image[i].length; j++){
      if(s.Image[i][j] == 0){
        stroke(200,200,200);
        fill(200,200,200);
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
        stroke(200,200,200);
        fill(200,200,200);
      }
      else{
        stroke(s.R,s.G,s.B);
        fill(s.R, s.G, s.B); 
      }
      int newX = s.X*scale+j*scale+3*scale;
      int newY = s.Y*scale+i*scale+3*scale;
      rect(newX, newY, scale,scale);
      System.out.print("\ndrawing ship " + newX + " " + newY);
    }
  }
}
