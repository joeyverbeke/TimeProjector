
public class Animation
{
  boolean reversedLateralSweep;
  int sweepTimer;
  
  Animation() {
    reversedLateralSweep = false;
    sweepTimer = 0;
  }

  //add in way to set function parameters, e.g. speed
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
    case "lateralSweep":
      lateralSweep();
      break;
    default:
      break;
    }
  }

  void lateralSweep()
  {
    if (frameCount%100==0 && sweepTimer != millis())
    {
      reversedLateralSweep = !reversedLateralSweep;
      sweepTimer = millis();
    }

    fill(255,0,0);
    noStroke();
    if (!reversedLateralSweep)
    {
      translate(-50+(frameCount%100), 0, 0);
      box(10, 100, 100);
      translate(-(-50+(frameCount%100)), 0, 0);
    }
    else
    {
      translate(50-(frameCount%100), 0, 0);
      box(10, 100, 100);
      translate(-(50-(frameCount%100)), 0, 0);
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

    translate(5, 0, 0);
    fill(0, 0, 255);
    noStroke();
    box(5, 75, 75);
    translate(-5, 0, 0);

    rotateY(-frameCount/60.0);
  }
}
