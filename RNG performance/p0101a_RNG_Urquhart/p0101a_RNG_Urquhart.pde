import megamu.mesh.*;

ArrayList <Vertex>vts;

void setup() {
  size(500, 500, P2D);
  smooth(8);

  vts = new ArrayList<Vertex>();

  addVertices(1000);
}

void draw() {
  background(255);

  float [][] pts = new float[vts.size ()][2];
  for (int i = 0; i<vts.size (); i++) {
    Vertex eachV = vts.get(i);
    pts[i][0] = eachV.pos.x;
    pts[i][1] = eachV.pos.y;
  }

  Delaunay dln = new Delaunay(pts);

  for (int i = 0; i<vts.size (); i++) {
    Vertex v1 = vts.get(i);
    int[] idcs = dln.getLinked(i);
    for (int j = 0; j<idcs.length; j++) {
      boolean connect = true;
      Vertex v2 = vts.get(idcs[j]);
      float distV1V2 = dist(v1.pos.x, v1.pos.y, v2.pos.x, v2.pos.y);
      for (int k = 0; k<idcs.length; k++) {
        if (k==j) {
          continue;
        } else {
          Vertex v3 = vts.get(idcs[k]);
          if (distV1V2 == maxEdge(v1.pos, v2.pos, v3.pos)) {
            connect = false;
            break;
          }
        }
      }

      if (connect) {
        strokeWeight(1);
        stroke(180);
        line(v1.pos.x, v1.pos.y, v2.pos.x, v2.pos.y);
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

float maxEdge(PVector v1, PVector v2, PVector v3) {
  float dist1 = dist(v1.x, v1.y, v2.x, v2.y);
  float dist2 = dist(v1.x, v1.y, v3.x, v3.y);
  float dist3 = dist(v2.x, v2.y, v3.x, v3.y);
  return max(dist1, dist2, dist3);
}
