public class Snake
{
  int lastIndex, currentIndex, speed;
  int maxLength = 50;
  ArrayList<PVector> body;
  String animationMode; //change to enum
  ArrayList<String> directions;
  int snakeColor = 255;

  Snake()
  {
    lastIndex = currentIndex = 0;
    body = new ArrayList<PVector>();
    directions = new ArrayList<String>();
  }

  Snake(int startingIndex, int _speed, String _animationMode, int _snakeColor)
  {
    lastIndex = currentIndex = startingIndex;
    speed = _speed;
    body = new ArrayList<PVector>(); 
    animationMode = _animationMode;
    directions = new ArrayList<String>();
    snakeColor = _snakeColor;
  }

  void setSpeed(int _speed)
  {
    speed = _speed;
  }

  void addDirection(String direction)
  {
    directions.add(direction);
  }

  void Update()
  {
    
    println(body.size());
    if (frameCount%speed == 0)
    {
      if (directions.size() != 0)
      {        
        directions.add(directions.get(0));
        directions.remove(0);
        animationMode = directions.get(0);
        println(speed + " " + frameCount + " " + animationMode);
      }
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
    //maxLength = speed * 4;

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
        //fill((int)(j*(float)(255/body.size())), 0, (int)(j*(float)(255/body.size())));
        //fill(random(255), random(255), random(255));

        fill(snakeColor, 100, (int)(j*(float)(100/body.size())));

        pushMatrix();
        translate(body.get(j).x, body.get(j).y, body.get(j).z);
        box(2);
        popMatrix();
      }

      tesseractPerspectives[i].resetPerspective();
    }
  }
}
