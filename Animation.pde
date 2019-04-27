 //<>//
public class Animation
{
  boolean ghosting;
  ArrayList<PImage> ghostFrames;
  int ghostSize;

  boolean reversedLateralSweep;
  int sweepTimer;
  float growingBoxSize;

  //snake
  int snakeSpeed;
  int lastVertexIndex;
  int currentVertexIndex;
  ArrayList<PVector> snakePoints;
  int onlyRunOnceCounter;

  //flashingVertPlane
  int vertPlane = 0;
  int vert_onlyRunOnceCounter;

  //temp for box grow speeds
  float xSpeed = 30.0;
  float zSpeed = 30.0;


  Animation() {
    ghostFrames = new ArrayList<PImage>();
    ghosting = true;
    ghostSize = 30;

    reversedLateralSweep = false;
    sweepTimer = 0;
    growingBoxSize = 0.01;

    //snake
    snakeSpeed = 50;
    lastVertexIndex = 0;
    currentVertexIndex = 0;
    snakePoints = new ArrayList<PVector>();
    onlyRunOnceCounter = 0;
  }

  //add in way to set function parameters, e.g. speed
  void playAnimation(String animation)
  {
    switch(animation)
    {
    case "rotatingBox":
      rotatingBox();
      break;
    case "rotatingBoxes":
      rotatingBoxes();
      break;
    case "diagonalRotatingBoxes":
      diagonalRotatingBoxes();
      break;
    case "lateralSweep":
      lateralSweep();
      break;
    case "dualLateralSweep":
      dualLateralSweep();
      break;
    case "growingBox":
      growingBox();
      break;
    case "snake":
      snake();
      break;
    case "flashingVerticalPlanes":
      flashingVerticalPlanes();
      //    case "randomRectangularPrisms":
      //      randomRectangularPrisms();
      break;
    default:
      break;
    }

    /*
    if (ghosting)
     {
     for (int i=0; i<ghostFrames.size(); i++)
     {  
     tint(255, 255-(255/ghostSize)*i);
     image(ghostFrames.get(i), width, height);
     }
     
     PImage transfer = get(0, 0, width, height);
     transfer.loadPixels();
     for (int i=0; i < width*height; i++)
     {
     if (transfer.pixels[i] == color(0, 0, 0))
     {
     transfer.pixels[i] = color(0, 0, 0, 0);
     }
     }
     
     ghostFrames.add(transfer);
     if (ghostFrames.size() > ghostSize)
     {
     ghostFrames.remove(0);
     }
     noTint();
     }
     */
  }

  void flashingVerticalPlanes()
  {
    vert_onlyRunOnceCounter++;

   // println(onlyRunOnceCounter);

    if (vert_onlyRunOnceCounter % 5 == 0)
    {
      int speed_flashingVertical = 60;

      if (frameCount%speed_flashingVertical == 0)
      {
        vertPlane++;
        println(frameCount);
      }
    }

    switch(vertPlane%3)
    {
    case 0:
      timeProjectorForm.drawEdge(0, color(255));
      timeProjectorForm.drawEdge(4, color(255));
      timeProjectorForm.drawEdge(9, color(255));
      timeProjectorForm.drawEdge(11, color(255));
      break;

    case 1:
      timeProjectorForm.drawEdge(12, color(255));
      timeProjectorForm.drawEdge(13, color(255));
      timeProjectorForm.drawEdge(14, color(255));
      timeProjectorForm.drawEdge(15, color(255));
      break;

    case 2:
      timeProjectorForm.drawEdge(16, color(255));
      timeProjectorForm.drawEdge(17, color(255));
      timeProjectorForm.drawEdge(18, color(255));
      timeProjectorForm.drawEdge(19, color(255));
      break;

    case 3:
      timeProjectorForm.drawEdge(2, color(255));
      timeProjectorForm.drawEdge(7, color(255));
      timeProjectorForm.drawEdge(8, color(255));
      timeProjectorForm.drawEdge(10, color(255));
      break;
    }
  }

  ////TODO: not working correctly, snake jumping to disconnected point
  void snake()
  {
    onlyRunOnceCounter++;

    if (onlyRunOnceCounter % 5 == 0)
    {
      if (frameCount%snakeSpeed == 0)
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

      addPointToSnake(PVector.lerp(timeProjectorForm.Vertices.get(lastVertexIndex).coordinate, timeProjectorForm.Vertices.get(currentVertexIndex).coordinate, frameCount%snakeSpeed/(float)snakeSpeed));
    }

    drawSnake();
  }

  void addPointToSnake(PVector point)
  {
    //move out of function
    int maxLength = 255;

    snakePoints.add(point);
    if (snakePoints.size() > maxLength)
    {
      snakePoints.remove(0);
    }
  }

  void drawSnake()
  {
    noStroke();
    //    for (int i=0; i<tesseractPerspectives.length; i++)
    //    {
    //      tesseractPerspectives[i].setupPerspective();

    for (int j=0; j<snakePoints.size(); j++)
    {
      //fill((j%255), 255-(j%255), (j%255));
      fill(255);

      pushMatrix();
      translate(snakePoints.get(j).x, snakePoints.get(j).y, snakePoints.get(j).z);
      box(5);
      popMatrix();
    }

    //      tesseractPerspectives[i].resetPerspective();
    //    }
  }

  void lateralSweep()
  {
    float speed = 250;

    if (frameCount%speed==0 && sweepTimer != millis())
    {
      reversedLateralSweep = !reversedLateralSweep;
      sweepTimer = millis();
    }


    if (!reversedLateralSweep)
    {
      translate(-50+(frameCount%speed / (speed/100)), 0, 0);

      fill(255, 255, 255);
      noStroke();
      box(5, 125, 125);

      translate(-(-50+(frameCount%speed / (speed/100))), 0, 0);
    } else
    {
      translate(50-(frameCount%speed / (speed/100)), 0, 0);

      fill(255, 255, 255);
      noStroke();
      box(5, 125, 125);

      translate(-(50-(frameCount%speed / (speed/100))), 0, 0);
    }
  }

  void dualLateralSweep()
  {
    float speed = 250;

    if (frameCount%speed==0 && sweepTimer != millis())
    {
      reversedLateralSweep = !reversedLateralSweep;
      sweepTimer = millis();
    }


    if (!reversedLateralSweep)
    {
      translate(-50+(frameCount%speed / (speed/100)), 0, 0);

      fill(255, 255, 0);
      noStroke();
      box(5, 125, 125);

      translate(5, 0, 0);
      fill(255, 75, 75);
      box(5, 125, 125);
      translate(-5, 0, 0);

      translate(-(-50+(frameCount%speed / (speed/100))), 0, 0);
    } else
    {
      translate(50-(frameCount%speed / (speed/100)), 0, 0);

      fill(255, 255, 75);
      noStroke();
      box(5, 125, 125);

      translate(5, 0, 0);
      fill(255, 75, 75);
      box(5, 125, 125);
      translate(-5, 0, 0);

      translate(-(50-(frameCount%speed / (speed/100))), 0, 0);
    }
  }

  void rotatingBox()
  {
    float _speed = 100.0 - 40;

    fill(255, 0, 255);
    noStroke();
    //stroke(0, 255, 255);

    /*
    if (ghosting)
     {
     for (int i=0; i<ghostSize; i++)
     {
     fill(255-((255/ghostSize)*i), 0, 255-((255/ghostSize)*i));
     rotateZ((frameCount-i)/_speed);
     box(10, 125, 125);
     rotateZ(-((frameCount-i)/_speed));
     }
     }
     */
    rotateZ(frameCount/_speed);
    box(10, 125, 125);
    rotateZ(-(frameCount/_speed));
  }

  void rotatingBoxes()
  {
    rotateY(frameCount/60.0);

    fill(255, 75, 255);
    noStroke();
    box(5, 75, 75);

    translate(5, 0, 0);
    fill(75, 255, 255);
    noStroke();
    box(5, 75, 75);
    translate(-5, 0, 0);

    rotateY(-frameCount/60.0);
  }

  void diagonalRotatingBoxes()
  {
    pushMatrix();
    rotateX(-frameCount/3.0);

    fill(255, 75, 255);
    noStroke();
    box(5, 75, 75);

    translate(5, 0, 0);
    fill(75, 255, 255);
    noStroke();
    box(5, 75, 75);
    translate(-5, 0, 0);

    popMatrix();
  }

  void growingBox()
  {
    float maxSize = 100;
    float speed = 0.1;

    if ((growingBoxSize >= maxSize || growingBoxSize <= 0) && sweepTimer != millis())
    {
      reversedLateralSweep = !reversedLateralSweep;
      sweepTimer = millis();

      if (growingBoxSize <= 0)
      {
        //sphereDetail((int)random(10), (int)random(10));
        fill(random(255), random(255), random(255));
        xSpeed = random(100);
        zSpeed = random(100);
      }
    }

    pushMatrix();
    rotateX(frameCount/xSpeed);
    rotateZ(frameCount/zSpeed);

    box(growingBoxSize);

    popMatrix();

    if (!reversedLateralSweep)
    {
      growingBoxSize+=speed;
    } else
    {
      growingBoxSize-=speed;
    }
  }
}
