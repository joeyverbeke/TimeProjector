TesseractPerspective[] perspectives;
Animation animation;

class GlobalAnimator
{
  GlobalAnimator(TesseractPerspective[] _perspectives)
  {
    perspectives = new TesseractPerspective[_perspectives.length]; 

    for (int i=0; i<_perspectives.length; i++)
    {
      perspectives[i] = _perspectives[i];
    }
  }

  void runAnimation(String animationName)//pass in specific animation
  {
    for (int i=0; i<perspectives.length; i++)
    {
      perspectives[i].setupPerspective();
      animation.playAnimation(animationName);
      perspectives[i].resetPerspective();
    }
  }
}