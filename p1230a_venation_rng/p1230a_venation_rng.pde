//import megamu.mesh.*;

ArrayList <VeinVtx> veinVts;
ArrayList <VeinEg> veinEgs;
ArrayList <Auxin> auxins;

//int initAuxinsAmt = 2000, initVeinsAmt = 10;
int veinsLastAmt = 1;
float distThreshold = 3;
PImage pattern, contour;
boolean finished;

void setup() {
  size(400, 400, P2D);
  frameRate(30);
  smooth(8);

  veinVts = new ArrayList<VeinVtx>();
  veinEgs = new ArrayList<VeinEg>();
  auxins = new ArrayList<Auxin>();

  pattern = loadImage("leaf01.jpg");
  contour = loadImage("leaf01contour.jpg");
  pattern.loadPixels();
  for (int i=0; i<pattern.height; i++) {
    for (int j=0; j<pattern.width; j++) {
      int index = j+i*pattern.width;
      if (brightness(pattern.pixels[index])<120) {
        float result = map(brightness(pattern.pixels[index]), 0, 128, 0.95, 0.9995);
        if (random(1)>result) addAuxin(j, i);
      }
    }
  }

  addVein(width*.5, height);
}

void draw() {
  //Update data
  if (!finished) {
    resetAuxins();
    updateAuxins();
    updateVeins();
    checkAuxins();
  }

  //Draw everything
  background(255);
  if (finished) image(contour, 0, 0);
  drawAuxins();
  drawVeins();
  drawInfo();
}
