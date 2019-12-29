class ScoreBoard{
 public int X;
 public int Y;
 public int Score;
 public int Lives;
 
 public ScoreBoard(){
   Score = 0;
   Lives = 3;
 }
 
 public String[] getLines(){
     String[] lines = new String[2];
     
     lines[0] = "SCORE: " + Score;
     lines[1] = "LIVES: " + Lives;
    
     return lines;
 }
}
