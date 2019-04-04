abstract public class Form
{
  ArrayList<PVector> vertex;

  Form()
  {
  }

  void connectAllPoints()
  {
    stroke(0);
    for (int i=0; i<vertex.size(); i++)
    {
      for (int j=0; j<vertex.size(); j++)
      {
        line(vertex.get(i).x, vertex.get(i).y, vertex.get(i).z, vertex.get(j).x, vertex.get(j).y, vertex.get(j).z);
      }
    }
  }
}

public class TimeProjectorForm extends Form
{

  TimeProjectorForm()
  {
    vertex = new ArrayList<PVector>();

    vertex.add(new PVector(28.41984197, -36.73388232, -29.91562312));   //1
    vertex.add(new PVector(-31.41140428, -36.73388232, -29.91562312));  //2
    vertex.add(new PVector(-46.31939798, 29.08048856, -44.87343469));   //0
    vertex.add(new PVector(43.37765353, 29.08048856, -44.87343469));    //7

    vertex.add(new PVector(28.41984197, -36.73388232, 29.91562312));    //14
    vertex.add(new PVector(-31.41140428, -36.73388232, 29.91562312));   //13
    vertex.add(new PVector(-46.31939798, 29.08048856, 54.51102379));    //12
    vertex.add(new PVector(40.38775181, 29.08048856, 44.82361682));     //15

    vertex.add(new PVector(14.95781156, 11.13111468, -14.95781156));    //6
    vertex.add(new PVector(-14.96312547, 11.12845773, -14.96279335));   //5
    vertex.add(new PVector(-22.43671734, 50.02142474, -24.23165473));   //4
    vertex.add(new PVector(22.43671734, 50.02142474, -22.43671734));    //3

    vertex.add(new PVector(14.95781156, 11.13111468, 14.95781156));     //11
    vertex.add(new PVector(-14.95781156, 11.13111468, 14.95781156));    //10
    vertex.add(new PVector(-22.43671734, 50.02142474, 22.43671734));    //8
    vertex.add(new PVector(22.43671734, 50.02142474, 22.43671734));     //9
  }

  void connectVertexToFour(int main, int one, int two, int three, int four)
  {

    //stroke(0);
    line(vertex.get(main).x, vertex.get(main).y, vertex.get(main).z, vertex.get(one).x, vertex.get(one).y, vertex.get(one).z);
    line(vertex.get(main).x, vertex.get(main).y, vertex.get(main).z, vertex.get(two).x, vertex.get(two).y, vertex.get(two).z);
    line(vertex.get(main).x, vertex.get(main).y, vertex.get(main).z, vertex.get(three).x, vertex.get(three).y, vertex.get(three).z);
    line(vertex.get(main).x, vertex.get(main).y, vertex.get(main).z, vertex.get(four).x, vertex.get(four).y, vertex.get(four).z);
  }

  void drawVertex(int i)
  {
    pushMatrix();
    translate(vertex.get(i).x, vertex.get(i).y, vertex.get(i).z);
    sphere(3);
    popMatrix();
  }

  void drawVertices()
  {
    for (int i=0; i<vertex.size(); i++)
    {

      pushMatrix();
      fill(i*15, 255-i*15, i*15);
      translate(vertex.get(i).x, vertex.get(i).y, vertex.get(i).z);
      sphere(3);
      popMatrix();
    }
  }
}
