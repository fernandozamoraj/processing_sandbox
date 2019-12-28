
class Bubble{
 
  public int X;
  public int Y;
  public int R;
  public int G;
  public int B;
  public int Diameter;
  public int DX;
  public int DY;
  
  public Bubble(){
     X = 0;
     Y  = 0;
     R = 200;
     G = 0;
     B = 0;
     Diameter = (int)(random(5)+1)*20;
  }
  
}

PGraphics pg;
int delta_bat_x = 0;
Bubble[] bubbles;

void setup(){
 size(800,800); 
 pg = createGraphics(width, height);
 bubbles = new Bubble[50];

 for(int i=0; i < bubbles.length; i++){
    bubbles[i] = new Bubble();
    
    bubbles[i].X = (int)random(width);
    bubbles[i].Y = (int)random(height);
    bubbles[i].R = (int)random(25)*10;
    bubbles[i].G = (int)random(25)*10;
    bubbles[i].B = (int)random(25)*10;
    bubbles[i].Diameter = (int)random(5)*40;
    
    bubbles[i].DX = (int)random(6)-3;
    bubbles[i].DY = (int)random(6)-3;
    
    
 }
 
}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    for(int i=0; i < bubbles.length; i++){
      
       bubbles[i].X += bubbles[i].DX;
       bubbles[i].Y += bubbles[i].DY;
       
       if(bubbles[i].X < -50) bubbles[i].X = width;
       else if(bubbles[i].X > width+50) bubbles[i].X = -49;
       if(bubbles[i].Y < -50) bubbles[i].Y = height;
       if(bubbles[i].Y > height+50) bubbles[i].Y = -49;
       
       fill(bubbles[i].R, bubbles[i].G, bubbles[i].B);
       
       stroke(bubbles[i].R, bubbles[i].G, bubbles[i].B);
       ellipse(bubbles[i].X, bubbles[i].Y, bubbles[i].Diameter, bubbles[i].Diameter); 
    }
      
    pg.endDraw();
      
  }
}
