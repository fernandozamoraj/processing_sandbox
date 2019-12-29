class EnemyBullet extends Sprite{
  
  public EnemyBullet() {
    super("Bullet", 0,0,200,250,250, 0, 0);
    int[][][] image = new int[][][]{
    {
        {1},
        {1},
        {1},
       }
    };
    
    setImage(image); 
    X = -1;
    Y = -1;
    DX = 4;
  }
  
  public void update(){
    if(isAlive(800)){
      Y += DX; 
    }
    else{
      Y = -10; 
    }
  }
  
  public void killBullet(){
    Y = -10; 
  }
  
  public boolean isAlive(int maxY){
    return Y > 0 && Y < maxY;
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
