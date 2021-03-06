
abstract public class Form
{
  ArrayList<Vertex> Vertices;
  ArrayList<PShape> Planes;

  Form()
  {
  }
}

public class TimeProjectorForm extends Form
{

  TimeProjectorForm()
  {

    //Set up vertices
    Vertices = new ArrayList<Vertex>();

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, -29.91562312), 0));     //outside_bottom_back_left
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, -29.91562312), 1));    //outside_bottom_back_right
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, -44.87343469), 2));     //outside_bottom_front_right
    Vertices.add(new Vertex(new PVector(43.37765353, 29.08048856, -44.87343469), 3));      //outside_bottom_front_left

    Vertices.add(new Vertex(new PVector(28.41984197, -36.73388232, 29.91562312), 4));      //outside_top_back_left
    Vertices.add(new Vertex(new PVector(-31.41140428, -36.73388232, 29.91562312), 5));     //outside_top_back_right
    Vertices.add(new Vertex(new PVector(-46.31939798, 29.08048856, 54.51102379), 6));      //outside_top_front_right
    Vertices.add(new Vertex(new PVector(40.38775181, 29.08048856, 44.82361682), 7));       //outside_top_front_left

    Vertices.add(new Vertex(new PVector(14.95781156, 11.13111468, -14.95781156), 8));      //inside_bottom_back_left    //PROBLEM
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

    //Set up planes
    Planes = new ArrayList<PShape>();

    Planes.add(createPlane(Vertices.get(10).coordinate, Vertices.get(11).coordinate, Vertices.get(15).coordinate, Vertices.get(14).coordinate)); //0
    Planes.add(createPlane(Vertices.get(10).coordinate, Vertices.get(14).coordinate, Vertices.get(13).coordinate, Vertices.get(9).coordinate));  //1
    Planes.add(createPlane(Vertices.get(8).coordinate, Vertices.get(9).coordinate, Vertices.get(13).coordinate, Vertices.get(12).coordinate));   //2
    Planes.add(createPlane(Vertices.get(11).coordinate, Vertices.get(15).coordinate, Vertices.get(12).coordinate, Vertices.get(8).coordinate));  //3
    Planes.add(createPlane(Vertices.get(12).coordinate, Vertices.get(13).coordinate, Vertices.get(14).coordinate, Vertices.get(15).coordinate)); //4
    Planes.add(createPlane(Vertices.get(8).coordinate, Vertices.get(9).coordinate, Vertices.get(10).coordinate, Vertices.get(11).coordinate));   //5

    //6 is weird >_*
    PShape plane6 = createShape(GROUP); //7-3-2-6-7

    PVector threeToTwo = PVector.lerp(Vertices.get(3).coordinate, Vertices.get(2).coordinate, 0.1);
    PVector sevenToSix = PVector.lerp(Vertices.get(7).coordinate, Vertices.get(6).coordinate, 0.1);
    PVector twoToSix = PVector.lerp(Vertices.get(2).coordinate, Vertices.get(6).coordinate, 0.1);
    PVector threeToSeven = PVector.lerp(Vertices.get(3).coordinate, Vertices.get(7).coordinate, 0.1);
    PVector sixToSeven = PVector.lerp(Vertices.get(6).coordinate, Vertices.get(7).coordinate, 0.1);
    PVector twoToThree = PVector.lerp(Vertices.get(2).coordinate, Vertices.get(3).coordinate, 0.1);
    PVector sevenToThree = PVector.lerp(Vertices.get(7).coordinate, Vertices.get(3).coordinate, 0.1);
    PVector sixToTwo = PVector.lerp(Vertices.get(6).coordinate, Vertices.get(2).coordinate, 0.1);

    PShape plane6_left = createShape();
    plane6_left.beginShape();
    noStroke();
    plane6_left.vertex(Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
    plane6_left.vertex(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
    plane6_left.vertex(threeToTwo.x, threeToTwo.y, threeToTwo.z);
    plane6_left.vertex(sevenToSix.x, sevenToSix.y, sevenToSix.z);
    plane6_left.vertex(Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
    plane6_left.endShape();

    PShape plane6_bottom = createShape();
    plane6_bottom.beginShape();
    noStroke();
    plane6_bottom.vertex(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
    plane6_bottom.vertex(Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
    plane6_bottom.vertex(twoToSix.x, twoToSix.y, twoToSix.z);
    plane6_bottom.vertex(threeToSeven.x, threeToSeven.y, threeToSeven.z);
    plane6_bottom.vertex(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
    plane6_bottom.endShape();

    PShape plane6_right = createShape();
    plane6_right.beginShape();
    noStroke();
    plane6_right.vertex(Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
    plane6_right.vertex(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
    plane6_right.vertex(sixToSeven.x, sixToSeven.y, sixToSeven.z);
    plane6_right.vertex(twoToThree.x, twoToThree.y, twoToThree.z);
    plane6_right.vertex(Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
    plane6_right.endShape();

    PShape plane6_top = createShape();
    plane6_top.beginShape();
    noStroke();
    plane6_top.vertex(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
    plane6_top.vertex(Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
    plane6_top.vertex(sevenToThree.x, sevenToThree.y, sevenToThree.z);
    plane6_top.vertex(sixToTwo.x, sixToTwo.y, sixToTwo.z);
    plane6_top.vertex(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
    plane6_top.endShape();

    plane6.addChild(plane6_left);
    plane6.addChild(plane6_bottom);
    plane6.addChild(plane6_right);
    plane6.addChild(plane6_top);

    Planes.add(plane6); //6

    //end wtf plane 6

    Planes.add(createPlane(Vertices.get(6).coordinate, Vertices.get(2).coordinate, Vertices.get(1).coordinate, Vertices.get(5).coordinate));   //7
    Planes.add(createPlane(Vertices.get(0).coordinate, Vertices.get(1).coordinate, Vertices.get(5).coordinate, Vertices.get(4).coordinate));   //8
    Planes.add(createPlane(Vertices.get(3).coordinate, Vertices.get(0).coordinate, Vertices.get(4).coordinate, Vertices.get(7).coordinate));   //9
    Planes.add(createPlane(Vertices.get(4).coordinate, Vertices.get(5).coordinate, Vertices.get(6).coordinate, Vertices.get(7).coordinate));   //10
    Planes.add(createPlane(Vertices.get(0).coordinate, Vertices.get(1).coordinate, Vertices.get(2).coordinate, Vertices.get(3).coordinate));   //11
    Planes.add(createPlane(Vertices.get(10).coordinate, Vertices.get(11).coordinate, Vertices.get(3).coordinate, Vertices.get(2).coordinate));   //12
    Planes.add(createPlane(Vertices.get(10).coordinate, Vertices.get(14).coordinate, Vertices.get(6).coordinate, Vertices.get(2).coordinate));   //13
    Planes.add(createPlane(Vertices.get(14).coordinate, Vertices.get(15).coordinate, Vertices.get(7).coordinate, Vertices.get(6).coordinate));   //14
    Planes.add(createPlane(Vertices.get(11).coordinate, Vertices.get(15).coordinate, Vertices.get(7).coordinate, Vertices.get(3).coordinate));   //15
    Planes.add(createPlane(Vertices.get(5).coordinate, Vertices.get(6).coordinate, Vertices.get(14).coordinate, Vertices.get(13).coordinate));   //16
    Planes.add(createPlane(Vertices.get(12).coordinate, Vertices.get(13).coordinate, Vertices.get(5).coordinate, Vertices.get(4).coordinate));   //17
    Planes.add(createPlane(Vertices.get(12).coordinate, Vertices.get(15).coordinate, Vertices.get(7).coordinate, Vertices.get(4).coordinate));   //18
    Planes.add(createPlane(Vertices.get(5).coordinate, Vertices.get(1).coordinate, Vertices.get(9).coordinate, Vertices.get(13).coordinate));   //19
    Planes.add(createPlane(Vertices.get(4).coordinate, Vertices.get(0).coordinate, Vertices.get(8).coordinate, Vertices.get(12).coordinate));   //20
    Planes.add(createPlane(Vertices.get(9).coordinate, Vertices.get(10).coordinate, Vertices.get(2).coordinate, Vertices.get(1).coordinate));   //21
    Planes.add(createPlane(Vertices.get(8).coordinate, Vertices.get(11).coordinate, Vertices.get(3).coordinate, Vertices.get(0).coordinate));   //22
    Planes.add(createPlane(Vertices.get(8).coordinate, Vertices.get(9).coordinate, Vertices.get(1).coordinate, Vertices.get(0).coordinate));   //22
  }

  PShape createPlane(PVector one, PVector two, PVector three, PVector four)
  {
    PShape plane = createShape();

    plane.beginShape();
    noStroke();
    plane.vertex(one.x, one.y, one.z);
    plane.vertex(two.x, two.y, two.z);
    plane.vertex(three.x, three.y, three.z);
    plane.vertex(four.x, four.y, four.z);
    plane.vertex(one.x, one.y, one.z);
    plane.endShape();

    return plane;
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
    stroke(0, 0, 0);
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

  void drawEdge(int edgeNum, color edgeColor)
  {
    stroke(edgeColor);
    strokeWeight(2);
    noFill();

    switch(edgeNum)
    {
    case 0:  //ITF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z, 
        Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 1:  //IRF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z, 
        Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 2:  //IBF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z, 
        Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 3:  //ILF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z, 
        Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 4:  //IBL
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case 5:  //IBR 
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case 6:  //ITB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 7:  //ILB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 8:  //IBB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 9:  //IRB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 10:  //ITL
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case 11:  //ITR
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case 12:  //ORF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 13:  //OBF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 14:  //OLF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 15:  //OTF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case 16:  //OTL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case 17:  //OTR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z, 
        Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case 18:  //OBL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case 19:  //OBR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case 20:  //OTB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z, 
        Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 21:  //OLB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 22:  //OBB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 23:  //ORB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case 24:  //LFTL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case 25:  //LFTR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z, 
        Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case 26:  //LFBR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case 27:  //LFBL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z, 
        Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case 28:  //LBBR 
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case 29:  //LBBL
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case 30:  //LBTR
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case 31:  //LBTL
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    }
  }
  
  void drawEdge(String edgeName, color edgeColor)
  {
    stroke(edgeColor);
    strokeWeight(2);
    noFill();

    switch(edgeName)
    {
    case "ITF":  //ITF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z, 
        Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "IRF":  //IRF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z, 
        Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "IBF":  //IBF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z, 
        Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "ILF":  //ILF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z, 
        Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "ITL":  //IBL
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case "ITR":  //IBR 
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case "ITB":  //ITB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "ILB":  //ILB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "IBB":  //IBB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "IRB":  //IRB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "IBL":  //ITL
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case "IBR":  //ITR
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case "ORF":  //ORF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "OBF":  //OBF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "OLF":  //OLF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "OTF":  //OTF
      tesseractPerspectives[0].setupPerspective();
      line(Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[0].resetPerspective();
      break;
    case "OTL":  //OTL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case "OTR":  //OTR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z, 
        Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case "OBL":  //OBL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case "OBR":  //OBR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case "OTB":  //OTB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z, 
        Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "OLB":  //OLB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "OBB":  //OBB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "ORB":  //ORB
      tesseractPerspectives[3].setupPerspective();
      line(Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z, 
        Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z);
      tesseractPerspectives[3].resetPerspective();
      break;
    case "LFTL":  //LFTL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(15).coordinate.x, Vertices.get(15).coordinate.y, Vertices.get(15).coordinate.z, 
        Vertices.get(7).coordinate.x, Vertices.get(7).coordinate.y, Vertices.get(7).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case "LFTR":  //LFTR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(14).coordinate.x, Vertices.get(14).coordinate.y, Vertices.get(14).coordinate.z, 
        Vertices.get(6).coordinate.x, Vertices.get(6).coordinate.y, Vertices.get(6).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case "LFBR":  //LFBR
      tesseractPerspectives[2].setupPerspective();
      line(Vertices.get(10).coordinate.x, Vertices.get(10).coordinate.y, Vertices.get(10).coordinate.z, 
        Vertices.get(2).coordinate.x, Vertices.get(2).coordinate.y, Vertices.get(2).coordinate.z);
      tesseractPerspectives[2].resetPerspective();
      break;
    case "LFBL":  //LFBL
      tesseractPerspectives[5].setupPerspective();
      line(Vertices.get(11).coordinate.x, Vertices.get(11).coordinate.y, Vertices.get(11).coordinate.z, 
        Vertices.get(3).coordinate.x, Vertices.get(3).coordinate.y, Vertices.get(3).coordinate.z);
      tesseractPerspectives[5].resetPerspective();
      break;
    case "LBTR":  //LBBR 
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(8).coordinate.x, Vertices.get(8).coordinate.y, Vertices.get(8).coordinate.z, 
        Vertices.get(0).coordinate.x, Vertices.get(0).coordinate.y, Vertices.get(0).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case "LBTL":  //LBBL
      tesseractPerspectives[4].setupPerspective();
      line(Vertices.get(9).coordinate.x, Vertices.get(9).coordinate.y, Vertices.get(9).coordinate.z, 
        Vertices.get(1).coordinate.x, Vertices.get(1).coordinate.y, Vertices.get(1).coordinate.z);
      tesseractPerspectives[4].resetPerspective();
      break;
    case "LBBR":  //LBTR
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(12).coordinate.x, Vertices.get(12).coordinate.y, Vertices.get(12).coordinate.z, 
        Vertices.get(4).coordinate.x, Vertices.get(4).coordinate.y, Vertices.get(4).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    case "LBBL":  //LBTL
      tesseractPerspectives[1].setupPerspective();
      line(Vertices.get(13).coordinate.x, Vertices.get(13).coordinate.y, Vertices.get(13).coordinate.z, 
        Vertices.get(5).coordinate.x, Vertices.get(5).coordinate.y, Vertices.get(5).coordinate.z);
      tesseractPerspectives[1].resetPerspective();
      break;
    }
  }

  void drawPlane(int planeNum, color planeColor)
  {
    noStroke();
    fill(planeColor);

    switch(planeNum)
    {
    case 0:

      break;

    case 1:

      break;

    default:

      break;
    }
  }
}
