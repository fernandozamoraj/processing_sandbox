

int x=0;
int y=0;

AlienFonts fonts;
int[][] startMessage;
MachineGun machineGun;
Bullet[]   bullets;
Enemy[] enemies;
int cycleCounter = 0;
int MG_FRAME_RATE = 5;
int[] topWall = null;
int kills = 0;


void setup(){
   size(1000, 700);
   fonts = new AlienFonts();
   startMessage = fonts.getSprite("welcome to mgk!");
   machineGun = new MachineGun(width/2, height-200, 270);
   bullets = new Bullet[100];
   for(int i=0; i < bullets.length; i++){
     bullets[i] = new Bullet(); 
   }
   
   enemies = new Enemy[30];
   for(int i=0; i < enemies.length; i++){
     enemies[i] = new Enemy(); 
   }
   
   frameRate(30);
}


void draw(){
  
  if(topWall == null)
    topWall = new int[width];
    
  x += 5;
  if(x > width) x = -20;
  clear();
  noStroke();
  rect(x,y, 20,40);
  int scale = 4;
  drawSprite(((width-100)/2)/scale, ((height-40)/2)/scale, startMessage, scale);
  
  for(int i=0; i < width; i++){
    if(topWall[i] == 1) 
      ellipse(i, 5, 10,10); 
  }
  
  for(Enemy e : enemies){
    
      if(e.isAlive())
        fill(255,255,100);
      else
        fill(255,0,0);
      e.update();
      ellipse(e.X, e.Y, 40,40);
      fill(255,255,255);
  }
  
  for(Bullet b: bullets){
    if(!b.isAlive()) continue;
    
    for(Enemy e: enemies){
      if(!e.isAlive()) continue;
      
      if(dist(e.X, e.Y, b.X, b.Y) < 50){
          e.kill();
          b.kill();
          kills++;
       }
    }
  }
  
  int[][] message = fonts.getSprite("kills: " + kills);
  drawSprite(40/4, (height-50)/4, message, 4);
  
  updateMachineGun();
  drawMachineGun();
  
  for(Bullet b: bullets){
     if(b.Y < 5 && b.Y > -5 && b.X > 0 && b.X < width){
        topWall[b.X] = 1; 
     }
  }
  
  cycleCounter++;
  
  if(cycleCounter > 10000)
    cycleCounter = 0;
}

void drawSprite(int x, int y, int[][] image, int scale){
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

void drawMachineGun(){
 
  stroke(255);
  line(machineGun.X, machineGun.Y, machineGun.X-100, machineGun.Y+60);
  line(machineGun.X, machineGun.Y, machineGun.X+100, machineGun.Y+60);
  line(machineGun.X, machineGun.Y, machineGun.X, machineGun.Y-90);
  
  for(Bullet b : bullets){

   if(b.isAlive()){
      fill(255,0,0);
      ellipse(b.X, b.Y, 20,20);
      fill(255,255,255);
   }
  }
  translate(machineGun.X, machineGun.Y);
  rotate(radians(machineGun.angle));
  rect(-30,-10,60,20);
  rect(-30,-4,140,8);
}

void keyPressed(){
    if(key == 'j') machineGun.traverseLeft();
    if(key == 'k') machineGun.traverseRight();
}

void updateMachineGun(){
  machineGun.update();
  
  for(Bullet b: bullets){
    b.update(); 
  }
  
  for(Bullet b: bullets){
     if(!b.isAlive() && cycleCounter % MG_FRAME_RATE == 0){
       b.launch(machineGun.X, machineGun.Y, machineGun.angle);
       break;
     }
  }
}



class Bullet{
  public int X;
  public int Y;
  public int DX;
  public int DY;
  
  public boolean isAlive(){
    
    return X > 0 && X < width && Y > 0 && Y < height; 
  }
  
  public Bullet(){
     X = Y = -10;
     DX = 0;
     DY = 0;
  }
  
  public void launch(int x, int y, float angle){
     X = x;
     Y = y;
     DX = (int)(cos(radians(angle))*20);
     DY = (int)(sin(radians(angle))*20);
     
     X += DX * 5;
     Y += DY * 5;
  }
  
  public void update(){
    
    if(!isAlive()) return;
    
    X += DX;
    Y += DY;
  }
  
  public void kill(){
     X = Y = -10; 
  }
}

public class Enemy{
 
   public int X = -100;
   public int Y = -100;
   public int DX;
   public int DY;
   private boolean Dead = false;
   
   public void update(){
     if(Dead) return;
     
     if(X == -100){
       Y = (int)(random(height*8)) * -1;
       X = (int)random(width);
       DX = ((int)random(6))-3;
       DY = ((int)random(10))+5;
     }
     X += DX;
     Y += DY;
     
     if(Y > height){
       X = -100; 
     }
   }
   
   public void kill(){
     Dead = true;
     //X = Y = -10;
   }
   
   public boolean isAlive(){
     return !Dead;
   }
}

class MachineGun{
 
  public float angle;
  public int X;
  public int Y;  
  
  public MachineGun(int x, int y, float angle){
   this.X = x;
   this.Y = y;
   this.angle = angle;
  }
  
  public void update(){
   
   if(abs(pmouseX - mouseX) < 1) return;
   
   int delta = (int)((machineGun.X-mouseX)*.05);
   
   this.angle += delta;
   if(this.angle > 360) this.angle = 360;
   if(this.angle < 0) this.angle += 360;
   if(this.angle < 180) this.angle = 180;
  }
  
  public void traverseLeft(){
   this.angle -= 5;
   if(this.angle > 360) this.angle = 360;
   if(this.angle < 0) this.angle += 360;
   if(this.angle < 180) this.angle = 180;
  }
  
  
  public void traverseRight(){
   this.angle += 5;
   if(this.angle > 360) this.angle = 360;
   if(this.angle < 0) this.angle += 360;
   if(this.angle < 180) this.angle = 180;
  }
}
