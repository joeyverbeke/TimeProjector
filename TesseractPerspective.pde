public class TesseractPerspective{
  
  int x, y, z, xRot, yRot, zRot;
  
  TesseractPerspective(int _x, int _y, int _z, int _xRot, int _yRot, int _zRot)
  {
    x=_x;
    y=_y;
    z=_z;
    xRot=_xRot;
    yRot=_yRot;
    zRot=_zRot;
  }
  
  void setupPerspective()
  {
    translate(x,y,z);
    rotateX(xRot);
    rotateY(yRot);
    rotateZ(zRot);
  }
  
  void resetPerspective()
  {
    rotateX(-xRot);
    rotateY(-yRot);
    rotateZ(-zRot);
    translate(-x,-y,-z);
  }
}