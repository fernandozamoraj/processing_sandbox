class PlayerShip extends Sprite{
  
  int health = 3;
  
  public PlayerShip() {
    
    super("Player", 0,0,250,250,250, 0, 0);
    
    int[][][] image = new int[][][]{
       {
       {0,0,0,1,0,0,0},
       {0,0,0,1,0,0,0},
       {0,0,1,1,1,0,0},
       {0,1,1,1,1,1,0},
       {1,1,1,1,1,1,1},
       {0,0,1,1,1,0,0},
       {0,0,0,1,0,0,0}
       }
      };
     setImage(image); 
     X = 90;
     Y = 100;
     DX = 5;
  }
  
  public void update(int shipDirection, int scale, int maxX){
    if(shipDirection == 1){
       if(X*scale > 0)
         X -= DX; 
    }
    else if(shipDirection == 2){
       if(X*scale + DX*scale + 7*scale < maxX)
         X += DX; 
    }
  }
  
  public void takeHit(){
    
     health--;
    
     if(health == 2){
       int[][][] image = new int[][][]{
         {
         {0,0,0,1,0,0,0},
         {0,0,0,1,0,0,0},
         {0,0,1,1,1,0,0},
         {0,1,0,1,1,1,0},
         {1,1,0,1,1,1,1},
         {0,0,0,1,1,0,0},
         {0,0,0,1,0,0,0}
         }
        };
        setImage(image);
     }
     
     if(health == 1){
        int[][][] image = new int[][][]{
         {
         {0,0,0,1,0,0,0},
         {0,0,0,1,0,0,0},
         {0,0,0,1,1,0,0},
         {0,0,0,0,1,0,0},
         {1,0,0,0,1,1,1},
         {0,0,0,0,1,0,0},
         {0,0,0,1,0,0,0}
         }
        };
        setImage(image);
     }
  }
  
  public boolean isAlive(){
    return health > 0; 
  }
  
  public int top(){
    return X - Image[0].length;
  }
}
