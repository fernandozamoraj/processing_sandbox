class EnemySquadron{
 
  EnemyShip[] sprites;
  public int DownSteps = 0;
  
  public EnemySquadron(){
     
    sprites = new EnemyShip[45];
    int xOffsetSpace = 3;
    int k = 0;
    for(int i=0; i< 5; i++){
       for(int j=0; j<9;j++){
         sprites[k] = new EnemyShip();
         int w = sprites[k].Image[0].length;
         sprites[k].X = j*w+10*j;
         sprites[k].Y = i*w+10*i;
         sprites[k].parent = this;
         k++;
       }
    }
  }
  public EnemyShip[] getSprites(){
    return sprites;    
  }
  
  public void update(int scale, int maxX, int lowerY, int maxY){
   
    for(EnemyShip sp: sprites){
      if(sp.hitsWall(scale, maxX))
      {
        bounceBack();
        DownSteps++;
        break;
      }
    }
    
    for(EnemyShip sp: sprites){
      sp.update(scale, maxX);
    }
  }
  
  public int liveEnemiesCount(){
    int count = 0;
    for(EnemyShip sp: sprites){
      if(sp.isAlive())
      {
        count++;
      }
    }
    return count;
  }
  
  public void bounceBack(){
    for(EnemyShip sp: sprites){
      
      sp.DX *= -1;
      sp.Y += sp.Image[0][0].length;
      sp.X += sp.DX;
    }
  }
}
