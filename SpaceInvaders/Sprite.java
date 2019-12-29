class Sprite{

  public String Name;
  public int X;
  public int Y;
  public int R;
  public int G;
  public int B;
  public int DX;
  public int DY;
  public int[][][] Image;
  public Sprite(String name, int x, int y, int r, int g, int b, int dx, int dy){
    
   X = x;
   Y = y;
   R = r;
   G = g;
   B = b;
   DX = dx;
   DY = dy;
  }
  
  public void setImage(int[][][] image){
    Image = image;
  }
}
