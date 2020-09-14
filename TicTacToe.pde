//2D array containing each board cell
Cell[][] board;

//Gamestates
int state = 0;

//Number of columns and rows that the board contains
int cols = 3;
int rows = 3;

//Width and height of the columns and rows
int colWidth;
int colHeight;

//Coordinates for the reset game button
float resetButtonX;
float resetButtonY;

//Player turn ("Circle" or "Cross")
String turn;

//Called on first launch
void setup() {
  //Set application to fullscreen and instantiate variables
  fullScreen();
  resetButtonX = width / 2;
  resetButtonY = (height / 4) * 3;
  colWidth = (width/cols);
  colHeight = (width/cols);
  turn = "Circle";
  drawBoard();
}

//Called every frame
void draw() {
  switch(state) {
  case 0:
    displayMenu();
    break;
  case 1:
    displayGame();
    break;
  case 2:
    displayVictory();
  }
}

//State 0
void displayMenu() {
  //Set background to white and display "tap to start" message on screen
  background(255);
  fill(0);
  textSize(37.5 * displayDensity);
  textAlign(CENTER);
  text("Tap to start", width/2, height/2);
}

//State 1
void displayGame() {
  //Set background to white and populate board
  background(255);
  rectMode(CORNER);
  for (int i=0; i < cols; i++) {
    for (int j=0; j < rows; j++) {
      board[i][j].display();
    }
  }

  //Draw reset button
  rectMode(CENTER);
  rect(resetButtonX, resetButtonY, 125 * displayDensity, 62.5 * displayDensity);
  textSize(21 * displayDensity);
  fill(0);
  //Display "RESET" text inside of reset button
  textAlign(CENTER);
  text("RESET", resetButtonX, resetButtonY);
  //If there is a winner, change state to displayVictory
  if (checkWin() != null) {
    state = 2;
  }
}

//State 2
void displayVictory(){
  //Get winner ("X" or "O")
  String winner = checkWin();
 
  background(255);
  textSize(37.5 * displayDensity);
  textAlign(CENTER);
  fill(0);  
  stroke(0);
  strokeWeight(10);
  if(winner == "X"){
    //Draw a cross on the screen
    int lineLength = width / 4;
    line(width/2 - lineLength / 2, height/2.5 - lineLength / 2, width/2 + lineLength/2, height/2.5 + lineLength/2);
    line(width/2 + lineLength / 2, height/2.5 - lineLength / 2, width/2 - lineLength/2, height/2.5 + lineLength /2);
  } else if(winner == "O"){
    //Draw a circle on the screen
    noFill();
    ellipse(width/2, height/2.5, width/4, width/4);
  }
  text("is the winner", width/2, height/1.75);  
}

//Runs whenever screen is touched
void mousePressed() {
  //Changes gamestate from menu to game
  if (state == 0) {
    state = 1;
    //Checks if a board cell has been clicked successfully
  } else if (state == 1) {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        if (board[i][j].click(mouseX, mouseY, turn)) {
          //If board cell has been successfully filled, change turn
          changeTurn();
        }
      }
    }

    //If the reset button is pressed, reinstantiate array of board cells
    if (mouseX > resetButtonX-250 && mouseX < resetButtonX+250 && mouseY > resetButtonY-125 && mouseY < resetButtonY+125) {
      drawBoard();
    }
    //If on the winner screen when screen is touched, reset cell board and change gamestate back to game
  } else if(state == 2){
    drawBoard();
    state = 1;    
  }
}

//Instantiate 2D array containing the individual board cells
void drawBoard() {
  board = new Cell[cols][rows];
  for (int i=0; i < cols; i++) {
    for (int j=0; j < rows; j++) {
      board[i][j] = new Cell(i * colWidth, j * colHeight, colWidth, colHeight);
    }
  }
}

//Flip turns between circle and cross
void changeTurn() {
  if (turn.equals("Circle")) {
    turn = "Cross";
  } else {
    turn = "Circle";
  }
}

//Check possible win combinations for a matching line. Returns "0" or "X" if they have won, else returns null
String checkWin() {
  for (int i=0; i<8; i++) {
    String line = null;
    switch(i) {     
    case 0:
      line = board[0][0].getShape() + board[0][1].getShape() + board[0][2].getShape();
      break;
    case 1:
      line = board[1][0].getShape() + board[1][1].getShape() + board[1][2].getShape();
      break;
    case 2:
      line = board[2][0].getShape() + board[2][1].getShape() + board[2][2].getShape();
      break;
    case 3:
      line = board[0][0].getShape() + board[1][0].getShape() + board[2][0].getShape();
      break;
    case 4:
      line = board[0][1].getShape() + board[1][1].getShape() + board[2][1].getShape();
      break; 
    case 5:
      line = board[0][2].getShape() + board[1][2].getShape() + board[2][2].getShape();
      break;    
    case 6:
      line = board[0][0].getShape() + board[1][1].getShape() + board[2][2].getShape();
      break;   
    case 7:
      line = board[0][2].getShape() + board[1][1].getShape() + board[2][0].getShape();
      break;
    }

    if (line != null) {
      if (line.equals("XXX")) {
        return "X";
      } else if (line.equals("000")) {
        return "O";
      }
    }
  }
  //Return null if there is no winner
  return null;
}
