/*
  Author: Fernando Zamora
  Description: simulation of the planets orbiting the sun... did not include pluto
  Notes: This is not an accurate simulation... I tried scaling things to be actual
  but it proved nearly imposible because the distances between some planets are far too great
  also the speed variances at which they travel around the sun is vast too great
  so even those rations are not correct
  The sizes are not correctly scaled either because most planets would probably dissappear off the screen.
  About the only thing that is accurate is the the order of the planets from the sun
  and their primary colors.
  Other than that it is just a fun little program to create.
*/
class Planet{

  public String Name;
  public int X;
  public int Y;
  public int R;
  public int G;
  public int B;
  public int Diameter;
  public int DX;
  public int DY;
  public int Distance;
  public int RevolutionSpeed;
  public float Direction = 0;
  
  public Planet(String name, int distance, int size, int r, int g, int b, int revolutionSpeed){
     X = 0;
     Y  = 0;
     R = r;
     G = g;
     B = b;
     Name = name;
     Distance = distance;
     Diameter = size;
     RevolutionSpeed = revolutionSpeed;
  }
}

class Star{
 
  public int X;
  public int Y;
}

PGraphics pg;
int delta_bat_x = 0;
Planet[] planets;
Star[] stars;
int cycleThrottle = 0;

void setup(){
 size(1200,1200); 
 pg = createGraphics(width, height);
 planets = new Planet[9];

 planets[0] = new Planet("Sun", 0, 100, 200, 200, 0, 0);
 planets[1] = new Planet("Mercury", 21, 3, 150,150,150, 40);
 planets[2] = new Planet("Venus", 39, 7, 250,250, 200, 80);
 planets[3] = new Planet("Earth", 54, 8, 50,50,200,60);
 planets[4] = new Planet("Mars", 84, 4, 250,100,100, 32);
 planets[5] = new Planet("Jupiter", 150, 43, 250,200,0,16);
 planets[6] = new Planet("Saturn", 200, 36, 250,250,0,12);
 planets[7] = new Planet("Uranus", 325, 31, 100,200,250,8);
 planets[8] = new Planet("Neptune", 430, 30, 120,220, 240,5);
 
 stars = new Star[100];
 
 for(int i=0 ;i < stars.length; i++){
  
   stars[i] = new Star();
   stars[i].X = (int)random(1200);
   stars[i].Y = (int)random(1200);
 }
 
 cycleThrottle = 0;
 
}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    
    stroke(0,0,0);
    fill(0,0,0);
    rect(0,0,width,height);
    
    updatePlanets();
    drawStars();
    drawPlanets();

    pg.endDraw();
      
  }
  
  cycleThrottle++;
  if(cycleThrottle > 6000){
    cycleThrottle = 0; 
  }
}

void updatePlanets(){
 
  if(cycleThrottle % 10 != 0)
    return;
    
  int middleX = width/2;
  int middleY = height/2;
    
  for(Planet p : planets){
    if(p.Name.equals("Sun")){
      p.X = middleX;
      p.Y = middleY;
      continue;
    }
    int distance = planets[0].Diameter/2+p.Distance;
    p.Direction += (p.RevolutionSpeed*.2);
    if(p.Direction > 360){
       p.Direction -= 360;
    }

    p.X = middleX + (int)(cos(radians(p.Direction))*distance);
    p.Y = middleY + (int)(sin(radians(p.Direction))*distance);
    
  }
}

void drawPlanets(){
  
   //int middleX = width/2;
   //int middleY = height/2;
  for(Planet p : planets){
   
    
    fill(p.R, p.G, p.B);
    stroke(p.R, p.G, p.B);
    /*if(p.Name.equals("Sun"))
       p.X = middleX; //sscale divide by 2 to fit screen
    else
      p.X = middleX + (planets[0].Diameter/2)+p.Distance; //sscale divide by 2 to fit screen
    p.Y = middleY;*/
    ellipse(p.X, p.Y, p.Diameter, p.Diameter);
    
  }
}

void drawStars(){
 
  for(Star s: stars){
   
    stroke(255,255,255);
    fill(255,255,255);
    ellipse(s.X, s.Y, 1, 1);
  }
  
}
