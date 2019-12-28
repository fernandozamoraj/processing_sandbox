
PGraphics pg;

class Color{
 public int R;
 public int G;
 public int B;
 
 public Color(int r, int g, int b){
   R = r;
   G = g;
   B = b;
 }
}

class Point{
 
  public int X;
  public int Y;
  public Point(int x, int y){
    
    X = x;
    Y = y;
  }
}

class Line{
  public Point Start;
  public Point End;
  public int Width;
  public Color Color;
  
  public Line(Point start, Point end, Color c){
    Start = start;
    End = end;
    Color = c;
  }
}

int throttle;
ArrayList<Line> lines;

void setup(){
 size(800,800); 
 pg = createGraphics(width, height);
 lines = new ArrayList<Line>();

}

void draw(){
  background(204);
  if(pg != null){
    
    pg.beginDraw();
    pg.clear();
    fill(255,255,255);
    stroke(255,255,255);
    rect(0,0,width, height);

    if(throttle % 5 == 0){
        Point start = new Point((int)random(width), (int)random(height));
        Point end = new Point(start.X + ((int)random(400)-200), start.Y + ((int)random(400)-200));
        Color c = new Color((int)random(10)*25, (int)random(10)*25, (int)random(10)*25); 
       lines.add(new Line(start, end, c)); 
    }
    
    for(Line l : lines){
     
       stroke(l.Color.R, l.Color.G, l.Color.B);
       fill(l.Color.R, l.Color.G, l.Color.B);
       line(l.Start.X, l.Start.Y, l.End.X, l.End.Y);
       
    }
      
    pg.endDraw();
      
  }
  
  throttle++;
  if(throttle > 6000)
    throttle = 0;
}
