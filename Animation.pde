public class Animation
{
  Animation() {
  }

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
    default:
      break;
    }
  }

  void rotatingBox()
  {
    float _speed = 100.0 - 40;

    fill(255, 0, 255);
    stroke(0, 255, 255);

    rotateY(frameCount/_speed);
    box(10, 75, 75);
    rotateY(-(frameCount/_speed));
  }

  void rotatingBoxes()
  {
    rotateY(frameCount/60.0);

    fill(255, 0, 255);
    noStroke();
    box(5, 75, 75);
    
    translate(5,0,0);
    fill(0, 0, 255);
    noStroke();
    box(5, 75, 75);
    translate(-5,0,0);
    
    rotateY(-frameCount/60.0);
  }
}