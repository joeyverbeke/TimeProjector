boolean controlCameraWithMouse = false;

int looper = 0;

OPC opc;
TesseractPerspective[] tesseractPerspectives;
GlobalAnimator globalAnimator;
static TimeProjectorForm timeProjectorForm;

boolean ghostFade = false;

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

ArrayList<Snake> snakes;

void setup()
{
  size(700, 400, P3D);
  ortho();
  colorMode(HSB, 360, 100, 100);

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

  snake = new ArrayList<PVector>(); //old


  //new snakes
  ////snakes = new ArrayList<ArrayList<PVector>>();
  snakes = new ArrayList<Snake>();
  snakes.add(new Snake(0, 40, "rotateLeft", 255));
  snakes.add(new Snake(8, 50, "rotateLeft", 127));
  //snakes.add(new Snake(12, 15, "pivotLateral"));

  snakes.get(0).addDirection("pivotLeft");
  snakes.get(0).addDirection("pivotLeft");
  snakes.get(0).addDirection("pivotLeft");
  snakes.get(0).addDirection("pivotLeft");
  snakes.get(0).addDirection("pivotLeft");
  snakes.get(0).addDirection("pivotLateral");

  snakes.get(1).addDirection("pivotVertical");
  snakes.get(1).addDirection("pivotRight");
  snakes.get(1).addDirection("pivotVertical");
  snakes.get(1).addDirection("pivotLeft");
  snakes.get(1).addDirection("pivotLeft");
  snakes.get(1).addDirection("pivotLateral");




  setupLedStrings();

  println("LED count: " + ledCount);
}


void draw()
{
  if(!ghostFade) {
    background(0, 0, 0);
  }
  drawAllTimeProjectorForms();

  if (frameCount%25==0)
    println("FrameRate:" + frameRate);

  //println("mouseX:" + mouseX + " mouseY:" + mouseY);

  if (controlCameraWithMouse)
  {
    camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  }

  //camera(sin(frameCount/80.0)*150 + 350, sin(frameCount/70.0)*100 + 200, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height/2, 0, 0, 1, 0);

  ////functional snake
  //snakeAnimation();

  //globalAnimator.runAnimation("snake");

  /*    
   //test update snakes, put in function later and probably in Animation class
   for (int i=0; i<snakes.size(); i++)
   {
   snakes.get(i).Update();
   }
   */

  //planes test
  /*  
   drawPlane(0, color(300, 100, 100));
   drawPlane(1, color(100, 100, 100));
   drawPlane(2, color(200, 100, 100));
   drawPlane(3, color(50, 100, 100));
   drawPlane(4, color(0, 100, 100));
   drawPlane(5, color(150, 100, 100));
   drawPlane(6, color(150, 0, 100));
   
   drawPlane(7, color(250, 50, 100));
   drawPlane(8, color(350, 50, 100));
   
   drawPlane(9, color(75, 50, 100));
   drawPlane(10, color(125, 50, 100));
   drawPlane(11, color(175, 50, 100));
   drawPlane(12, color(225, 75, 75));
   drawPlane(13, color(325, 75, 75));
   drawPlane(14, color(25, 75, 75));
   drawPlane(15, color(75, 75, 75));
   
   drawPlane(16, color(100, 75, 75));
   drawPlane(17, color(300, 75, 75));
   drawPlane(18, color(150, 75, 75));
   drawPlane(19, color(250, 75, 75));
   drawPlane(20, color(200, 0, 100));
   drawPlane(21, color(200, 50, 100));
   drawPlane(22, color(0, 50, 100));
   drawPlane(23, color(150, 50, 100));
   */

for(int i=13; i<=24; i++)
{
   drawEdge(i, color(0, 100, 100));  
}

for(int i=0; i<=12; i++)
{
   drawEdge(i, color(150, 100, 100));  
}

  //globalAnimator.runAnimation("rotatingBox");

  //drawBlockers();

  //globalAnimator.runAnimation("lateralSweep2");

  //TODO: fix vertical planes
  //globalAnimator.runAnimation("flashingVerticalPlanes");

  //globalAnimator.runAnimation("growingBox");

  // all on test
  /*
  for (int i=0; i<tesseractPerspectives.length; i++)
   {
   tesseractPerspectives[i].setupPerspective();
   fill(150, 100, 100);
   box(150);
   tesseractPerspectives[i].resetPerspective();
   }
   */
  looper++;

  //mouseTest

  noStroke();
  pushMatrix();
  fill(0, 0, 100);
  translate(mouseX, mouseY, 500);
  box(10, 10, 1000);
  popMatrix();

  if (ghostFade)
  {
    pushMatrix();
    fill(0, 5);
    translate(width/2, height/2, 0);
    box(1000, 1000, 1000);
    popMatrix();
  }
}


void drawBlockers()
{
  PShape verticalSlice = createShape();
  verticalSlice.beginShape();

  PVector topLeft = PVector.lerp(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 0.01);
  PVector topRight = PVector.lerp(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 0.01);
  PVector bottomRight = PVector.lerp(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 0.01);
  PVector bottomLeft = PVector.lerp(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 0.01);

  verticalSlice.vertex(topLeft.x, topLeft.y, topLeft.z);
  verticalSlice.vertex(topRight.x, topRight.y, topRight.z);
  verticalSlice.vertex(bottomRight.x, bottomRight.y, bottomRight.z);
  verticalSlice.vertex(bottomLeft.x, bottomLeft.y, bottomLeft.z);
  verticalSlice.vertex(topLeft.x, topLeft.y, topLeft.z);

  verticalSlice.endShape();
  verticalSlice.setFill(color(0,0,0));
  verticalSlice.setStroke(false);

  tesseractPerspectives[0].setupPerspective();
  shape(verticalSlice);
  tesseractPerspectives[0].resetPerspective();

  tesseractPerspectives[3].setupPerspective();
  shape(verticalSlice);
  tesseractPerspectives[3].resetPerspective();
}

void circleSnake()
{
}

//move to animation
void drawPlane(int planeNum, color planeColor)
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.Planes.get(planeNum).setFill(planeColor);
    timeProjectorForm.Planes.get(planeNum).setStroke(planeColor);
    shape(timeProjectorForm.Planes.get(planeNum));
    tesseractPerspectives[i].resetPerspective();
  }
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

//move to animation?
void drawEdge(int edgeNum, color _color)
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.drawEdge(edgeNum, _color);
    tesseractPerspectives[i].resetPerspective();
  }
}

//move to animation?
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

void setupLedStrings() ////TODO: Fix front and back squares
{
  //setup LEDs in order

  //1-0
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 29, 0);   //OTF
  ledStrip(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 10, 5);  //LFTL
  ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 14, 0); //ITF
  ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 11, 4);//ITR -1

  //1-1
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 14, 2);  //LFTR
  ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 14, 0); //IRF
  ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 14, 0); //IBF
  ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 12, 1);  //IBL
  ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 8, 3);   //IBB

  //1-2
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 33, 0);   //ORF
  ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 11, 2);  //LFBR
  ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 12, 1);  //IBR
  ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 8, 3);  //ILB

  //1-3
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 23, 2);  //OTR
  ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 19, 3);  //OLB
  ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 22, 2);  //OBR -1

  //1-4
  ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 30, 0);   //OBF


  //2-0
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 21, 5);  //OTL
  ledStrip(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 30, 0);   //OLF
  ledStrip(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 11, 5);  //LFBL

  //2-1
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 19, 3);  //OTB
  ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 15, 4); //LBTL -2
  ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 8, 3); //ITB
  ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 10, 4);//ITL -2
  ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 12, 0); //ILF -2

  //2-2
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 16, 4); //LBTR
  ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 8, 3);  //IRB
  ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 15, 1);   //LBBR -1
  ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 23, 5);  //OBL

  //2-3
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 19, 3);  //ORB
  ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 19, 3);  //OBB
  ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 17, 1);   //LBBL


  /*
  //old-unordered
   
   //perspective 0
   
   //inside front square
   ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 14, 0); //ITF
   ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 14, 0); //IRF
   ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 14, 0); //IBF
   ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 12, 0); //ILF -2
   
   //lateral front connections
   ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 10, 0);  //LFTL
   ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(6).coordinate, 14, 0);  //LFTR
   ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 11, 0);  //LFBR
   ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 11, 0);  //LFBL
   
   //outside front square
   
   ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 33, 0);   //ORF
   ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 30, 0);   //OBF
   ledStrip(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 30, 0);   //OLF
   ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 29, 0);   //OTF
   
   
   //perspective 1
   
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 15, 1);   //LBBR -1
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 17, 1);   //LBBL
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 12, 1);  //IBL
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 12, 1);  //IBR
   
   //outside back to front connections
   ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 21, 2);  //OTL
   ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(6).coordinate, 23, 5);  //OTR
   ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 23, 2);  //OBL
   ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 22, 5);  //OBR -1
   
   
   //perspective 3
   
   //outside back square
   ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 19, 3);  //OTB
   ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 19, 3);  //OLB
   ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 19, 3);  //OBB
   ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 19, 3);  //ORB
   
   
   //inside back square
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 8, 3); //ITB
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 8, 3);  //ILB
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 8, 3);   //IBB
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 8, 3);  //IRB
   
   //perspective 4
   //inside back square top -> lateral
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 16, 4); //LBTR
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 15, 4); //LBTL -2
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 10, 4);//ITL -2
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 11, 4);//ITR -1
   */

  /*
  ////older, wrong pixel count
   //perspective 0
   
   //inside front square
   ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 27, 0);
   ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 28, 0);
   ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 27, 0);
   ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 27, 0);
   
   //lateral front connections
   ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 22, 0);
   ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(6).coordinate, 27, 0);
   ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 23, 0);
   ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 23, 0);
   
   //outside front square
   ledStrip(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(6).coordinate, 54, 0);
   ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 60, 0);
   ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 54, 0);
   ledStrip(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 54, 0);
   
   
   //perspective 1
   
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 32, 1); //inside bottom back left -> outside bottom back left
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 32, 1);
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 24, 1); //inside bottom back left -> inside bottom front left
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 24, 1);
   
   
   //perspective 3
   
   //outside back square
   ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 36, 3);
   ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 36, 3);
   ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 36, 3);
   ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 36, 3);
   
   //outside back to front connections
   ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 42, 3);
   ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(6).coordinate, 43, 3);
   ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 42, 3);
   ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 42, 3);
   
   //inside back square
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 18, 3);
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 18, 3);
   ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 18, 3);
   ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 18, 3);
   
   //perspective 4
   //inside back square top -> lateral
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 32, 4); //inside top back left -> outside top back left
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 32, 4);
   ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 24, 4); //inside top back left -> inside top front left
   ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 24, 4);
   */
}

void ledStrip(PVector start, PVector end, int numLeds, int perspectiveNum)
{
  /*
  stroke(255,0,0);
   strokeWeight(1);
   //debug test to see which edges have been drawn
   for (int i=0; i<tesseractPerspectives.length; i++)
   {
   tesseractPerspectives[i].setupPerspective();
   line(start.x, start.y, start.z, end.x, end.y, end.z);
   tesseractPerspectives[i].resetPerspective();
   }
   */

  float stepValue = (float)(0.9 /  numLeds);
  PVector pixelVector;

  tesseractPerspectives[perspectiveNum].setupPerspective();

  for (float i=0.05; i < 0.948; i += stepValue)
  {    
    pixelVector = PVector.lerp(start, end, i);

    //fill(255, 0, 255);
    pushMatrix();
    translate(pixelVector.x, pixelVector.y, pixelVector.z);
    pixelVector.set(0, 0, 0);
    opc.led(ledCount, (int)screenX(pixelVector.x, pixelVector.y, pixelVector.z), (int)screenY(pixelVector.x, pixelVector.y, pixelVector.z));
    popMatrix();

    ledCount++;
  }

  tesseractPerspectives[perspectiveNum].resetPerspective();

  println("ledcount: " + ledCount);
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
      fill((j%255), 255-(j%255), (j%255));
      //fill(255);

      pushMatrix();
      translate(snake.get(j).x, snake.get(j).y, snake.get(j).z);
      box(2);
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
