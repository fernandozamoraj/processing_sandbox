import processing.sound.*;

int x=0;
int y=0;

SoundFile fire;
SoundFile bulletExplosion;
AlienFonts fonts;
int[][] startMessage;
MachineGun machineGun;
Bullet[]   bullets;
Enemy[] enemies;
int cycleCounter = 0;
int MG_FRAME_RATE = 5;
int[] topWall = null;
int kills = 0;
Particles particles;
int machineGunSize = 60;
int diskSize = 5;
int bulletSize = 2;
int enemySize = 10;


void setup(){
   size(1000, 700);
   fonts = new AlienFonts();
   fire = new SoundFile(this, "mgfire02.wav");
   bulletExplosion = new SoundFile(this, "bulletExplosion.wav");
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
  //awSprite(((width-100)/2)/scale, ((height-40)/2)/scale, startMessage, scale);
  
  for(int i=0; i < width; i++){
    if(topWall[i] == 1) 
      ellipse(i, 5, 10,10); 
  }
  
  for(Enemy e : enemies){
    e.show();      
  }
  
  for(Bullet b : bullets){
    b.show();   
  }
  if(cycleCounter%11 ==0)
    fire.play();
  if(cycleCounter%90 ==0)
    fire = new SoundFile(this, "mgfire02.wav");
  
  for(Bullet b: bullets){
    if(!b.isAlive()) continue;
    
    for(Enemy e: enemies){
      if(!e.isAlive()) continue;
      
      if(dist(e.X, e.Y, b.X, b.Y) < 50){
          e.kill();
          b.kill();
          kills++;
          particles = new Particles(e.X, e.Y, 20);
          bulletExplosion.play();
       }
    }
    
    if(particles != null){
      particles.update();
      particles.show();
    }
  }
  
  int[][] message = fonts.getSprite("kills: " + kills);
  drawFontSprite(40/4, (height-50)/4, message, 4);
  
  updateMachineGun();
  machineGun.show();
  
  for(Bullet b: bullets){
     if(b.Y < 10 && b.Y > -10 && b.X > 0 && b.X < width){
        topWall[b.X] = 1; 
     }
  }
  
  cycleCounter++;
  
  if(cycleCounter > 10000)
    cycleCounter = 0;
}

void drawFontSprite(int x, int y, int[][] image, int scale){
  for(int i=0;i<image.length; i++){
    for(int j=0; j<image[i].length; j++){
      if(image[i][j] == 1){
        int newX = x*scale+j*scale+3*scale;
        int newY = y*scale+i*scale+3*scale;
        rect(newX, newY, scale,scale*1.5);
      }
    }
  }
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



void keyPressed(){
    if(key == 'j') machineGun.traverseLeft();
    if(key == 'k') machineGun.traverseRight();
}

void updateMachineGun(){
  machineGun.update_v2();
  
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

void print2(String s){
   System.out.println(s); 
}


class Bullet{
  public int X;
  public int Y;
  public int DX;
  public int DY;
  public float angle;
  
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
     this.angle = angle;
  }
  
  public void update(){
    
    if(!isAlive()) return;
    
    X += DX;
    Y += DY;
  }
  
  public void show(){
   if(isAlive()){
       noStroke();
      fill(255,255,0);
      ellipse(X+DX, Y+DY, bulletSize,bulletSize);
      fill(255,255,255);
      ellipse(X-DX, Y-DY, bulletSize,bulletSize);
      ellipse(X, Y, bulletSize,bulletSize);
      fill(255,0,0,170);
      //ellipse(X, Y, bulletSize+5,bulletSize+5);
      //ellipse(X, Y, bulletSize+5,bulletSize+5);
      fill(255,255,255);
   } 
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
   
   public void show(){
    if(isAlive())
     {
        fill(50,50,0);
        update();
        ellipse(X, Y, enemySize+30,enemySize+30);
        
        fill(250,250,140);
        ellipse(X, Y, enemySize+20,enemySize+20);
        
        fill(250,250,180);
        ellipse(X, Y, enemySize+10,enemySize+10);
        
        fill(250,250,240);
        ellipse(X, Y, enemySize,enemySize);
        
        fill(255,255,255);
     } 
   }
}

class MachineGun{
 
  public float angle;
  public int X;
  public int Y;  
  public int timer;
  public boolean recoilToggle = false;
  
  public MachineGun(int x, int y, float angle){
   this.X = x;
   this.Y = y;
   this.angle = angle;
   this.timer = 0;
  }
  
  public void update_v2(){
    
    int distance = (int)((machineGun.X - mouseX)*.5);
    
    this.angle = 270+distance;
    
    if(this.angle > 360) this.angle -= 360;
    if(this.angle < 360) this.angle += 360;
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
  
  void show(){
 
    this.timer++;
    stroke(255);
    line(X, Y, X-50, Y+30);
    line(X, Y, X+50, Y+30);
    line(X, Y, X, Y-45);

    if(timer%2==0){
      recoilToggle = !recoilToggle;
    }
    
    int recoildDist = recoilToggle ? 6 : 0;
    
    if(timer > 5000)
      timer = 0;
    
    translate(X, Y);
    rotate(radians(angle));
    rect(-((machineGunSize/4)+recoildDist),-(machineGunSize/12),machineGunSize/2,machineGunSize/6);
    rect(-((machineGunSize/4)+recoildDist),-(machineGunSize/10),machineGunSize/3*2,machineGunSize/5);
    rect(-((machineGunSize/4)+recoildDist),-(machineGunSize/32),machineGunSize*1.5,machineGunSize/16);
    rect( ((machineGunSize*1.2)-recoildDist),-(machineGunSize/18),machineGunSize/5,machineGunSize/9);
    
    ellipse(-(((machineGunSize/4)+5)+recoildDist), -((machineGunSize/16)+5), machineGunSize/16, machineGunSize/16);
    ellipse(-(((machineGunSize/4)+5)+recoildDist), -((machineGunSize/16)-12), machineGunSize/16, machineGunSize/16);
  }
}

class Particles{
 
  ArrayList<Particle> particles;
  int X;
  int Y;
  int lifeTime;
  int size = 20;
  
  public Particles(int x, int y, int lifeTime){
    
    particles = new ArrayList<Particle>(); 
    this.X = x;
    this.Y = y;
    this.lifeTime = lifeTime;
    this.size = 20;
  }
  
  public void update(){
    particles.add(new Particle(this.X, this.Y)); 
    
    for(int i = particles.size()-1; i >= 0; i--){
     
      if(particles.get(i).isAlive()){
        particles.get(i).update(); 
      }
      else{
         particles.remove(i); 
      }      
    }
    
    
    
    this.lifeTime--;
    
    if(this.lifeTime < 0){
      particles.clear(); 
    }
  }
  
  public void show(){
    for(int i = particles.size()-1; i >= 0; i--){
     
      particles.get(i).show();      
    }
    
    if(lifeTime > 0){
      size *= 1.1;
      fill(255,255,255,100);
      ellipse(X,Y,size,size);      
   }
  }
}

class Particle{
 
  public float X;
  public float Y;
  public float VX;
  public float VY;
  public float alpha;
  public int size;
  float gravity = 1.1;
  
  public Particle(float x, float y){
     this.X = x;
     this.Y = y;
     this.VX = (random(60)-30)*.1;
     this.VY = (random(60)-30)*.1;
     this.size = (int)random(2)*10;
     this.alpha = 150;
  }
  
  public void show(){
    noStroke();
    fill(255, 255, 0,  this.alpha);
    ellipse(this.X, this.Y, this.size, this.size);
  }
  
  public boolean isAlive(){
    return this.alpha >= 0; 
  }
  
  public void update(){
    this.VY -= .03;
    //this.size++;
    this.alpha -= 1;
    this.X += this.VX;
    this.Y += this.VY;
  }
}
