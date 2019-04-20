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
    maxLength = speed * 4;
    
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
    body.add(point);

/*
    if (body.size() > 1)
    {
      println("0: " + body.get(0));
      println("n: " + body.get(body.size()-1));
      if (body.get(0) == body.get(body.size()-1))
      {
        maxLength = body.size();
      }
    }
*/

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
        //fill((j%255), 255-(j%255), (j%255));
        fill((int)(j*(float)(255/body.size())), 0, (int)(j*(float)(255/body.size())));
        //fill(random(255), random(255), random(255));

        pushMatrix();
        translate(body.get(j).x, body.get(j).y, body.get(j).z);
        box(2);
        popMatrix();
      }

      tesseractPerspectives[i].resetPerspective();
    }
  }
}
