public class Vertex
{
  int index;
  PVector coordinate;
  Vertex right, left, vertical, lateral;

  Vertex() 
  {
  }

  Vertex(PVector _coordinate, int _index)
  {
    coordinate = _coordinate;
    index = _index;
  }

  Vertex(PVector _coordinate, Vertex _right, Vertex _left, Vertex _vertical, Vertex _lateral)
  {
    coordinate = _coordinate;
    right = _right;
    left = _left;
    vertical = _vertical;
    lateral = _lateral;
  }

  void addConnections(Vertex _right, Vertex _left, Vertex _vertical, Vertex _lateral)
  {
    right = _right;
    left = _left;
    vertical = _vertical;
    lateral = _lateral;
  }

  Vertex getRandomConnectingVertex()
  {
    int randVert = (int)random(4);

    println("randVert: " + randVert);

    switch(randVert)
    {
    case 0:
      return left;
    case 1:
      return right;
    case 2:
      return vertical;
    case 3:
      return lateral;
    default:
      return lateral;
    }
  }
}
