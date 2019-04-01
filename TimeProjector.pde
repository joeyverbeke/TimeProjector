OPC opc;
TesseractPerspective[] tesseractPerspectives;

int ledCount = 0;

int faceWidth, faceHeight;
int squareX, squareY;

boolean reversedLateralSweep = false;

int _width, _height;
int padding = 25;

//show every angle

void setup()
{
  size(700, 400, P3D);


  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //drawPixels();

  faceWidth = width/3;
  faceHeight = height/8;
  _width = 600;
  _height = 300;
  
  tesseractPerspectives = new TesseractPerspective[6];
}


void draw()
{
  background(255);
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  //camera(sin(frameCount/200.0)*200 + 200, height/2, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);
  ortho();

  drawFaces();

  setupTesseractFaces();

  rotatingInsides(10, 75, 75, padding + _width/6, padding + _height/4, 0, 40); 
  rotatingInsides(10, 75, 75, 50 + _width/2, 25 + _height/4, 0, 40); 


  //drawTesseract();
  //lateralSweep();
  //rotatingInsides(20);
}

void rotatingInsides( int x, int y, int z, int xPos, int yPos, int zPos, float speed)
{
  float _speed = 100.0 - speed;

  translate(xPos, yPos, zPos);

  fill(255, 0, 255);
  stroke(0, 255, 255);

  rotateY(frameCount/_speed);
  box(x, y, z);
  
  rotateY(-(frameCount/_speed));
  translate(-xPos, -yPos, -zPos);
}

void lateralSweep()
{
  if (frameCount%400==0)
    reversedLateralSweep = !reversedLateralSweep;

  fill(255);
  noStroke();
  if (!reversedLateralSweep)
    translate(-200+(frameCount%400), 0, 0);
  else
    translate(200-(frameCount%400), 0, 0);
  box(10, 400, 400);
}


void setupTesseractFaces()
{
  drawTesseract(25, 50, padding + _width/6, padding + _height/4, 0, 0, 0, 0);
  drawTesseract(25, 50, 50 + _width/2, 25 + _height/4, 0, PI/2, 0, 0);
  drawTesseract(25, 50, width - _width/6 - padding, 25 + _height/4, 0, 0, PI/2, 0);
  drawTesseract(25, 50, padding + _width/6, height - padding - _height/4, 0, 0, 0, 0);
  drawTesseract(25, 50, 50 + _width/2, height - 25 - _height/4, 0, 0, PI/4, 0);
  drawTesseract(25, 50, width - _width/6 - padding, height - 25 - _height/4, 0, 0, PI/2, 0);
}

void drawTesseract(int inside, int outside, int x, int y, int z, float xRot, float yRot, float zRot)
{

  println(x + " " + y + " " + z);
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