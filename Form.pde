
abstract public class Form
{
  ArrayList<PVector> vertex;
  ArrayList<Vertex> Vertices;


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


    Vertices = new ArrayList<Vertex>();

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, -29.91562312), 0));   
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, -29.91562312), 1));  
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, -44.87343469), 2));   
    Vertices.add(new Vertex(new PVector(43.37765353, 29.08048856, -44.87343469), 3));    

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, 29.91562312), 4));    
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, 29.91562312), 5));   
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, 54.51102379), 6));    
    Vertices.add(new Vertex(new PVector(40.38775181, 29.08048856, 44.82361682), 7));     

    Vertices.add(new Vertex(new PVector(14.95781156, 11.13111468, -14.95781156), 8));    
    Vertices.add(new Vertex(new PVector(-14.96312547, 11.12845773, -14.96279335), 9));   
    Vertices.add(new Vertex(new PVector(-22.43671734, 50.02142474, -24.23165473), 10));   
    Vertices.add(new Vertex(new PVector(22.43671734, 50.02142474, -22.43671734), 11));    

    Vertices.add(new Vertex(new PVector(14.95781156, 11.13111468, 14.95781156), 12));     
    Vertices.add(new Vertex(new PVector(-14.95781156, 11.13111468, 14.95781156), 13));    
    Vertices.add(new Vertex(new PVector(-22.43671734, 50.02142474, 22.43671734), 14));    
    Vertices.add(new Vertex(new PVector(22.43671734, 50.02142474, 22.43671734), 15));    

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
    fill(255,0,0);
    pushMatrix();
    translate(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z);
    box(10);
    popMatrix();
  }

  void drawVertices()
  {
    for (int i=0; i<vertex.size(); i++)
    {

      pushMatrix();
      fill(i*15, 255-i*15, i*15);
      translate(Vertices.get(i).coordinate.x, Vertices.get(i).coordinate.y, Vertices.get(i).coordinate.z);
      sphere(3);
      popMatrix();
    }
  }
}