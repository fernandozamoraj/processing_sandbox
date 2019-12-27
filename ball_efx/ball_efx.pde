int ball_x = 0;
int ball_y = 0;
int bat_x = 0;
int bat_y = 0;
int delta_x = -3;
int delta_y = -3;
int BAT_WIDTH = 200;
int BALL_DIAMETER = 10;
PGraphics pg;
int delta_bat_x = 0;

void setup(){
 size(800,800); 
 pg = createGraphics(width, height);
 bat_x = width/2-BAT_WIDTH;
 bat_y = height - BALL_DIAMETER;
 ball_x = bat_x;
 ball_y = bat_y-BALL_DIAMETER;
}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    updateBall();
    updateBat();
    updateBallAndBatCollide();
    fill(255,0,0);
    ellipse(ball_x,ball_y, BALL_DIAMETER,BALL_DIAMETER);
    fill(255,255,255);
    rect(bat_x, bat_y, BAT_WIDTH, BALL_DIAMETER);
      
    pg.endDraw();
      
  }
}

void updateBall(){
  ball_x += delta_x;
  ball_y += delta_y;
  
  if(ball_x + delta_x > width){
   delta_x *= -1; 
   ball_x += delta_x;
  }
  else if(ball_x - delta_x < 0){
   delta_x *= -1; 
   ball_x = 1;
  }
  
  if(ball_y - delta_y < 0){
   delta_y *= -1; 
   ball_y = 1;
  }
  else if(ball_y + delta_y > height + 50){
   ball_y = height + 15;
   delta_y *= -1;
  }
}

void updateBat(){
  
  bat_x += delta_bat_x;
}

void keyPressed(){
  delta_bat_x = 0;
  if(key == 'j'){
    delta_bat_x = -5;
  }
  if(key == 'k'){
    delta_bat_x = 5; 
  }
}

void updateBallAndBatCollide(){
 if(ball_x + BALL_DIAMETER >= bat_x && ball_x <= bat_x + BAT_WIDTH){
  if(ball_y >= bat_y && ball_y + BALL_DIAMETER > bat_y){
    ball_y = bat_y - (BALL_DIAMETER*2);
    delta_y *= -1;
  }
 }
}
