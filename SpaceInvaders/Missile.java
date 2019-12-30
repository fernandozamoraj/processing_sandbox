class Missile extends Sprite{
  
    public Missile() {
    
      super("Bullet", 0,0,250,250,100, 0, 0);
    
     int[][][] image = new int[][][]{
       {
        {0,1,0},
        {1,1,1},
        {0,0,0},
        {1,1,1},
        {0,0,0},
        {1,1,1},
       }
      };
     setImage(image); 
     X = -1;
     Y = -1;
     DX = -4;
  }
  
  public void update(){
    if(isAlive()){
      Y += DX; 
    }
    else{
      Y = -10; 
    }
  }
  
  public void killBullet(){
    Y = -10; 
  }
  
  public boolean isAlive(){
    return Y > -1;
  }
  
  public void launch(int x, int y){
     X = x;
     Y = y;
  }
  
  public boolean hitAlien(int x, int y, int w, int l){
    
    if(X >= x && X <= x + w){
      if(Y >= y && Y <= y+l){
        return true; 
      }
    }
    
    return false;
  }
}
