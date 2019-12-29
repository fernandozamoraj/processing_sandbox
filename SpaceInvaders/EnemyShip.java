class EnemyShip extends Sprite{
  
  int health;
  public int currentImage;
  public EnemySquadron parent;
  
  public EnemyShip() {
    
    super("Alien", 0,0,100,250,100, 1, 0);
    
    health = 3;  
     int[][][] image = new int[][][]{
       {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,1,0,1,1,1,0,1,1,0},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,0,1,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,1,1,0,0}
      },
      {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {1,0,1,1,1,1,1,1,1,0,1},
       {1,1,1,0,1,1,1,0,1,1,1},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,0,1,0,0,0,0,0,1,0,0},
       {0,1,1,0,0,0,0,0,1,1,0}
      }
      
    };
     setImage(image); 
     DX = 6;
  }
  
  public void update(int scale, int maxX){
    
    if(currentImage == 0){
     currentImage = 1; 
    }
    else{
     currentImage = 0; 
    }
    X += DX;
  }
  
  public boolean hitsWall(int scale, int maxX){
    if(X*scale+20*scale > maxX){
       return true;
    }
    else if(X < 0){
      return true;
    }

    return false;
  }
  
  public void takeHit(){
    if(health < 1)
      return;
      
    health--;
    
    if(health == 2){
       int[][][] image = new int[][][]{
         {
       {1,0,0,0,0,0,0,0,0,0,1},
       {0,1,0,0,0,0,0,0,0,1,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,0,0,1,1,1,0,1,1,0},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,1,1,0,0}
         },
      {
       {1,1,0,0,0,0,0,0,1,0,0},
       {0,1,0,0,0,0,0,0,1,0,0},
       {0,0,1,1,1,1,1,1,1,0,0},
       {0,1,0,0,1,1,1,0,1,1,0},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,1,1,1,1,1,1,0,0},
       {0,0,0,0,0,0,0,0,1,0,0},
       {0,0,0,1,1,0,0,0,1,1,0}
         },
        };
       setImage(image);
    }
    if(health == 1){
       int[][][] image = new int[][][]{
         {
       {1,0,0,0,0,0,0,0,0,0,0},
       {0,1,0,0,0,0,0,0,0,0,0},
       {0,0,1,1,1,0,0,1,1,0,0},
       {0,1,0,0,1,0,1,0,1,1,0},
       {0,0,0,1,1,0,0,0,0,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,0,0,0,0}
         },
                  {
       {1,0,0,0,0,0,0,0,0,0,0},
       {0,1,0,0,0,0,0,0,0,0,0},
       {0,0,1,1,1,0,0,1,1,0,0},
       {0,1,0,0,1,0,1,0,1,1,0},
       {0,0,0,1,1,0,0,0,0,0,1},
       {0,0,0,1,1,1,1,1,1,0,1},
       {0,0,0,0,0,0,0,0,1,0,1},
       {0,0,1,1,0,0,0,0,0,0,0}
         }
         
        };
       setImage(image);
    }
  }
  
  public boolean isAlive(){
   return health > 0; 
  }
}
