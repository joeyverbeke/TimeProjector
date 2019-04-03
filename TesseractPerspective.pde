public class TesseractPerspective {

  int x, y, z;
  float xRot, yRot, zRot;

  TesseractPerspective() {
  }

  TesseractPerspective(int _x, int _y, int _z, float _xRot, float _yRot, float _zRot)
  {
    x=_x;
    y=_y;
    z=_z;
    xRot=_xRot;
    yRot=_yRot;
    zRot=_zRot;
  }

  void Set(int _x, int _y, int _z, float _xRot, float _yRot, float _zRot)
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
    translate(x, y, z);
    rotateX(xRot);
    rotateY(yRot);
    rotateZ(zRot);
  }

  void resetPerspective()
  {
    rotateZ(-zRot);
    rotateY(-yRot);
    rotateX(-xRot);
    translate(-x, -y, -z);
  }
}
