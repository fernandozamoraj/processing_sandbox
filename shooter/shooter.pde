
PGraphics pg;
int[][] crossHairs = {
{0,0,0,1,1,1,1,1,0,0,0},
{0,1,0,0,0,1,0,0,0,1,0},
{0,0,0,0,0,1,0,0,0,0,0},
{1,0,0,0,0,1,0,0,0,0,1},
{1,0,0,0,0,1,0,0,0,0,1},
{1,0,1,1,1,1,1,1,1,0,1},
{1,0,0,0,0,1,0,0,0,0,1},
{1,0,0,0,0,1,0,0,0,0,1},
{0,0,0,0,0,1,0,0,0,0,0},
{0,1,0,0,0,1,0,0,0,1,0},
{0,0,0,1,1,1,1,1,0,0,0}
};

int[][] target = {
{0,0,1,1,0,0},
{0,1,1,1,1,0},
{1,1,1,1,1,1},
{1,1,1,1,1,1},
{1,1,1,1,1,1},
{1,1,1,1,1,1},
{1,1,1,1,1,1},
{1,1,1,1,1,1},
};


int[][] crackedTarget = {
{0,0,1,0,0,0},
{0,1,0,1,1,0},
{1,1,0,1,1,1},
{1,0,1,0,1,1},
{1,1,1,1,0,1},
{1,0,1,1,0,0},
{0,1,1,1,1,1},
{1,1,1,1,1,1},
};

int targetX;
int targetY;

int targetTimer;
int blowUpTimer;

int TARGET_INVISIBLE = 50;
int TARGET_VISIBLE = 100;
int BLOWUP_ON = 25;
int score = 0;
int hitX;
int hitY;

void setup(){
 size(800,800); 
 pg = createGraphics(width, height);


}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    noCursor();
    updateTarget();
    
    stroke(0,0,0);
    fill(0,0,0);
    if(targetTimer > TARGET_INVISIBLE)
      drawSprite(target, targetX, targetY, 8);
      
    stroke(255,255,255);
    fill(200,200,200);
    
    drawSprite(crossHairs, mouseX, mouseY, 2);

    if(isTargetHit()){
      targetTimer = TARGET_INVISIBLE-1;
      score++;
      blowUpTimer = BLOWUP_ON;
      hitX = mouseX;
      hitY = mouseY;
    }
    
    drawScore();
    
    if(blowUpTimer > 0){
       stroke(0,0,0);
       drawSprite(crackedTarget, hitX, hitY, 8);
       blowUpTimer--;
    }
      
    pg.endDraw();
      
  }
}



void drawSprite(int[][] sprite, int x, int y, int scale){
  
  for(int i = 0; i < sprite.length; i++){
     for(int j=0; j < sprite[i].length; j++){
         
       if(sprite[i][j] == 1)
          rect(x+j*scale, y+i*scale, scale, scale);
    }
  }
}


boolean isTargetHit(){
 
   if(targetTimer < TARGET_INVISIBLE){
       return false;
   }
   
   if(mouseX >= targetX && mouseX <= targetX + 48){
     if(mouseY >= targetY && mouseY <= targetY + 72){
        if(mouseButton == LEFT){
          return true; 
        }
     }
   }
   
   return false;
}

void drawScore(){
 
  fill(0,0,0);
  textSize(32);
  text("Score: " + score, 100, 50);
}

void keyPressed(){

}

void updateTarget(){
 
  if(targetTimer < 0){
   targetTimer = TARGET_INVISIBLE + TARGET_VISIBLE; 
   targetX = (int)random(70)*10;
   targetY = (int)random(60)*10;
  }
  
  targetTimer--;
  
}
