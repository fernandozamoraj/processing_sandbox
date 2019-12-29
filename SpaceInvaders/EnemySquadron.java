class EnemySquadron{
 
  Enemy[] sprites;
  
  public EnemySquadron(){
     
    sprites = new Enemy[18];
    int xOffsetSpace = 3;
    int k = 0;
    for(int i=0; i< 3; i++){
       for(int j=0; j<6;j++){
         sprites[k] = new Enemy();
         int w = sprites[k].Image[0].length;
         sprites[k].X = j*w+10*j;
         sprites[k].Y = i*w+10*i;
         k++;
       }
    }
  }
  public Enemy[] getSprites(){
    return sprites;    
  }
  
  public void update(int scale, int maxX, int lowerY, int maxY){
   
    for(Enemy sp: sprites){
      sp.update(scale, maxX);
    }
  }
}
