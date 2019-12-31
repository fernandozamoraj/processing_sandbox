

/*
   Author: Fernando Zamora
   Description:
   In this program I will attempt to draw out a binary search tree from 16 random values





*/

int currentIndex = 0;
int frameCount = 0;
int MAX_NODES = 16;

class Tree{
 
  public Node root = null;
  
 
  public void add(int value){  
    
    int row = 1;
    int column = 1;
  
    if(root == null){
       root = new Node(value, row, column); 
    }
    else{
     
       if(root.data.value >= value){
          row++;
          column = 1;
          goleft(root, value, row, column); 
       }
       else{
          row++;
          column++;
          goright(root, value, row, column);
       }
    }    
  }
  
  private void goleft(Node node, int value, int row, int column){
    if(node.left == null)
    {
       node.left = new Node(value, row, column); 
    }
    else{
       if(node.left.data.value >= value){
          row++;
          goleft(node.left, value, row, column); 
       }
       else{
         row++;
         column++;
         goright(node.left, value, row, column);
       }
    }
  }
  
  private void goright(Node node, int value, int row, int column){
    if(node.right == null)
    {
       node.right = new Node(value, row, column); 
    }
    else{
       if(node.right.data.value >= value){
          row++;
          goleft(node.right, value, row, column); 
       }
       else{
         row++;
         column++;
         goright(node.right, value, row, column);
       }
    }
  }
}




class Node{
 
  Data data = null;
  Node left = null;
  Node right = null;
  
  Node(int value, int row, int column){
    this.data = new Data(value, new Position(row,column)); 
  }
}

class Data{
 
  public int value;
  public Position position;
  
  public Data(int value, Position position){
   
    this.value = value;
    this.position = position;
  }  
}

class Position{
   public int row;
   public int column;
   
   Position(int row, int column){
    
     this.row = row;
     this.column = column;
   }
}

int[] values;

  
Tree tree;

PFont font;

void setup(){
 
  //Setup up the size to fit
  size(1200, 800);
  
  //draw a light colored screen
  background(220, 240, 230);
  
  //set the fill to white
  fill(255);
  font = createFont("Arial", 10, true);
  textFont(font, 10);
  rectMode(CENTER);
  
  init();
}

void init(){
  tree = new Tree();
  values = getValues();
  currentIndex = 0;
  frameCount = 0;
}


void draw(){
 
  background(220, 240, 230);
   frameCount++;
   int nextValue = -1;
   if(frameCount == 20 && (currentIndex+1) < MAX_NODES){
     nextValue = values[currentIndex++];
     println("CurrentIndex: " + currentIndex);
     frameCount = 0;
   }

   if(nextValue > -1){
     tree.add(nextValue);
   }

   
   drawNode(tree.root, 0);
}

void keyPressed(){
 
  if(key == 's') init();
}


void drawNode(Node node, int offset){
   
    if(node != null){
      int row = node.data.position.row;
      int column = node.data.position.column;
      int xPosition = (1100 / (node.data.position.row+1))*column+offset;
      int yPosition = row * 50;
      fill(255);
      rect(xPosition, yPosition,  20, 20); 
      fill(0);
      text(""+node.data.value + " [" + node.data.position.row +", " + node.data.position.column +"]", xPosition-5, row*50+5);
      println("drew at: " + xPosition + " " + (row * 100) + " ");
      
      if(node.left != null){
        
          int x2Position = (1100 / (node.left.data.position.row+1))*column+20;
          int y2Position = node.left.data.position.row * 50;
          line(xPosition, yPosition+10, x2Position, y2Position);
      }
      
     if(node.right != null){
        
          int x2Position = (1100 / (node.right.data.position.row+1))*(column+1)-20;
          int y2Position = node.right.data.position.row * 50;
          line(xPosition, yPosition+10, x2Position, y2Position);
      }
      
      drawNode(node.left, 20);
      drawNode(node.right, -20);
    }
}

int[] getValues(){
 
  int[] values = new int[16];
  
  for(int i= 0; i < 16; i++){
     values[i] = (int)random(0, 100); 
     println("Got: " + values[i]);
  }
  
  return values;
  
}