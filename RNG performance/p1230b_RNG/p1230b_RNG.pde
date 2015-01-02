ArrayList <Vertex>vts;

void setup() {
  size(500, 500, P2D);
  smooth(8);

  vts = new ArrayList<Vertex>();
  
  addVertices(1000);
}

void draw() {
  background(255);

  for (int i=0; i<vts.size (); i++) {
    Vertex eachV1 = vts.get(i);
    for (int j=i+1; j<vts.size (); j++) {
      Vertex eachV2 = vts.get(j);
      boolean connect = true;
      float distIJ = dist(eachV1.pos.x, eachV1.pos.y, eachV2.pos.x, eachV2.pos.y);

      for (int k=0; k<vts.size (); k++) {
        if (k==i || k==j) {
          continue;
        } else {
          Vertex compV = vts.get(k);
          float distIK = dist(eachV1.pos.x, eachV1.pos.y, compV.pos.x, compV.pos.y);
          float distJK = dist(eachV2.pos.x, eachV2.pos.y, compV.pos.x, compV.pos.y);
          if (distIK < distIJ && distJK < distIJ){
            connect = false;
            break;
          }
        }
      }

      if (connect) {
        strokeWeight(1);
        stroke(180);
        line(eachV1.pos.x, eachV1.pos.y, eachV2.pos.x, eachV2.pos.y);
      }
    }
  }

  for (int i=0; i<vts.size (); i++) {
    Vertex eachV = vts.get(i);
    eachV.display();
  }
  
  fill(0);
  text("fps: "+floor(frameRate), 20, 20);
}
