
var w=window,d=document,e=d.documentElement,g=d.getElementsByTagName('body')[0],wid=w.innerWidth||e.clientWidth||g.clientWidth,height=w.innerHeight||e.clientHeight||g.clientHeight;
console.log(d.getElementById('snake-container').clientHeight);

int squareWidth = 15;
int squareHeight = 15;
int numColumns = 0;
int numRows =  0;
int squareX = -1;
int squareY = -1;
int foodX = -1;
int foodY = -1;
ArrayList<PVector> snake;
int length; //length of snake
int i; //index for building snake from 0
int direction; //direction snake is moving
boolean isFood = false;
PVector food;
int score = 0;
PVector head;
boolean dead = false;
int width, height;

void setup() {
  //size(200, 200); // size of the screen
  doResize();
  background(255); // white background
  stroke(255); // the thin line around the squares is white
  frameRate(20);

  numColumns = int(width/squareWidth); // number of columns in grid
  numRows = int(height/squareHeight);  // number of rows in grid
  console.log("cols, rows", numColumns, numRows);
  length = 5; //starting length of snake
  i = 0;
  direction = RIGHT;
  snake = new ArrayList<PVector>();
  while (i < length) {
    snake.add(new PVector(0, 0));
    i++;
  }

  food = new PVector();
  head = snake.get(0);

}


void draw() {
  background(255);

  if(!dead) {
    wrap(snake);
    drawSnake(snake, 0);
    drawFood();
    text(score, width-10, height-10)
  } else {

    drawSnake(snake, color(255, 0, 0));
    // = createFont("Monospaced", 24);
    //textFont(serif);
  //  fill(0);
    //textAlign(CENTER, BOTTOM)
//    text("Press space to restart", width/2, height/2);
  //  textSize(15);
    //text("Score: " + score, width/2 , height/2);
    frameRate(0);
  }
}

void keyPressed() {
  if (key.code == 32) {
     if (dead) {
      dead = false;
      setup();
    }
  }
  switch(keyCode) {
    case UP:
      if(direction != DOWN) {
        direction = keyCode;
      }
      break;
     case DOWN:
       if(direction != UP) {
         direction = keyCode;
       }
       break;
     case RIGHT:
       if(direction != LEFT) {
         direction = keyCode;
       }
       break;
     case LEFT:
       if(direction != RIGHT) {
         direction = keyCode;
       }
       break;
  }
}

void wrap(ArrayList<PVector> snake) {
  head = snake.get(snake.size()-1); //get the head of snake
  if (i < length) { //if it has just eaten a food, add another link to the snake. draw it "on top" of the last element of the snake so it won't show up until the end
    snake.add(new PVector(head.x, head.y));
    i++;
  }

    snake.remove(0); //remove the tail of snake
    switch(direction) {
    case RIGHT:
      snake.add(new PVector((head.x+1)%numColumns, head.y));
      break;
    case DOWN:
      snake.add(new PVector(head.x, (head.y + 1)%numRows));
      break;
    case LEFT:
      //special case: if new x pos is negative, modulo won't work
      float newX = head.x-1;
      if (newX < 0) {
        newX = newX+numColumns;
      }
      snake.add(new PVector(newX, head.y));
      break;
    case UP:
      //special case: if new y pos is negative, modulo won't work
      float newY = head.y-1;
      if (newY < 0) {
        newY = newY+numRows; //instead add number you were gonna mod
      }
      snake.add(new PVector(head.x, newY));
      break;
    }

    if(equalsSelf(snake.get(snake.size()-1))) {
      dead = true;
    }

    if (equalsFood(snake.get(snake.size()-1), food)) {
      isFood = false;
      score++;
      length++;

    }
}

void drawSnake(ArrayList<PVector> snake, color c) {
  fill(c);
  for (PVector point : snake) { //draw the snake
    squareY = int(point.y) * squareHeight;
    squareX = int(point.x) * squareWidth;
    rect(squareX, squareY, squareWidth, squareHeight);
  }
}

void drawFood() {
  if(isFood) {
      foodX = int(food.x) * squareWidth + squareWidth/2; //make center of ellipse center of square
      foodY = int(food.y) * squareHeight + squareHeight/2;
      ellipse(foodX, foodY, squareWidth, squareHeight);
    } else {
    food = new PVector();
    int x = int(random(numColumns));
    int y = int(random(numRows));
    if (!snake.contains(new PVector(x, y))) {
      food.y = y;
      food.x = x;
      isFood = true;
    }
   }

}

boolean equalsFood(PVector pt, PVector food) {
  if(pt.x == food.x && pt.y == food.y) {
    return true;
  } else {
    return false;
  }
}

boolean equalsSelf(PVector newpt) {
  for(int j = 0; j<snake.size()-2; j++) {
    if (snake.get(j).x == newpt.x && snake.get(j).y == newpt.y) {
      return true;
    }
  }
  return false;
}

void doResize() {
  console.log("Resizing");
  height = document.getElementById('snake-container').clientHeight;
  width = document.getElementById('snake-container').clientWidth;
  size(width, height);
}

window.onresize = doResize();
