
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
       int d = bubbles[i].Diameter;
       
       if(bubbles[i].X < -d) bubbles[i].X = width;
       else if(bubbles[i].X > width+1) bubbles[i].X = -d;
       if(bubbles[i].Y < -d) bubbles[i].Y = height;
       if(bubbles[i].Y > height) bubbles[i].Y = -d;
       
       fill(bubbles[i].R, bubbles[i].G, bubbles[i].B);
       
       stroke(bubbles[i].R, bubbles[i].G, bubbles[i].B);
       ellipse(bubbles[i].X, bubbles[i].Y, bubbles[i].Diameter, bubbles[i].Diameter);
       
       fill(255,255,255);
       stroke(255,255,255);
       ellipse((float)bubbles[i].X-d/4, (float)bubbles[i].Y-d/4, d/8, d/8); 
    }
      
    pg.endDraw();
      
  }
}
