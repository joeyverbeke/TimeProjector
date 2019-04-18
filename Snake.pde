public class Snake
{
  int lastIndex, currentIndex, speed;
  int maxLength = 255;
  ArrayList<PVector> body;
  String animationMode; //change to enum

  Snake()
  {
    lastIndex = currentIndex = 0;
    body = new ArrayList<PVector>();
  }

  Snake(int startingIndex, int _speed, String _animationMode)
  {
    lastIndex = currentIndex = startingIndex;
    speed = _speed;
    body = new ArrayList<PVector>(); 
    animationMode = _animationMode;
  }

  void setSpeed(int _speed)
  {
    speed = _speed;
  }

  void Update()
  {
    if (frameCount%speed == 0)
    {
      switch(animationMode)
      {
      case "rotateRight":
        rotateAnimation(true);
        break;
      case "rotateLeft":
        rotateAnimation(false);
        break;
      case "pivotLeft":
        pivotDirection(0);
        break;
      case "pivotRight":
        pivotDirection(1);
        break; 
      case "pivotVertical":
        pivotDirection(2);
        break;
      case "pivotLateral":
        pivotDirection(3);
        break; 
      default:
        break;
      }
    }

    addPointToSnake(PVector.lerp(timeProjectorForm.Vertices.get(lastIndex).coordinate, timeProjectorForm.Vertices.get(currentIndex).coordinate, frameCount%speed/(float)speed));
    drawSnake();
  }

  void rotateAnimation(boolean clockwise)
  {
    int tempIndex;
    if (clockwise)
    {
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).right.index;
    } else
    {
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).left.index;
    }

    lastIndex = currentIndex;
    currentIndex = tempIndex;
  }

  void pivotDirection(int direction)
  {
    int tempIndex;
    switch(direction)
    {
    case 0:
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).right.index;
      break;
    case 1:
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).left.index;
      break;
    case 2:
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).vertical.index;
      break;
    case 3:
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).lateral.index;
      break;

    default:
      tempIndex = timeProjectorForm.Vertices.get(currentIndex).right.index;
      break;
    }

    lastIndex = currentIndex;
    currentIndex = tempIndex;
  }

  void addPointToSnake(PVector point)
  {
    //move out of function
    int maxLength = 255;

    body.add(point);
    if (body.size() > maxLength)
    {
      body.remove(0);
    }
  }

  void drawSnake()
  {
    noStroke();
    for (int i=0; i<tesseractPerspectives.length; i++)
    {
      tesseractPerspectives[i].setupPerspective();

      for (int j=0; j<body.size(); j++)
      {
        fill((j%255), 255-(j%255), (j%255));
        //fill(255);

        pushMatrix();
        translate(body.get(j).x, body.get(j).y, body.get(j).z);
        box(2);
        popMatrix();
      }

      tesseractPerspectives[i].resetPerspective();
    }
  }
}
