class AlienFonts{
  
  public AlienFonts(){
    
  }
  
  public int[][] getSprite(String message){
   
    int[][] map = new int[5][];
    
    for(int i=0; i < map.length; i++){
      map[i] = new int[message.length() * 5]; 
    }

    for(int i=0; i< message.length(); i++){
      appendToMap(map, i*5, message.charAt(i)); 
      i++;
    }
    
    return map;
  }
  
  private void appendToMap(int[][] sprite, int startingPoint, char ch){
    
    int[][] spriteChar = getChar(ch);
    for(int i=0;i < 5; i++){
       for(int j=0; j < 5; j++){
         sprite[i][startingPoint+j] = spriteChar[i][j]; 
       }
    }
  }
  
  private int[][] getChar(char ch){
    
    int[][] result = null;
    
    switch(ch){
     case ' ': 
       result = new int[][]{
         {0,0,0,0,0},
         {0,0,0,0,0},
         {0,0,0,0,0},
         {0,0,0,0,0},
         {0,0,0,0,0}
       }; break;
     case '0': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0},
         {0,1,1,0,0}
       }; break;
     case '1': 
       result = new int[][]{
         {0,1,0,0,0},
         {1,1,0,0,0},
         {0,1,0,0,0},
         {0,1,0,0,0},
         {1,1,1,0,0}
       }; break;      
     case '2': 
       result = new int[][]{
         {1,1,1,0,0},
         {0,0,0,1,0},
         {0,1,1,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0}
       }; break;     
     case '3': 
       result = new int[][]{
         {1,1,1,1,0},
         {0,0,1,0,0},
         {0,1,1,0,0},
         {0,0,0,1,0},
         {1,1,1,0,0}
       }; break; 
     case '4': 
       result = new int[][]{
         {1,0,0,1,0},
         {1,0,0,1,0},
         {1,1,1,1,0},
         {0,0,0,1,0},
         {0,0,0,1,0}
       }; break; 
     case '5': 
       result = new int[][]{
         {1,1,1,1,0},
         {1,0,0,0,0},
         {1,1,1,0,0},
         {0,0,0,1,0},
         {1,1,1,0,0}
       }; break;  
     case '6': 
       result = new int[][]{
         {0,1,1,1,0},
         {1,0,0,0,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {1,1,1,1,0}
       }; break;   
     case '7': 
       result = new int[][]{
         {1,1,1,1,0},
         {0,0,0,1,0},
         {0,0,1,0,0},
         {0,1,0,0,0},
         {1,0,0,0,0}
       }; break;  
     case '8': 
       result = new int[][]{
         {0,1,1,1,0},
         {1,0,0,1,0},
         {0,1,1,0,0},
         {1,0,0,1,0},
         {0,1,1,0,0}
       }; break; 
     case '9': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,1,0},
         {0,1,1,1,0},
         {0,0,0,1,0},
         {0,1,1,0,0}
       }; break;
     case 'a': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,1,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0}
       }; break;  
       
    case 'b': 
       result = new int[][]{
         {1,1,1,0,0},
         {1,0,0,1,0},
         {1,1,1,0,0},
         {1,0,0,1,0},
         {1,1,1,0,0}
       }; break;  
       
    case 'c': 
       result = new int[][]{
         {0,1,1,1,0},
         {1,0,0,0,0},
         {1,0,0,0,0},
         {1,0,0,0,0},
         {0,1,1,1,0}
       }; break;  
       
    case 'd': 
       result = new int[][]{
         {1,1,1,0,0},
         {1,0,0,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0},
         {1,1,1,0,0}
       }; break;  
    case 'e': 
       result = new int[][]{
         {1,1,1,1,0},
         {1,0,0,0,0},
         {1,1,1,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0}
       }; break;
    case 'f': 
       result = new int[][]{
         {1,1,1,1,0},
         {1,0,0,0,0},
         {1,1,1,0,0},
         {1,0,0,0,0},
         {1,0,0,0,0}
       }; break; 
    case 'g': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {0,1,1,0,0}
       }; break; 
    case 'h': 
       result = new int[][]{
         {1,0,0,1,0},
         {1,0,0,1,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0}
       }; break;
    case 'i': 
       result = new int[][]{
         {0,1,1,1,0},
         {0,0,1,0,0},
         {0,0,1,0,0},
         {0,0,1,0,0},
         {0,1,1,1,0}
       }; break; 
   case 'j': 
       result = new int[][]{
         {0,1,1,1,0},
         {0,0,1,0,0},
         {0,0,1,0,0},
         {1,0,1,0,0},
         {1,1,0,0,0}
       }; break; 
    case 'k': 
       result = new int[][]{
         {1,0,0,1,0},
         {1,0,1,0,0},
         {1,1,0,0,0},
         {1,0,1,0,0},
         {1,0,0,1,0}
       }; break; 
   case 'l': 
       result = new int[][]{
         {1,0,0,0,0},
         {1,0,0,0,0},
         {1,0,0,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0}
       }; break; 
   case 'm': 
       result = new int[][]{
         {1,0,0,1,0},
         {1,1,1,1,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0}
       }; break; 
   case 'n': 
       result = new int[][]{
         {1,0,0,1,0},
         {1,1,0,1,0},
         {1,0,1,1,0},
         {1,0,0,1,0},
         {1,0,0,1,0}
       }; break; 
         case 'o': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {0,1,1,0,0}
       }; break; 
           case 'p': 
       result = new int[][]{
         {0,1,1,0,0},
         {1,0,0,0,0},
         {1,1,1,1,0},
         {1,0,0,1,0},
         {0,1,1,0,0}
       }; break; 
     default: 
       result = new int[][]{
         {0,0,0,0,0},
         {0,0,0,0,0},
         {0,0,0,0,0},
         {0,0,0,0,0},
         {1,1,1,1,0}
       };     
    }
    
    
    return result;
  }
}
