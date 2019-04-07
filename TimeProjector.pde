OPC opc;
TesseractPerspective[] tesseractPerspectives;
GlobalAnimator globalAnimator;
static TimeProjectorForm timeProjectorForm;

int ledCount = 0;

int faceWidth, faceHeight;
int squareX, squareY;

//boolean reversedLateralSweep = false;

int _width, _height;
int padding = 25;

//test variables
int lastVertexIndex = 0;
int currentVertexIndex = 0;
int speed = 50;

ArrayList<PVector> snake;

void setup()
{
  size(700, 400, P3D);
  ortho();

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //drawPixels();

  faceWidth = width/3;
  faceHeight = height/8;
  _width = 600;
  _height = 300;

  tesseractPerspectives = new TesseractPerspective[6];

  tesseractPerspectives[0] = new TesseractPerspective(padding + _width/6, padding + _height/4, 0, 0, 0, 0);
  tesseractPerspectives[1] = new TesseractPerspective(50 + _width/2, 25 + _height/4, 0, PI/2, 0, 0);
  tesseractPerspectives[2] = new TesseractPerspective(width - _width/6 - padding, 25 + _height/4, 0, 0, 0, PI/2);
  tesseractPerspectives[3] = new TesseractPerspective(padding + _width/6, height - padding - _height/4, 0, 0, 0, PI);
  tesseractPerspectives[4] = new TesseractPerspective(50 + _width/2, height - 25 - _height/4, 0, -PI/2, 0, 0);
  tesseractPerspectives[5] = new TesseractPerspective(width - _width/6 - padding, height - 25 - _height/4, 0, 0, 0, 3*PI/2);

  globalAnimator = new GlobalAnimator(tesseractPerspectives);

  timeProjectorForm = new TimeProjectorForm();

  snake = new ArrayList<PVector>();



  drawAllTimeProjectorForms();
  ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 27, 0);
  ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 28, 0);
  ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 27, 0);
  ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 27, 0);
}


void draw()
{
  if (frameCount%25==0)
    println("FrameRate:" + frameRate);

  println("mouseX:" + mouseX + " mouseY:" + mouseY);

  background(255);
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  //camera(sin(frameCount/80.0)*150 + 350, sin(frameCount/70.0)*100 + 200, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);



  //globalAnimator.runAnimation("growingBox");

  //snakeAnimation();

  //globalAnimator.runAnimation("snake");

  drawVertex(10);
  drawVertex(11);
  drawVertex(15);
  drawVertex(14);

  //ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 5, 0);

  //drawAllTimeProjectorForms();
}




void drawAllTimeProjectorForms()
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.drawEdges();
    tesseractPerspectives[i].resetPerspective();
  }
}


void drawVertex(int vertexNum)
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.drawVertex(vertexNum);
    tesseractPerspectives[i].resetPerspective();
  }
}

void setupTimeProjectorFormFaces()
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    //timeProjectorForm.connectAllPoints();
    timeProjectorForm.drawVertices();
    tesseractPerspectives[i].resetPerspective();
  }
}

void setupTesseractFaces()
{
  drawTesseract(25, 50, padding + _width/6, padding + _height/4, 0, 0, 0, 0);
  drawTesseract(25, 50, 50 + _width/2, 25 + _height/4, 0, PI/2, 0, 0);
  drawTesseract(25, 50, width - _width/6 - padding, 25 + _height/4, 0, 0, PI/2, 0);
  drawTesseract(25, 50, padding + _width/6, height - padding - _height/4, 0, 0, PI, 0);
  drawTesseract(25, 50, 50 + _width/2, height - 25 - _height/4, 0, -PI/2, 0, 0);
  drawTesseract(25, 50, width - _width/6 - padding, height - 25 - _height/4, 0, 0, 3*PI/2, 0);
}


void cyclingSquare(int speed)
{
  stroke(0);
  fill(255, 0, 0);
  rect(squareX, squareY, faceWidth, faceHeight);

  if (frameCount%speed == 0)
  {
    squareX += faceWidth;
    if (squareX >= width)
    {
      squareX = 0;
      squareY += faceHeight;

      if (squareY >= height)
      {
        squareY = 0;
      }
    }
  }
}

void drawFaces()
{
  stroke(255);

  line(width/3, 0, width/3, height);
  line(width-width/3, 0, width-width/3, height);
  line(0, height/2, width, height/2);
}

//-------------------//

void ledStrip(PVector start, PVector end, int numLeds, int perspectiveNum)
{
  float stepValue = (float)1/numLeds;
  PVector pixelVector;

  tesseractPerspectives[perspectiveNum].setupPerspective();

  for (float i=0; i <= 1; i += stepValue)
  {
    pixelVector = PVector.lerp(start, end, i);

    fill(255, 0, 255);
    pushMatrix();
    translate(pixelVector.x, pixelVector.y, pixelVector.z);
    pixelVector.set(0, 0, 0);
    opc.led(ledCount, (int)screenX(pixelVector.x, pixelVector.y, pixelVector.z), (int)screenY(pixelVector.x, pixelVector.y, pixelVector.z));
    popMatrix();

    ledCount++;
  }

  tesseractPerspectives[perspectiveNum].resetPerspective();
}

void ledSquare(int x, int y, int squareWidth, int squareHeight)
{
  for (int i=x; i < x+squareWidth; i++)
  {
    opc.led(ledCount, i, y);
    ledCount++;
  }
  for (int i=y; i<y+squareHeight; i++)
  {
    opc.led(ledCount, x+squareWidth, i);
    ledCount++;
  }
  for (int i=x+squareWidth; i >= x; i--)
  {
    opc.led(ledCount, i, y+squareHeight);
    ledCount++;
  }
  for (int i=y+squareHeight; i>=y; i--)
  {
    opc.led(ledCount, x, i);
    ledCount++;
  }
}

void drawPixels()
{

  ledSquare(width/2 - 15, 30, 30, 30);
  ledSquare(width/2 - 15, 65, 30, 30);
  ledSquare(width/2 + 20, 65, 30, 30);
  ledSquare(width/2 - 50, 65, 30, 30);
  ledSquare(width/2 - 15, 100, 30, 30);
  ledSquare(width/2 - 15, 135, 30, 30);

  ledSquare(width/2 - 10, 200, 20, 20);
  ledSquare(width/2 - 10, 225, 20, 20);
  ledSquare(width/2 + 15, 225, 20, 20);
  ledSquare(width/2 - 35, 225, 20, 20);
  ledSquare(width/2 - 10, 250, 20, 20);
  ledSquare(width/2 - 10, 275, 20, 20);



  //ledStrip(int index, int count, float x, float y, float spacing, float angle, boolean reversed)
  //  opc.ledStrip(0, 30, width/2, 10, 2, 0, false);
  //  opc.ledStrip(30, 30, width/2 + 30, 40, 2, PI/2, false);
  //  opc.ledStrip(60, 30, width/2, 70, 2, 0, true);
  //  opc.ledStrip(90, 30, width/2 - 30, 40, 2, PI/2, true);

  /*
  //green
   for (int y = 0; y < 14; y++)
   {
   opc.led(ledCount, left + spacing * 2, (bottom - 5 * spacing) - y * spacing);
   ledCount++;
   }
   
   for (int y = 0; y < 5; y++)
   {
   opc.led(ledCount, left + spacing, (bottom - 19 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 5; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 2, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 3, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 4; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 4, (bottom - 17 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<3; y++)
   {
   opc.led(ledCount, left + spacing * 5, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   
   
   //blue
   for (int y = 0; y < 14; y++)
   {
   opc.led(ledCount, left + spacing * 3, (bottom - 4 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 5; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 4, (bottom - 12 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 5, (bottom - 13 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 5; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 6, (bottom - 12 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 7, (bottom - 13 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 6; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 8, (bottom - 11 * spacing) - y * spacing);
   ledCount++;
   }
   
   
   //purple
   for (int y = 0; y<10; y++)
   {
   opc.led(ledCount, left + spacing * 4, (bottom - 3 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 9; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 5, (bottom - spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<9; y++)
   {
   opc.led(ledCount, left + spacing * 6, (bottom - spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 8; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 7, (bottom) - y * spacing);
   ledCount++;
   }
   
   
   //orange
   for (int y = 0; y<11; y++)
   {
   opc.led(ledCount, left + spacing * 8, (bottom - spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<7; y++)
   {
   opc.led(ledCount, left + spacing * 9, (bottom - 11 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 7; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 10, (bottom - 10 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 11, (bottom - 13 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 5; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 12, (bottom - 12 * spacing) - y * spacing);
   ledCount++;
   }
   
   //red (new)
   for (int y = 0; y<10; y++)
   {
   opc.led(ledCount, left + spacing * 9, (bottom - spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 10; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 10, (bottom ) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y < 8; y++)
   {
   opc.led(ledCount, left + spacing * 11, (bottom - spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 9; y > 0; y--)
   {
   opc.led(ledCount, left + spacing * 12, (bottom) - y * spacing);
   ledCount++;
   }
   
   //pink
   for (int y = 0; y<9; y++)
   {
   opc.led(ledCount, left + spacing * 13, (bottom - 2 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 9; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 14, (bottom - 2 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<14; y++)
   {
   opc.led(ledCount, left + spacing * 15, (bottom - 4 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 6; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 14, (bottom - 11 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 13, (bottom - 13 * spacing) - y * spacing);
   ledCount++;
   }
   
   
   
   //grayish
   for (int y = 0; y<14; y++)
   {
   opc.led(ledCount, left + spacing * 16, (bottom - 5 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y < 5; y++)
   {
   opc.led(ledCount, left + spacing * 17, (bottom - 19 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 5; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 16, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<5; y++)
   {
   opc.led(ledCount, left + spacing * 15, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 4; y>0; y--)
   {
   opc.led(ledCount, left + spacing * 14, (bottom - 17 * spacing) - y * spacing);
   ledCount++;
   }
   for (int y = 0; y<3; y++)
   {
   opc.led(ledCount, left + spacing * 13, (bottom - 18 * spacing) - y * spacing);
   ledCount++;
   }
   
   println("ledCount:" + ledCount);
   
   */
}

void snakeAnimation()
{
  if (frameCount%speed == 0)
  {
    int tempIndex;
    do
    {
      tempIndex = timeProjectorForm.Vertices.get(currentVertexIndex).getRandomConnectingVertex().index;
    }
    while (tempIndex == lastVertexIndex);

    lastVertexIndex = currentVertexIndex;
    currentVertexIndex = tempIndex;
  }

  //drawMovingVertex();

  addPointToSnake(PVector.lerp(timeProjectorForm.Vertices.get(lastVertexIndex).coordinate, timeProjectorForm.Vertices.get(currentVertexIndex).coordinate, frameCount%speed/(float)speed));
  drawSnake();
}

void addPointToSnake(PVector point)
{
  //move out of function
  int maxLength = 255;

  snake.add(point);
  if (snake.size() > maxLength)
  {
    snake.remove(0);
  }
}

void drawSnake()
{
  noStroke();
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();

    for (int j=0; j<snake.size(); j++)
    {
      //fill((j%255), 255-(j%255), (j%255));
      fill(255);

      pushMatrix();
      translate(snake.get(j).x, snake.get(j).y, snake.get(j).z);
      box(5);
      popMatrix();
    }

    tesseractPerspectives[i].resetPerspective();
  }
}


void drawMovingVertex()
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();

    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    PVector movingVertexPos = PVector.lerp(timeProjectorForm.Vertices.get(lastVertexIndex).coordinate, timeProjectorForm.Vertices.get(currentVertexIndex).coordinate, frameCount%speed/(float)speed);
    translate(movingVertexPos.x, movingVertexPos.y, movingVertexPos.z);
    box(10);
    popMatrix();

    tesseractPerspectives[i].resetPerspective();
  }
}


void drawTesseract(int inside, int outside, int x, int y, int z, float xRot, float yRot, float zRot)
{

  //println(x + " " + y + " " + z);
  noFill();
  stroke(0);
  translate(x, y, z);
  rotateX(xRot);
  rotateY(yRot);
  rotateZ(zRot);

  beginShape();

  //inside top
  vertex(-inside, -inside, -inside);
  vertex(-inside, -inside, inside);
  vertex(inside, -inside, inside);
  vertex(inside, -inside, -inside);
  vertex(-inside, -inside, -inside);

  //inside bottom
  vertex(-inside, inside, -inside);

  vertex(-inside, inside, inside);
  vertex(-inside, -inside, inside);
  vertex(-inside, inside, inside);

  vertex(inside, inside, inside);
  vertex(inside, -inside, inside);
  vertex(inside, inside, inside);

  vertex(inside, inside, -inside);
  vertex(inside, -inside, -inside);
  vertex(inside, inside, -inside);

  vertex(-inside, inside, -inside);

  //outside bottom
  vertex(-outside, outside, -outside);

  vertex(-outside, outside, outside);
  vertex(-inside, inside, inside);
  vertex(-outside, outside, outside);

  vertex(outside, outside, outside);
  vertex(inside, inside, inside);
  vertex(outside, outside, outside);

  vertex(outside, outside, -outside);
  vertex(inside, inside, -inside);
  vertex(outside, outside, -outside);

  vertex(-outside, outside, -outside);
  vertex(-inside, inside, -inside);
  vertex(-outside, outside, -outside);

  //outside top
  vertex(-outside, -outside, -outside);

  vertex(-outside, -outside, outside);
  vertex(-inside, -inside, inside);
  vertex(-outside, -outside, outside);
  vertex(-outside, outside, outside);
  vertex(-outside, -outside, outside);

  vertex(outside, -outside, outside);
  vertex(inside, -inside, inside);
  vertex(outside, -outside, outside);
  vertex(outside, outside, outside);
  vertex(outside, -outside, outside);

  vertex(outside, -outside, -outside);
  vertex(inside, -inside, -inside);
  vertex(outside, -outside, -outside);
  vertex(outside, outside, -outside);
  vertex(outside, -outside, -outside);

  vertex(-outside, -outside, -outside);
  vertex(-inside, -inside, -inside);
  vertex(-outside, -outside, -outside);
  vertex(-outside, outside, -outside);
  vertex(-outside, -outside, -outside);

  endShape();

  rotateX(-xRot);
  rotateY(-yRot);
  rotateZ(-zRot);
  translate(-x, -y, -z);
}
