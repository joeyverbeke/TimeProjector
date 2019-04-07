
abstract public class Form
{
  ArrayList<Vertex> Vertices;

  Form()
  {
  }

}

public class TimeProjectorForm extends Form
{

  TimeProjectorForm()
  {

    Vertices = new ArrayList<Vertex>();

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, -29.91562312), 0));     //outside_bottom_back_left
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, -29.91562312), 1));    //outside_bottom_back_right
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, -44.87343469), 2));     //outside_bottom_front_right
    Vertices.add(new Vertex(new PVector(43.37765353, 29.08048856, -44.87343469), 3));      //outside_bottom_front_left

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, 29.91562312), 4));      //outside_top_back_left
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, 29.91562312), 5));     //outside_top_back_right
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, 54.51102379), 6));      //outside_top_front_right
    Vertices.add(new Vertex(new PVector(40.38775181, 29.08048856, 44.82361682), 7));       //outside_top_front_left

    Vertices.add(new Vertex(new PVector(14.95781156, 11.13111468, -14.95781156), 8));      //inside_bottom_back_left
    Vertices.add(new Vertex(new PVector(-14.96312547, 11.12845773, -14.96279335), 9));     //inside_bottom_back_right
    Vertices.add(new Vertex(new PVector(-22.43671734, 50.02142474, -24.23165473), 10));    //inside_bottom_front_right
    Vertices.add(new Vertex(new PVector(22.43671734, 50.02142474, -22.43671734), 11));     //inside_bottom_front_left

    Vertices.add(new Vertex(new PVector(14.95781156, 11.13111468, 14.95781156), 12));      //inside_top_back_left
    Vertices.add(new Vertex(new PVector(-14.95781156, 11.13111468, 14.95781156), 13));     //inside_top_back_right
    Vertices.add(new Vertex(new PVector(-22.43671734, 50.02142474, 22.43671734), 14));     //inside_top_front_right
    Vertices.add(new Vertex(new PVector(22.43671734, 50.02142474, 22.43671734), 15));      //inside_top_front_left

    Vertices.get(0).addConnections(Vertices.get(1), Vertices.get(3), Vertices.get(4), Vertices.get(8)); //outside_bottom_back_left
    Vertices.get(1).addConnections(Vertices.get(2), Vertices.get(0), Vertices.get(5), Vertices.get(9)); //outside_bottom_back_right
    Vertices.get(2).addConnections(Vertices.get(3), Vertices.get(1), Vertices.get(6), Vertices.get(10)); //outside_bottom_front_right
    Vertices.get(3).addConnections(Vertices.get(0), Vertices.get(2), Vertices.get(7), Vertices.get(11)); //outside_bottom_front_left
    Vertices.get(4).addConnections(Vertices.get(5), Vertices.get(7), Vertices.get(0), Vertices.get(12)); //outside_top_back_left
    Vertices.get(5).addConnections(Vertices.get(6), Vertices.get(4), Vertices.get(1), Vertices.get(13)); //outside_top_back_right
    Vertices.get(6).addConnections(Vertices.get(7), Vertices.get(5), Vertices.get(2), Vertices.get(14)); //outside_top_front_right
    Vertices.get(7).addConnections(Vertices.get(4), Vertices.get(6), Vertices.get(3), Vertices.get(15)); //outside_top_front_left
    Vertices.get(8).addConnections(Vertices.get(9), Vertices.get(11), Vertices.get(12), Vertices.get(0)); //inside_bottom_back_left
    Vertices.get(9).addConnections(Vertices.get(10), Vertices.get(8), Vertices.get(13), Vertices.get(1)); //inside_bottom_back_right
    Vertices.get(10).addConnections(Vertices.get(11), Vertices.get(9), Vertices.get(14), Vertices.get(2));//inside_bottom_front_right
    Vertices.get(11).addConnections(Vertices.get(8), Vertices.get(10), Vertices.get(15), Vertices.get(3));//inside_bottom_front_left
    Vertices.get(12).addConnections(Vertices.get(13), Vertices.get(15), Vertices.get(8), Vertices.get(4));//inside_top_back_left
    Vertices.get(13).addConnections(Vertices.get(14), Vertices.get(12), Vertices.get(9), Vertices.get(5));//inside_top_back_right
    Vertices.get(14).addConnections(Vertices.get(15), Vertices.get(13), Vertices.get(10), Vertices.get(6));//inside_top_front_right
    Vertices.get(15).addConnections(Vertices.get(12), Vertices.get(14), Vertices.get(11), Vertices.get(7));//inside_top_front_left
  }

  void connectVertexToFour(int main, int one, int two, int three, int four)
  {

    //stroke(0);
    line(Vertices.get(main).coordinate.x, Vertices.get(main).coordinate.y, Vertices.get(main).coordinate.z, 
      Vertices.get(one).coordinate.x, Vertices.get(one).coordinate.y, Vertices.get(one).coordinate.z);
    line(Vertices.get(main).coordinate.x, Vertices.get(main).coordinate.y, Vertices.get(main).coordinate.z, 
      Vertices.get(two).coordinate.x, Vertices.get(two).coordinate.y, Vertices.get(two).coordinate.z);
    line(Vertices.get(main).coordinate.x, Vertices.get(main).coordinate.y, Vertices.get(main).coordinate.z, 
      Vertices.get(three).coordinate.x, Vertices.get(three).coordinate.y, Vertices.get(three).coordinate.z);
    line(Vertices.get(main).coordinate.x, Vertices.get(main).coordinate.y, Vertices.get(main).coordinate.z, 
      Vertices.get(four).coordinate.x, Vertices.get(four).coordinate.y, Vertices.get(four).coordinate.z);
  }

  void drawVertex(int i)
  {
    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    translate(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z);
    box(10);
    popMatrix();
  }

  void drawVertices()
  {
    for (int i=0; i<Vertices.size(); i++)
    {

      pushMatrix();
      fill(i*15, 255-i*15, i*15);
      translate(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z);
      sphere(3);
      popMatrix();
    }
  }

  void drawEdges()
  {
    stroke(0);
    strokeWeight(2);

    for (int i=0; i<Vertices.size(); i++)
    {
      line(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z, 
        Vertices.get(i).left.coordinate.x, Vertices.get(i).left.coordinate.y, Vertices.get(i).left.coordinate.z);
      line(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z, 
        Vertices.get(i).right.coordinate.x, Vertices.get(i).right.coordinate.y, Vertices.get(i).right.coordinate.z);
      line(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z, 
        Vertices.get(i).vertical.coordinate.x, Vertices.get(i).vertical.coordinate.y, Vertices.get(i).vertical.coordinate.z);
      line(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z, 
        Vertices.get(i).lateral.coordinate.x, Vertices.get(i).lateral.coordinate.y, Vertices.get(i).lateral.coordinate.z);
    }
  }
}
