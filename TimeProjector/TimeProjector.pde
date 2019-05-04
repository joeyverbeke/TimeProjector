//DISPLAY=:0 /usr/local/bin/processing-java --sketch=/home/pi/Documents/TimeProjector/TimeProjector --run //<>// //<>// //<>//

boolean controlCameraWithMouse = false;
String SCENE = "RotatingLight";
//4D_Rotation, PlaneToVolume, RotatingLight

boolean increaseFourDeeSpeed = false;

OPC opc;
TesseractPerspective[] tesseractPerspectives;
static TimeProjectorForm timeProjectorForm;

boolean ghostFade = false;

int ledCount = 0;

int faceWidth, faceHeight;
int squareX, squareY;

int _width, _height;
int padding = 25;


////planeToVolume
ArrayList<SingleEdgeFader> planeToVolume;
int p2v_pos = 0;
int p2v_scene = 0;
int p2v_timestamp = 0;
////

////4dRotation
ArrayList<EdgeFader> fourDeeSquares;
int fourD_pos = 0;
ArrayList<GradientLine> fourDeeEdges;
float fourD_speed;
////

////movingPointTest
ArrayList<GradientLine> rotatingLight_bottom;
ArrayList<GradientLine> rotatingLight_top;
ArrayList<GradientLine> rotatingLight_innerBottom;
ArrayList<GradientLine> rotatingLight_innerTop;


ArrayList<ArrayList<GradientLine>> rotatingLights;

int rotatingLight_pos = 0;

void setup()
{
  size(700, 400, P3D);
  ortho();
  colorMode(HSB, 360, 100, 100);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  faceWidth = width/3;
  faceHeight = height/8;
  _width = 600;
  _height = 300;

  tesseractPerspectives = new TesseractPerspective[6];

  tesseractPerspectives[0] = new TesseractPerspective(padding + _width/6, padding + _height/4, 0, 0, 0, 0);
  tesseractPerspectives[1] = new TesseractPerspective(50 + _width/2, 25 + _height/4, 0, PI/2, 0, 0);
  tesseractPerspectives[2] = new TesseractPerspective(width - _width/6 - padding, 25 + _height/4, 0, 0, 0, PI/2);
  tesseractPerspectives[3] = new TesseractPerspective(padding + _width/6, height - padding - _height/4, 0, 0, 0, PI);
  tesseractPerspectives[4] = new TesseractPerspective(50 + _width/2, height - 25 - _height/4, 0, -PI/2, 0, 0);
  tesseractPerspectives[5] = new TesseractPerspective(width - _width/6 - padding, height - 25 - _height/4, 0, 0, 0, 3*PI/2);


  timeProjectorForm = new TimeProjectorForm();

  //setup plane to volume
  planeToVolume = new ArrayList<SingleEdgeFader>();
  color[] bwb = {color(0, 0, 0), color(0, 0, 100), color(0, 0, 0)};
  color[] bBb = {color(0, 0, 0), color(240, 100, 100), color(0, 0, 0)};
  color[] wBb = {color(0, 0, 100), color(240, 100, 100), color(0, 0, 0)};
  color[] Brb = {color(240, 100, 100), color(0, 0, 100), color(0, 100, 100)};
  color[] wrb = {color(0, 0, 100), color(0, 100, 100), color(0, 0, 0)};
  color[] wb = {color(0, 0, 100), color(0, 0, 0)};
  color[] Bb = {color(240, 100, 100), color(0, 0, 0)};
  color[] brb = {color(0, 0, 0), color(0, 100, 100), color(0, 0, 0)};

  color[] bPb = {color(0, 0, 0), color(0, 100, 100), color(0, 0, 0)};
  color[] bTb = {color(0, 0, 0), color(340, 100, 100), color(0, 0, 0)}; // 330/340 works well for pinkishRed

  color[] Pb = {color(0, 100, 100), color(0, 0, 0)};
  color[] Tb = {color(340, 100, 100), color(0, 0, 0)};

  float p2v_speed = 0.01;


  //1
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, bwb, true)); 
  planeToVolume.add(new SingleEdgeFader("LFTL", p2v_speed, bwb, true));   
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LBTR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LFBL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LBBR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("OLF", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("ILF", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("IRB", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("ORB", p2v_speed, bwb, true));    

  //2
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, bwb, true));
  planeToVolume.add(new SingleEdgeFader("LBTL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LFTR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LFBR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("LBBL", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("ILB", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("IRF", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("OLB", p2v_speed, bwb, true));    
  planeToVolume.add(new SingleEdgeFader("ORF", p2v_speed, bwb, true)); 

  //1-off
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, wb, true)); 
  planeToVolume.add(new SingleEdgeFader("LFTL", p2v_speed, wb, true));   
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LBTR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LFBL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LBBR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("OLF", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("ILF", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("IRB", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("ORB", p2v_speed, wb, true));    

  //2-off
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, wb, true));
  planeToVolume.add(new SingleEdgeFader("LBTL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LFTR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LFBR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("LBBL", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("ILB", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("IRF", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("OLB", p2v_speed, wb, true));    
  planeToVolume.add(new SingleEdgeFader("ORF", p2v_speed, wb, true)); 

  //3
  planeToVolume.add(new SingleEdgeFader("OTB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTF", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ITF", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ITB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("LBTR", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("LBTL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("LFTL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("LFTR", p2v_speed, bPb, true));

  //4
  planeToVolume.add(new SingleEdgeFader("OBB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("OBF", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBF", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("LBBR", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("LBBL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("LFBL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("LFBR", p2v_speed, bTb, true));

  //3-off
  planeToVolume.add(new SingleEdgeFader("OTB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTF", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ITF", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ITB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("LBTR", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("LBTL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("LFTL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("LFTR", p2v_speed, Pb, true));

  //4-off
  planeToVolume.add(new SingleEdgeFader("OBB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("OBF", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBF", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("LBBR", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("LBBL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("LFBL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("LFBR", p2v_speed, Tb, true));

  //innerCube
  planeToVolume.add(new SingleEdgeFader("IBB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBF", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ITB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ITF", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IRB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ILB", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("IRF", p2v_speed, bTb, true));
  planeToVolume.add(new SingleEdgeFader("ILF", p2v_speed, bTb, true));

  //outerCube
  planeToVolume.add(new SingleEdgeFader("OBB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OBF", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTF", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ORB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OLB", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("ORF", p2v_speed, bPb, true));
  planeToVolume.add(new SingleEdgeFader("OLF", p2v_speed, bPb, true));

  //innerCube-off
  planeToVolume.add(new SingleEdgeFader("IBB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBF", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IBL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ITB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ITR", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ITF", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IRB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ILB", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("IRF", p2v_speed, Tb, true));
  planeToVolume.add(new SingleEdgeFader("ILF", p2v_speed, Tb, true));

  //outerCube-off
  planeToVolume.add(new SingleEdgeFader("OBB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OBR", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OBF", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTF", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OTL", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ORB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OLB", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("ORF", p2v_speed, Pb, true));
  planeToVolume.add(new SingleEdgeFader("OLF", p2v_speed, Pb, true));

  /*
  //link-1
   planeToVolume.add(new SingleEdgeFader("IBR", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("IBB", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("LBBR", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("OBB", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("OLB", p2v_speed, bPb, true)); 
   planeToVolume.add(new SingleEdgeFader("OTR", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("LFTR", p2v_speed, bPb, true));
   planeToVolume.add(new SingleEdgeFader("IRF", p2v_speed, bPb, true));
   
   //link-2
   planeToVolume.add(new SingleEdgeFader("ORB", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("OBL", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("LFBL", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("ILF", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("ITL", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("ITB", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("LBTL", p2v_speed, bTb, true));
   planeToVolume.add(new SingleEdgeFader("OTB", p2v_speed, bTb, true));
   */

  //setup 4d rotation
  fourDeeSquares = new ArrayList<EdgeFader>();
  //color[] bwb = {color(0, 0, 0), color(0, 0, 100), color(0, 0, 0)};

  fourD_speed = 0.01;

  String[] innerBack = {"ITB", "ILB", "IBB", "IRB"}; 
  String[] innerFront = {"ITF", "ILF", "IBF", "IRF"}; 
  String[] outerFront = {"OTF", "OLF", "OBF", "ORF"}; 
  String[] outerBack = {"OTB", "OLB", "OBB", "ORB"}; 

  color[] bw = {color(0, 0, 0), color(0, 0, 100)};


  fourDeeSquares.add(new EdgeFader(innerBack, fourD_speed-0.002, bwb, true));
  fourDeeSquares.add(new EdgeFader(innerFront, fourD_speed-0.002, bwb, true));
  fourDeeSquares.add(new EdgeFader(outerFront, fourD_speed-0.002, bwb, true));
  fourDeeSquares.add(new EdgeFader(outerBack, fourD_speed-0.002, bwb, true));

  fourDeeEdges = new ArrayList<GradientLine>();

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(12), timeProjectorForm.Vertices.get(15), "fadeOn", color(0, 0, 100), fourD_speed, 1)); //ITL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(13), timeProjectorForm.Vertices.get(14), "fadeOn", color(0, 0, 100), fourD_speed, 1)); //ITR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(8), timeProjectorForm.Vertices.get(11), "fadeOn", color(0, 0, 100), fourD_speed, 4));  //IBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(9), timeProjectorForm.Vertices.get(10), "fadeOn", color(0, 0, 100), fourD_speed, 4));  //IBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(12), timeProjectorForm.Vertices.get(15), "fadeOff", color(0, 0, 100), fourD_speed, 1)); //ITL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(13), timeProjectorForm.Vertices.get(14), "fadeOff", color(0, 0, 100), fourD_speed, 1)); //ITR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(8), timeProjectorForm.Vertices.get(11), "fadeOff", color(0, 0, 100), fourD_speed, 4));  //IBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(9), timeProjectorForm.Vertices.get(10), "fadeOff", color(0, 0, 100), fourD_speed, 4));  //IBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(15), timeProjectorForm.Vertices.get(7), "fadeOn", color(0, 0, 100), fourD_speed, 5)); //LFTL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(14), timeProjectorForm.Vertices.get(6), "fadeOn", color(0, 0, 100), fourD_speed, 2)); //LFTR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(11), timeProjectorForm.Vertices.get(3), "fadeOn", color(0, 0, 100), fourD_speed, 5));  //LFBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(10), timeProjectorForm.Vertices.get(2), "fadeOn", color(0, 0, 100), fourD_speed, 2));  //LFBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(15), timeProjectorForm.Vertices.get(7), "fadeOff", color(0, 0, 100), fourD_speed, 5)); //LFTL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(14), timeProjectorForm.Vertices.get(6), "fadeOff", color(0, 0, 100), fourD_speed, 2)); //LFTR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(11), timeProjectorForm.Vertices.get(3), "fadeOff", color(0, 0, 100), fourD_speed, 5));  //LFBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(10), timeProjectorForm.Vertices.get(2), "fadeOff", color(0, 0, 100), fourD_speed, 2));  //LFBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(7), timeProjectorForm.Vertices.get(4), "fadeOn", color(0, 0, 100), fourD_speed, 5)); //OTL 
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(6), timeProjectorForm.Vertices.get(5), "fadeOn", color(0, 0, 100), fourD_speed, 2)); //OTR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(3), timeProjectorForm.Vertices.get(0), "fadeOn", color(0, 0, 100), fourD_speed, 5));  //OBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(2), timeProjectorForm.Vertices.get(1), "fadeOn", color(0, 0, 100), fourD_speed, 2));  //OBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(7), timeProjectorForm.Vertices.get(4), "fadeOff", color(0, 0, 100), fourD_speed, 5)); //OTL 
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(6), timeProjectorForm.Vertices.get(5), "fadeOff", color(0, 0, 100), fourD_speed, 2)); //OTR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(3), timeProjectorForm.Vertices.get(0), "fadeOff", color(0, 0, 100), fourD_speed, 5));  //OBL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(2), timeProjectorForm.Vertices.get(1), "fadeOff", color(0, 0, 100), fourD_speed, 2));  //OBR

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(4), timeProjectorForm.Vertices.get(12), "fadeOn", color(0, 0, 100), fourD_speed, 1)); //LBTR 
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(5), timeProjectorForm.Vertices.get(13), "fadeOn", color(0, 0, 100), fourD_speed, 1)); //LBTL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(0), timeProjectorForm.Vertices.get(8), "fadeOn", color(0, 0, 100), fourD_speed, 4));  //LBBR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(1), timeProjectorForm.Vertices.get(9), "fadeOn", color(0, 0, 100), fourD_speed, 4));  //LBBL

  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(4), timeProjectorForm.Vertices.get(12), "fadeOff", color(0, 0, 100), fourD_speed, 1)); //LBTR 
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(5), timeProjectorForm.Vertices.get(13), "fadeOff", color(0, 0, 100), fourD_speed, 1)); //LBTL
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(0), timeProjectorForm.Vertices.get(8), "fadeOff", color(0, 0, 100), fourD_speed, 4));  //LBBR
  fourDeeEdges.add(new GradientLine(timeProjectorForm.Vertices.get(1), timeProjectorForm.Vertices.get(9), "fadeOff", color(0, 0, 100), fourD_speed, 4));  //LBBL


  //fadingPointTest
  float rotatingLight_speed = 0.01;

  rotatingLight_bottom = new ArrayList<GradientLine>();
  rotatingLight_bottom.add(new GradientLine(timeProjectorForm.Vertices.get(0), timeProjectorForm.Vertices.get(1), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 3)); //OBB
  rotatingLight_bottom.add(new GradientLine(timeProjectorForm.Vertices.get(1), timeProjectorForm.Vertices.get(2), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 2)); //OBR
  rotatingLight_bottom.add(new GradientLine(timeProjectorForm.Vertices.get(2), timeProjectorForm.Vertices.get(3), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 0)); //OBF
  rotatingLight_bottom.add(new GradientLine(timeProjectorForm.Vertices.get(3), timeProjectorForm.Vertices.get(0), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 5)); //OBL

  rotatingLight_top = new ArrayList<GradientLine>();
  rotatingLight_top.add(new GradientLine(timeProjectorForm.Vertices.get(4), timeProjectorForm.Vertices.get(5), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 3)); //OTB
  rotatingLight_top.add(new GradientLine(timeProjectorForm.Vertices.get(5), timeProjectorForm.Vertices.get(6), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 2)); //OTR
  rotatingLight_top.add(new GradientLine(timeProjectorForm.Vertices.get(6), timeProjectorForm.Vertices.get(7), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 0)); //OTF
  rotatingLight_top.add(new GradientLine(timeProjectorForm.Vertices.get(7), timeProjectorForm.Vertices.get(4), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 5)); //OTL

  rotatingLight_innerBottom = new ArrayList<GradientLine>();
  rotatingLight_innerBottom.add(new GradientLine(timeProjectorForm.Vertices.get(9), timeProjectorForm.Vertices.get(8), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 3)); //IBB
  rotatingLight_innerBottom.add(new GradientLine(timeProjectorForm.Vertices.get(8), timeProjectorForm.Vertices.get(11), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 4)); //IBL
  rotatingLight_innerBottom.add(new GradientLine(timeProjectorForm.Vertices.get(11), timeProjectorForm.Vertices.get(10), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 0)); //IBF
  rotatingLight_innerBottom.add(new GradientLine(timeProjectorForm.Vertices.get(10), timeProjectorForm.Vertices.get(9), "fadingPoint", color(0, 100, 100), rotatingLight_speed, 50, 4)); //IBR

  rotatingLight_innerTop = new ArrayList<GradientLine>();
  rotatingLight_innerTop.add(new GradientLine(timeProjectorForm.Vertices.get(13), timeProjectorForm.Vertices.get(12), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 3)); //ITL
  rotatingLight_innerTop.add(new GradientLine(timeProjectorForm.Vertices.get(12), timeProjectorForm.Vertices.get(15), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 1)); //ITB 
  rotatingLight_innerTop.add(new GradientLine(timeProjectorForm.Vertices.get(15), timeProjectorForm.Vertices.get(14), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 0)); //ITR
  rotatingLight_innerTop.add(new GradientLine(timeProjectorForm.Vertices.get(14), timeProjectorForm.Vertices.get(13), "fadingPoint", color(0, 0, 100), rotatingLight_speed, 50, 1)); //ITF



  rotatingLights = new ArrayList<ArrayList<GradientLine>>();

  rotatingLights.add(rotatingLight_bottom);
  rotatingLights.add(rotatingLight_top);
  rotatingLights.add(rotatingLight_innerBottom);
  rotatingLights.add(rotatingLight_innerTop);

  setupLedStrings();
  println("LED count: " + ledCount);
}


void draw()
{
  if (!ghostFade) {
    background(0, 0, 0);
  }
  //drawAllTimeProjectorForms();

  //  if (frameCount%25==0)
  //    println("FrameRate:" + frameRate);

  if (controlCameraWithMouse)
  {
    camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  }

  //fadingEdges(edges, colorFadePos, 0.005, fadeColors.get(0), fadeColors.get(1));
  //smallCubeEdgeFader.Update();
  //largeCubeEdgeFader.Update();

  //gradientLineTest.Update();

  switch(SCENE)
  {
  case "RotatingLight":

    drawEdge(

    switch(rotatingLight_pos)
    {
    case 0:
      println("0");

      for (int i=0; i<rotatingLights.size(); i++)
      {
        rotatingLights.get(i).get(0).Update();

        if (rotatingLights.get(rotatingLights.size()-1).get(0).finished)
          rotatingLight_pos++;
      }  
      break;

    case 1:
      println("1");

      for (int i=0; i<rotatingLights.size(); i++)
      {
        rotatingLights.get(i).get(0).Update();
        rotatingLights.get(i).get(1).Update();
        if (rotatingLights.get(rotatingLights.size()-1).get(1).finished)
        {
          for (int j=0; j<rotatingLights.size(); j++)
          {
            rotatingLights.get(j).get(0).reset();
          }
          rotatingLight_pos++;
        }
      }
      break;

    case 2:
      println("2");

      for (int i=0; i<rotatingLights.size(); i++)
      {
        rotatingLights.get(i).get(1).Update();
        rotatingLights.get(i).get(2).Update();
        if (rotatingLights.get(rotatingLights.size()-1).get(2).finished)
        {
          for (int j=0; j<rotatingLights.size(); j++)
          {
            rotatingLights.get(j).get(1).reset();
          }
          rotatingLight_pos++;
        }
      }
      break;

    case 3:
      println("3");

      for (int i=0; i<rotatingLights.size(); i++)
      {
        rotatingLights.get(i).get(2).Update();
        rotatingLights.get(i).get(3).Update();
        if (rotatingLights.get(rotatingLights.size()-1).get(3).finished)
        {
          for (int j=0; j<rotatingLights.size(); j++)
          {
            rotatingLights.get(j).get(2).reset();
          }
          rotatingLight_pos++;
        }
      }
      break;

    case 4:
      println("4");

      for (int i=0; i<rotatingLights.size(); i++)
      {
        rotatingLights.get(i).get(3).Update();
        rotatingLights.get(i).get(0).Update();
        if (rotatingLights.get(rotatingLights.size()-1).get(0).finished)
        {
          for (int j=0; j<rotatingLights.size(); j++)
          {
            rotatingLights.get(j).get(3).reset();
          }
          rotatingLight_pos=1;
        }
      }
      break;
    }

    break;

  case "PlaneToVolume":

    if (p2v_scene == 0) //light up volume 1 & 2
    {
      for (int i=0; i<=p2v_pos; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(p2v_pos).finished == true && (p2v_pos+1) < planeToVolume.size())
        {
          println(planeToVolume.get(p2v_pos).edgeName);
          p2v_pos++;
        }
      }
      if (p2v_pos == 24)
      {
        p2v_scene++;
        p2v_timestamp = millis();
      }
    } else if (p2v_scene == 1) //hold for 5 seconds
    {
      for (int i=0; i<24; i++)
      {
        planeToVolume.get(i).Update();
      }

      if (millis() - p2v_timestamp >= 5000)
      {
        p2v_scene++;
      }
    } else if (p2v_scene == 2) //turn off volume 1 & 2
    {
      for (int i=24; i<48; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(47).finished == true)
        {
          p2v_scene++;
          p2v_pos = 48;
        }
      }
    } else if (p2v_scene == 3) //turn on volume 3 & 4
    {
      for (int i=48; i<=p2v_pos; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(p2v_pos).finished == true && (p2v_pos+1) < planeToVolume.size())
        {
          println(planeToVolume.get(p2v_pos).edgeName);
          p2v_pos++;
        }
      }
      if (p2v_pos == 72)
      {
        p2v_scene++;
        p2v_timestamp = millis();
      }
    } else if (p2v_scene == 4) //hold for 5 seconds
    {
      for (int i=48; i<72; i++)
      {
        planeToVolume.get(i).Update();
      }

      if (millis() - p2v_timestamp >= 5000)
      {
        p2v_scene++;
      }
    } else if (p2v_scene == 5) //turn off volume 1 & 2
    {
      for (int i=72; i<96; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(95).finished == true)
        {
          p2v_scene++;
          p2v_pos = 96;
        }
      }
    } else if (p2v_scene == 6) //turn on small & big cube
    {
      for (int i=96; i<=p2v_pos; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(p2v_pos).finished == true && (p2v_pos+1) < planeToVolume.size())
        {
          println(planeToVolume.get(p2v_pos).edgeName);
          p2v_pos++;
        }
      }
      if (p2v_pos == 120)
      {
        p2v_scene++;
        p2v_timestamp = millis();
      }
    } else if (p2v_scene == 7) //hold for 5 seconds
    {
      for (int i=96; i<120; i++)
      {
        planeToVolume.get(i).Update();
      }

      if (millis() - p2v_timestamp >= 5000)
      {
        p2v_scene++;
      }
    } else if (p2v_scene == 8) //turn off small & big cube
    {
      for (int i=120; i<144; i++)
      {
        planeToVolume.get(i).Update();

        if (planeToVolume.get(143).finished == true)
        {
          p2v_scene++;
          p2v_pos = 144;
        }
      }
    } 

    /*
    else if (p2v_scene == 9) //turn on link 1 & 2
     {
     for (int i=144; i<=p2v_pos; i++)
     {
     planeToVolume.get(i).Update();
     
     if (planeToVolume.get(p2v_pos).finished == true && (p2v_pos+1) < planeToVolume.size())
     {
     println(planeToVolume.get(p2v_pos).edgeName);
     p2v_pos++;
     }
     }
     if (p2v_pos == 160)
     {
     p2v_scene++;
     p2v_timestamp = millis();
     }
     } else if (p2v_scene == 9) //hold for 5 seconds
     {
     for (int i=144; i<160; i++)
     {
     planeToVolume.get(i).Update();
     }
     
     if (millis() - p2v_timestamp >= 5000)
     {
     p2v_scene++;
     }
     }
     */
    break;

  case "4D_Rotation":

    switch(fourD_pos)
    {
    case 0: //innerBack
      fourDeeSquares.get(0).Update();
      if (fourDeeSquares.get(0).finished == true)
      {
        fourD_pos++;
      }
      break;

    case 1: //innerBack -> innerFront
      fourDeeSquares.get(0).Update();
      for (int i=0; i<4; i++)
      {
        fourDeeEdges.get(i).Update();
      }
      if (fourDeeEdges.get(0).finished == true)
      {
        fourD_pos++;
        fourDeeSquares.get(0).next();
      }
      break;

    case 2: //innerFront
      fourDeeSquares.get(0).Update();
      fourDeeSquares.get(1).Update();
      for (int i=0; i<4; i++)
      {
        fourDeeEdges.get(i).Update();
      }

      if (fourDeeSquares.get(1).finished == true)
      {
        fourD_pos++;
        for (int i=0; i<4; i++)
        {
          fourDeeEdges.get(i).reset();
          fourDeeSquares.get(0).reset();
        }
      }
      break;

    case 3: //innerFront -> outerFront
      fourDeeSquares.get(1).Update();
      for (int i=4; i<12; i++) 
      {
        fourDeeEdges.get(i).Update();
      }
      if (fourDeeEdges.get(4).finished == true)
      {
        fourD_pos++;
        fourDeeSquares.get(1).next();
        for (int i=4; i<8; i++)
        {
          fourDeeEdges.get(i).reset();
        }
      }
      break;

    case 4: //outerFront
      fourDeeSquares.get(1).Update();
      fourDeeSquares.get(2).Update();
      for (int i=8; i<12; i++)
      {
        fourDeeEdges.get(i).Update();
      }

      if (fourDeeSquares.get(2).finished == true)
      {
        fourD_pos++;
        for (int i=8; i<12; i++)
        {
          fourDeeEdges.get(i).reset();
          fourDeeSquares.get(1).reset();
        }
      }
      break;

    case 5: //outerFront -> outerBack
      fourDeeSquares.get(2).Update();
      for (int i=12; i<20; i++) 
      {
        fourDeeEdges.get(i).Update();
      }
      if (fourDeeEdges.get(12).finished == true)
      {
        fourD_pos++;
        fourDeeSquares.get(2).next();
        for (int i=12; i<16; i++)
        {
          fourDeeEdges.get(i).reset();
        }
      }
      break;

    case 6: //outerBack
      fourDeeSquares.get(2).Update();
      fourDeeSquares.get(3).Update();
      for (int i=16; i<20; i++)
      {
        fourDeeEdges.get(i).Update();
      }

      if (fourDeeSquares.get(3).finished == true)
      {
        fourD_pos++;
        for (int i=16; i<20; i++)
        {
          fourDeeEdges.get(i).reset();
          fourDeeSquares.get(2).reset();
        }
      }
      break;

    case 7: //outerBack -> innerBack
      fourDeeSquares.get(3).Update();
      for (int i=20; i<28; i++) 
      {
        fourDeeEdges.get(i).Update();
      }
      if (fourDeeEdges.get(24).finished == true)
      {
        fourD_pos++;
        fourDeeSquares.get(3).next();
        for (int i=20; i<24; i++)
        {
          fourDeeEdges.get(i).reset();
        }

        //increase ze shpeeeeeed
        if (increaseFourDeeSpeed)
        {
          fourD_speed += 0.01;
        }

        for (int i=0; i<fourDeeEdges.size(); i++)
        {
          fourDeeEdges.get(i).setSpeed(fourD_speed);
        }

        for (int i=0; i<fourDeeSquares.size(); i++)
        {
          fourDeeSquares.get(i).setSpeed(fourD_speed);
        }
      }
      break;

    case 8: //innerBack
      fourDeeSquares.get(3).Update();
      fourDeeSquares.get(0).Update();
      for (int i=24; i<28; i++)
      {
        fourDeeEdges.get(i).Update();
      }

      if (fourDeeSquares.get(0).finished == true)
      {
        fourD_pos++;
        for (int i=24; i<28; i++)
        {
          fourDeeEdges.get(i).reset();
          fourDeeSquares.get(3).reset();
        }
      }
      break;

    case 9: //innerBack -> innerFront
      fourDeeSquares.get(0).Update();
      for (int i=28; i<32; i++) 
      {
        fourDeeEdges.get(i).Update();
      }
      for (int i=0; i<4; i++) 
      {
        fourDeeEdges.get(i).Update();
      }

      if (fourDeeEdges.get(28).finished == true)
      {
        fourD_pos = 2; 
        fourDeeSquares.get(0).next();
        for (int i=28; i<32; i++)
        {
          fourDeeEdges.get(i).reset();
        }
      }
      break;
    }

    break;
  default:
    break;
  }

  //mouseTest
  /*
  noStroke();
   pushMatrix();
   fill(0, 0, 100);
   translate(mouseX, mouseY, 500);
   box(10, 10, 1000);
   popMatrix();
   */
  if (ghostFade)
  {
    pushMatrix();
    fill(0, 5);
    translate(width/2, height/2, 0);
    box(1000, 1000, 1000);
    popMatrix();
  }
}

public class GradientLine {

  Vertex start;
  Vertex end;

  String mode;
  color lineColor;

  float lineSize;
  ArrayList<PVector> lineBoxes;
  ArrayList<Float> boxFadePos;  

  float pos;
  float speed;

  int perspective;

  boolean finished = false;

  //with numBoxes
  GradientLine(Vertex _start, Vertex _end, String _mode, color _lineColor, float _speed, int numBoxes, int _perspective)
  {
    start=_start;
    end=_end;
    mode=_mode;
    lineColor=_lineColor;
    speed=_speed;

    lineSize = PVector.dist(start.coordinate, end.coordinate);
    lineBoxes = new ArrayList<PVector>();
    boxFadePos = new ArrayList<Float>();

    perspective = _perspective;

    for (int i=0; i<numBoxes; i++)
    {
      lineBoxes.add(PVector.lerp(start.coordinate, end.coordinate, (float)i/numBoxes));
      boxFadePos.add(0.0);
    }
  }

  //without numBoxes
  GradientLine(Vertex _start, Vertex _end, String _mode, color _lineColor, float _speed, int _perspective)
  {
    start=_start;
    end=_end;
    mode=_mode;
    lineColor=_lineColor;
    speed=_speed;

    lineSize = PVector.dist(start.coordinate, end.coordinate);
    lineBoxes = new ArrayList<PVector>();
    boxFadePos = new ArrayList<Float>();

    perspective = _perspective;


    for (int i=0; i<(int)lineSize; i++)
    {
      lineBoxes.add(PVector.lerp(start.coordinate, end.coordinate, (float)i/((int)lineSize)));
      boxFadePos.add(0.0);
    }
  }

  void setSpeed(float _speed)
  {
    speed = _speed;
  }

  void reset()
  {
    for (int i=0; i < boxFadePos.size(); i++)
    {
      boxFadePos.set(i, 0.0);
      finished = false;
      pos = 0;
    }
  }

  //there should always be more boxes than the length
  void Update()
  {
    switch(mode)
    {
    case "fadeOn":
      pos += speed;

      for (int i=0; i<lineBoxes.size(); i++)
      {
        tesseractPerspectives[perspective].setupPerspective();

        //if pos has passed the point in which this box's index should turn on
        if (pos >= ((float)1/lineBoxes.size() * i))
        {

          boxFadePos.set(i, boxFadePos.get(i) + speed);
          //if(boxFadePos.get(i) > 0 && boxFadePos.get(i) < 0.1)
          //  boxFadePos.set(i, 0.11);

          pushMatrix();

          translate(lineBoxes.get(i).x, lineBoxes.get(i).y, lineBoxes.get(i).z);
          noStroke();
          fill(color(hue(lineColor), saturation(lineColor), boxFadePos.get(i)*100));
          box(2);

          popMatrix();
        }

        tesseractPerspectives[perspective].resetPerspective();
      }

      if (boxFadePos.get(boxFadePos.size()-1) >= 1)
      {
        finished = true;
      }

      break;

    case "fadeOff":
      pos += speed;

      for (int i=0; i<lineBoxes.size(); i++)
      {
        tesseractPerspectives[perspective].setupPerspective();

        //if pos has passed the point in which this box's index should turn off
        if (pos >= ((float)1/lineBoxes.size() * i))
        {
          boxFadePos.set(i, boxFadePos.get(i) + speed);
        }


        pushMatrix();

        translate(lineBoxes.get(i).x, lineBoxes.get(i).y, lineBoxes.get(i).z);
        noStroke();
        fill(color(hue(lineColor), saturation(lineColor), 100 - (boxFadePos.get(i)*100) ));
        box(2);

        popMatrix();

        tesseractPerspectives[perspective].resetPerspective();
      }

      if (boxFadePos.get(boxFadePos.size()-1) >= 1)
      {
        finished = true;
      }

      break;

    case "fadingPoint":
      pos += speed;

      for (int i=0; i<lineBoxes.size(); i++)
      {
        tesseractPerspectives[perspective].setupPerspective();

        //if pos has passed the point in which this box's index should turn on
        if (pos/3 >= ((float)1/lineBoxes.size() * i))
        {
          boolean drawBox = false;

          boxFadePos.set(i, boxFadePos.get(i) + speed);

          if (boxFadePos.get(i) <= 1)
          {
            fill(color(hue(lineColor), saturation(lineColor), boxFadePos.get(i)*100));
            drawBox = true;
          } else if (boxFadePos.get(i) > 1 && boxFadePos.get(i) <= 2)
          {          
            fill(color(hue(lineColor), saturation(lineColor), 100-(boxFadePos.get(i)*100)%100));
            drawBox = true;
          }

          if (drawBox)
          {
            pushMatrix();

            translate(lineBoxes.get(i).x, lineBoxes.get(i).y, lineBoxes.get(i).z);
            noStroke();
            box(2);

            popMatrix();
          }
        }

        tesseractPerspectives[perspective].resetPerspective();
      }

      if (boxFadePos.get(boxFadePos.size()-1) >= 0.25)
      {
        finished = true;
      }

      break;
    default:

      break;
    }
  }
}

public class SingleEdgeFader {
  String edgeName;
  float fadePos;
  float fadeSpeed;
  color[] colors;

  boolean stayOn;
  int pos;

  boolean finished;
  boolean toFromBlack;
  boolean whiteToColor;

  SingleEdgeFader(String _edgeName, float _fadeSpeed, color[] _colors, boolean _stayOn)
  {
    edgeName = _edgeName;
    fadeSpeed = _fadeSpeed;
    colors = new color[_colors.length];
    colors = _colors.clone();

    fadePos = 0;
    stayOn = _stayOn;

    pos = 0;

    finished = false;
    toFromBlack = false;
    whiteToColor = false;
  }

  void setSpeed(float _speed)
  {
    fadeSpeed = _speed;
  }


  void next()
  {
    pos++;
    fadePos = 0;
    finished = false;
  }

  void Update()
  {    
    fadePos += fadeSpeed;
    color c;

    if (brightness(colors[pos % (colors.length)]) == 0 || brightness(colors[(pos+1) % (colors.length)]) == 0)
    {
      toFromBlack = true;
    } else
    {
      toFromBlack = false;
    }

    if ( (saturation(colors[pos % (colors.length)]) == 0 && brightness(colors[pos % (colors.length)]) != 0) || 
      (saturation(colors[(pos+1) % (colors.length)]) == 0 && brightness(colors[(pos+1) % (colors.length)]) != 0) )
    {
      whiteToColor = true;
    } else
    {
      whiteToColor = false;
    }

    if (toFromBlack)
    {
      float brightnessPos = fadePos * 100;

      //from black
      if (brightness(colors[pos % (colors.length)]) == 0)
      {
        if (brightnessPos <= 5)
        {
          brightnessPos = 5;
        }
        c = color(hue(colors[(pos+1) % (colors.length)]), saturation(colors[(pos+1) % (colors.length)]), brightnessPos);
      } else
      {
        if (brightnessPos >= 95)
        {
          brightnessPos = 100;
        }
        c = color(hue(colors[(pos) % (colors.length)]), saturation(colors[(pos) % (colors.length)]), 100-brightnessPos);
      }
    } else if (whiteToColor)
    {
      float saturationPos = fadePos * 100;

      c = color(hue(colors[(pos+1) % (colors.length)]), saturationPos, brightness(colors[(pos+1) % (colors.length)]));
    } else
    {
      c = lerpColor(colors[pos % (colors.length)], colors[(pos+1) % (colors.length)], fadePos);
      c = color(hue(c), abs(sin(fadePos*PI + PI/2)), 100);
      println(hue(c), saturation(c), brightness(c));
    }

    timeProjectorForm.drawEdge(edgeName, c);

    if (fadePos >= 1 && !stayOn)
    {
      fadePos = 0;
      finished = false;
      pos++;
    } else if (fadePos >= 1)
    {
      finished = true;
    }
  }
}

public class EdgeFader {
  int edgeNums[];
  String edgeNames[];
  float fadePos;
  float fadeSpeed;
  color colors[];

  int pos;
  boolean toFromBlack = false;
  boolean stayOn;
  boolean finished = false;

  EdgeFader(int _edgeNums[], float _fadeSpeed, color _colors[])
  {
    edgeNames = new String[0];
    edgeNums = new int[_edgeNums.length];
    edgeNums = _edgeNums.clone();
    fadeSpeed = _fadeSpeed;
    colors = new color[_colors.length];
    colors = _colors.clone();

    fadePos = 0;
    pos = 0;
  }

  EdgeFader(String _edgeNames[], float _fadeSpeed, color _colors[], boolean _stayOn)
  {
    edgeNums = new int[0];
    edgeNames = new String[_edgeNames.length];
    edgeNames = _edgeNames.clone();
    fadeSpeed = _fadeSpeed;
    colors = new color[_colors.length];
    colors = _colors.clone();

    fadePos = 0;
    pos = 0;
    stayOn = _stayOn;
  }

  void setSpeed(float _speed)
  {
    fadeSpeed = _speed-0.002;
  }

  void next()
  {
    pos++;
    fadePos = 0.0;
    finished = false;
  }

  void reset()
  {
    pos = 0;
    fadePos = 0.0;
    finished = false;
  }

  void Update()
  {    
    if (brightness(colors[pos % (colors.length)]) == 0 || brightness(colors[(pos+1) % (colors.length)]) == 0)
    {
      toFromBlack = true;
    } else
    {
      toFromBlack = false;
    }

    fadePos += fadeSpeed;

    color c;
    if (!toFromBlack)
    {
      c = lerpColor(colors[pos % (colors.length)], colors[(pos+1) % (colors.length)], fadePos);
    } else
    {
      float brightnessPos = fadePos * 100;

      //from black
      if (brightness(colors[pos % (colors.length)]) == 0)
      {
        if (brightnessPos <= 5)
        {
          brightnessPos = 5;
        }
        c = color(hue(colors[(pos+1) % (colors.length)]), saturation(colors[(pos+1) % (colors.length)]), brightnessPos);
      } else
      {
        if (brightnessPos >= 95)
        {
          brightnessPos = 100;
        }
        c = color(hue(colors[(pos) % (colors.length)]), saturation(colors[(pos) % (colors.length)]), 100-brightnessPos);
      }
    }

    if (edgeNums.length > 0)
    {
      for (int i=0; i < edgeNums.length; i++)
      {
        timeProjectorForm.drawEdge(edgeNums[i], c);
      }
    } else
    {
      for (int i=0; i < edgeNames.length; i++)
      {
        timeProjectorForm.drawEdge(edgeNames[i], c);
      }
    }

    if (fadePos >= 1 && !stayOn)
    {
      fadePos = 0;
      finished = false;
      pos++;
    } else if (fadePos >= 1)
    {
      finished = true;
    }
  }
}

//returns true when finished --- should change to ms based not framerate but i dont have time
boolean fadingEdges(int[] edges, float fadePos, float fadeSpeed, color from, color to)
{
  fadePos += fadeSpeed;

  if (fadePos >= 1)
  {
    fadePos = 0;
    return true;
  }

  color c = lerpColor(from, to, fadePos);

  for (int i=0; i < edges.length-1; i++)
  {
    timeProjectorForm.drawEdge(edges[i], c);
  }

  return false;
}

void drawBlockers()
{
  PShape verticalSlice = createShape();
  verticalSlice.beginShape();

  PVector topLeft = PVector.lerp(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(4).coordinate, 0.01);
  PVector topRight = PVector.lerp(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 0.01);
  PVector bottomRight = PVector.lerp(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 0.01);
  PVector bottomLeft = PVector.lerp(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 0.01);

  verticalSlice.vertex(topLeft.x, topLeft.y, topLeft.z);
  verticalSlice.vertex(topRight.x, topRight.y, topRight.z);
  verticalSlice.vertex(bottomRight.x, bottomRight.y, bottomRight.z);
  verticalSlice.vertex(bottomLeft.x, bottomLeft.y, bottomLeft.z);
  verticalSlice.vertex(topLeft.x, topLeft.y, topLeft.z);

  verticalSlice.endShape();
  verticalSlice.setFill(color(0, 0, 0));
  verticalSlice.setStroke(false);

  tesseractPerspectives[0].setupPerspective();
  shape(verticalSlice);
  tesseractPerspectives[0].resetPerspective();

  tesseractPerspectives[3].setupPerspective();
  shape(verticalSlice);
  tesseractPerspectives[3].resetPerspective();
}



void circleSnake()
{
}

//move to animation
void drawPlane(int planeNum, color planeColor)
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.Planes.get(planeNum).setFill(planeColor);
    timeProjectorForm.Planes.get(planeNum).setStroke(planeColor);
    shape(timeProjectorForm.Planes.get(planeNum));
    tesseractPerspectives[i].resetPerspective();
  }
}

void drawAllTimeProjectorForms()
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.drawEdges();
    tesseractPerspectives[i].resetPerspective();
  }
}

//move to animation?
void drawEdge(int edgeNum, color _color)
{
  timeProjectorForm.drawEdge(edgeNum, _color);
}

//move to animation?
void drawEdge(String edgeName, color _color)
{
  timeProjectorForm.drawEdge(edgeName, _color);
}

//move to animation?
void drawVertex(int vertexNum)
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    timeProjectorForm.drawVertex(vertexNum);
    tesseractPerspectives[i].resetPerspective();
  }
}

void setupTimeProjectorFormFaces()
{
  for (int i=0; i<tesseractPerspectives.length; i++)
  {
    tesseractPerspectives[i].setupPerspective();
    //timeProjectorForm.connectAllPoints();
    timeProjectorForm.drawVertices();
    tesseractPerspectives[i].resetPerspective();
  }
}

void setupTesseractFaces()
{
  drawTesseract(25, 50, padding + _width/6, padding + _height/4, 0, 0, 0, 0);
  drawTesseract(25, 50, 50 + _width/2, 25 + _height/4, 0, PI/2, 0, 0);
  drawTesseract(25, 50, width - _width/6 - padding, 25 + _height/4, 0, 0, PI/2, 0);
  drawTesseract(25, 50, padding + _width/6, height - padding - _height/4, 0, 0, PI, 0);
  drawTesseract(25, 50, 50 + _width/2, height - 25 - _height/4, 0, -PI/2, 0, 0);
  drawTesseract(25, 50, width - _width/6 - padding, height - 25 - _height/4, 0, 0, 3*PI/2, 0);
}


//-------------------//

void setupLedStrings() ////TODO: Fix front and back squares
{
  //setup LEDs in order

  //1-0
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 29, 0);   //OTF
  ledStrip(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 10, 5);  //LFTL
  ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 14, 0); //ITF
  ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 11, 4);//ITR -1

  //1-1
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(14).coordinate, 14, 2);  //LFTR
  ledStrip(timeProjectorForm.Vertices.get(14).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 14, 0); //IRF
  ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 14, 0); //IBF
  ledStrip(timeProjectorForm.Vertices.get(11).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 12, 1);  //IBL
  ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 8, 3);   //IBB

  //1-2
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 33, 0);   //ORF
  ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(10).coordinate, 11, 2);  //LFBR
  ledStrip(timeProjectorForm.Vertices.get(10).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 12, 1);  //IBR
  ledStrip(timeProjectorForm.Vertices.get(9).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 8, 3);  //ILB

  //1-3
  ledStrip(timeProjectorForm.Vertices.get(6).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 23, 2);  //OTR
  ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 19, 3);  //OLB
  ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(2).coordinate, 22, 2);  //OBR -1

  //1-4
  ledStrip(timeProjectorForm.Vertices.get(2).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 30, 0);   //OBF


  //2-0
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(7).coordinate, 21, 5);  //OTL
  ledStrip(timeProjectorForm.Vertices.get(7).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 30, 0);   //OLF
  ledStrip(timeProjectorForm.Vertices.get(3).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 11, 5);  //LFBL

  //2-1
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(5).coordinate, 19, 3);  //OTB
  ledStrip(timeProjectorForm.Vertices.get(5).coordinate, timeProjectorForm.Vertices.get(13).coordinate, 15, 4); //LBTL -2
  ledStrip(timeProjectorForm.Vertices.get(13).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 8, 3); //ITB
  ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(15).coordinate, 10, 4);//ITL -2
  ledStrip(timeProjectorForm.Vertices.get(15).coordinate, timeProjectorForm.Vertices.get(11).coordinate, 12, 0); //ILF -2

  //2-2
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(12).coordinate, 16, 4); //LBTR
  ledStrip(timeProjectorForm.Vertices.get(12).coordinate, timeProjectorForm.Vertices.get(8).coordinate, 8, 3);  //IRB
  ledStrip(timeProjectorForm.Vertices.get(8).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 15, 1);   //LBBR -1
  ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(3).coordinate, 23, 5);  //OBL

  //2-3
  ledStrip(timeProjectorForm.Vertices.get(4).coordinate, timeProjectorForm.Vertices.get(0).coordinate, 19, 3);  //ORB
  ledStrip(timeProjectorForm.Vertices.get(0).coordinate, timeProjectorForm.Vertices.get(1).coordinate, 19, 3);  //OBB
  ledStrip(timeProjectorForm.Vertices.get(1).coordinate, timeProjectorForm.Vertices.get(9).coordinate, 17, 1);   //LBBL
}

void ledStrip(PVector start, PVector end, int numLeds, int perspectiveNum)
{
  float stepValue = (float)(0.9 /  numLeds);
  PVector pixelVector;

  tesseractPerspectives[perspectiveNum].setupPerspective();

  for (float i=0.05; i < 0.948; i += stepValue)
  {    
    pixelVector = PVector.lerp(start, end, i);

    //fill(255, 0, 255);
    pushMatrix();
    translate(pixelVector.x, pixelVector.y, pixelVector.z);
    pixelVector.set(0, 0, 0);
    opc.led(ledCount, (int)screenX(pixelVector.x, pixelVector.y, pixelVector.z), (int)screenY(pixelVector.x, pixelVector.y, pixelVector.z));
    popMatrix();

    ledCount++;
  }

  tesseractPerspectives[perspectiveNum].resetPerspective();

  println("ledcount: " + ledCount);
}

void ledSquare(int x, int y, int squareWidth, int squareHeight)
{
  for (int i=x; i < x+squareWidth; i++)
  {
    opc.led(ledCount, i, y);
    ledCount++;
  }
  for (int i=y; i<y+squareHeight; i++)
  {
    opc.led(ledCount, x+squareWidth, i);
    ledCount++;
  }
  for (int i=x+squareWidth; i >= x; i--)
  {
    opc.led(ledCount, i, y+squareHeight);
    ledCount++;
  }
  for (int i=y+squareHeight; i>=y; i--)
  {
    opc.led(ledCount, x, i);
    ledCount++;
  }
}

void drawPixels()
{

  ledSquare(width/2 - 15, 30, 30, 30);
  ledSquare(width/2 - 15, 65, 30, 30);
  ledSquare(width/2 + 20, 65, 30, 30);
  ledSquare(width/2 - 50, 65, 30, 30);
  ledSquare(width/2 - 15, 100, 30, 30);
  ledSquare(width/2 - 15, 135, 30, 30);

  ledSquare(width/2 - 10, 200, 20, 20);
  ledSquare(width/2 - 10, 225, 20, 20);
  ledSquare(width/2 + 15, 225, 20, 20);
  ledSquare(width/2 - 35, 225, 20, 20);
  ledSquare(width/2 - 10, 250, 20, 20);
  ledSquare(width/2 - 10, 275, 20, 20);
}


void drawTesseract(int inside, int outside, int x, int y, int z, float xRot, float yRot, float zRot)
{

  //println(x + " " + y + " " + z);
  noFill();
  stroke(0);
  translate(x, y, z);
  rotateX(xRot);
  rotateY(yRot);
  rotateZ(zRot);

  beginShape();

  //inside top
  vertex(-inside, -inside, -inside);
  vertex(-inside, -inside, inside);
  vertex(inside, -inside, inside);
  vertex(inside, -inside, -inside);
  vertex(-inside, -inside, -inside);

  //inside bottom
  vertex(-inside, inside, -inside);

  vertex(-inside, inside, inside);
  vertex(-inside, -inside, inside);
  vertex(-inside, inside, inside);

  vertex(inside, inside, inside);
  vertex(inside, -inside, inside);
  vertex(inside, inside, inside);

  vertex(inside, inside, -inside);
  vertex(inside, -inside, -inside);
  vertex(inside, inside, -inside);

  vertex(-inside, inside, -inside);

  //outside bottom
  vertex(-outside, outside, -outside);

  vertex(-outside, outside, outside);
  vertex(-inside, inside, inside);
  vertex(-outside, outside, outside);

  vertex(outside, outside, outside);
  vertex(inside, inside, inside);
  vertex(outside, outside, outside);

  vertex(outside, outside, -outside);
  vertex(inside, inside, -inside);
  vertex(outside, outside, -outside);

  vertex(-outside, outside, -outside);
  vertex(-inside, inside, -inside);
  vertex(-outside, outside, -outside);

  //outside top
  vertex(-outside, -outside, -outside);

  vertex(-outside, -outside, outside);
  vertex(-inside, -inside, inside);
  vertex(-outside, -outside, outside);
  vertex(-outside, outside, outside);
  vertex(-outside, -outside, outside);

  vertex(outside, -outside, outside);
  vertex(inside, -inside, inside);
  vertex(outside, -outside, outside);
  vertex(outside, outside, outside);
  vertex(outside, -outside, outside);

  vertex(outside, -outside, -outside);
  vertex(inside, -inside, -inside);
  vertex(outside, -outside, -outside);
  vertex(outside, outside, -outside);
  vertex(outside, -outside, -outside);

  vertex(-outside, -outside, -outside);
  vertex(-inside, -inside, -inside);
  vertex(-outside, -outside, -outside);
  vertex(-outside, outside, -outside);
  vertex(-outside, -outside, -outside);

  endShape();

  rotateX(-xRot);
  rotateY(-yRot);
  rotateZ(-zRot);
  translate(-x, -y, -z);
}
