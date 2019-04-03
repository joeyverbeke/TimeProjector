abstract public class Form
{
  PVector[] vertex;

  Form()
  {
  }
}

public class TimeProjectorForm extends Form
{

  TimeProjectorForm()
  {
    vertex = new PVector[16];

    vertex[0] = new PVector(-46.31939798, 29.08048856, -44.87343469);
    vertex[1] = new PVector(28.41984197, -36.73388232, -29.91562312);
    vertex[2] = new PVector(-31.41140428, -36.73388232, -29.91562312);
    vertex[3] = new PVector(22.43671734, 50.02142474, -22.43671734);
    vertex[4] = new PVector(-22.43671734, 50.02142474, -24.23165473);
    vertex[5] = new PVector(-14.96312547, 11.12845773, -14.96279335);
    vertex[6] = new PVector(14.95781156, 11.13111468, -14.95781156);
    vertex[7] = new PVector(43.37765353, 29.08048856, -44.87343469);
    vertex[8] = new PVector(-22.43671734, 50.02142474, 22.43671734);
    vertex[9] = new PVector(22.43671734, 50.02142474, 22.43671734);
    vertex[10] = new PVector(-14.95781156, 11.13111468, 14.95781156);
    vertex[11] = new PVector(14.95781156, 11.13111468, 14.95781156);
    vertex[12] = new PVector(-46.31939798, 29.08048856, 54.51102379);
    vertex[13] = new PVector(-31.41140428, -36.73388232, 29.91562312);
    vertex[14] = new PVector(28.41984197, -36.73388232, 29.91562312);
    vertex[15] = new PVector(40.38775181, 29.08048856, 44.82361682);
  }

  void drawVertices()
  {
    for (int i=0; i<vertex.length; i++)
    {
      pushMatrix();
      fill(0);
      translate(vertex[i].x, vertex[i].y, vertex[i].z);
      sphere(1);
      popMatrix();
    }
  }

  void connectAllPoints()
  {
    for (int i=0; i<vertex.length; i++)
    {
      for (int j=0; j<vertex.length; j++)
      {
        line(vertex[i].x, vertex[i].y, vertex[i].z, vertex[j].x, vertex[j].y, vertex[j].z);
      }
    }
  }
}
