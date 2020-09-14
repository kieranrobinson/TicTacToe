class Cell {
  //Coordinates of cell, and width and height
  float x, y;
  float w, h;
  //What the cell is containing, (-1 empty, 0 circle, 1 cross)
  int state;
  //Whether the cell has already been filled, and can be modified
  boolean canModify;
  
  Cell(float x, float y, float w, float h) {
    this.x = x; 
    // +100 creates a buffer between the cells and the top of the device screen
    this.y = y + 100;
    this.w = w;
    this.h = h;
    //By default cells contain no shape and are modifiable
    state = -1;
    canModify = true;
  }
  
  boolean click(int mx, int my, String turn){
    //If mouse is over cell when clicked, and has not already been filled (is modifiable)
    if(mx > x && mx < x + w && my > y && my < y + h && canModify){
      if(turn == "Circle"){
        //Set state to show cell as filled with circle or cross
        state = 0;  
      } else{
        state = 1;  
      }
      //Was successful, cell filled
      return true;
    }
    //Cell not filled, criteria not met
    return false;
  }
  
  //Draw cell
  void display() {
    stroke (0);
    strokeWeight(4);
    noFill();
    //Draw cell with coordinates, width and height
    rect(x,y,w,h);
    
    
    if(state == -1){
      //Nothing    
    } else if (state == 0) {
      //Draw a circle or a cross depending on state, and set the cell to be unmodifiable in the future
      ellipse(x+w / 2, y+h / 2, w, h);
      canModify = false;
    } else if (state == 1) {
      line(x, y, x+w, y+h); 
      line(x+w, y, x, y+h);
      canModify = false;
    }
  }
  
  //Retrieve the shape stored within the cell (X, O or null)
  String getShape(){
    if(state == 0){
      return "0";  
    } else if(state == 1){
      return "X";  
    } else {
      return "Null";  
    }  
  }
}  
