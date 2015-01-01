class VeinVtx {

  ArrayList <VeinVtx> childrenVts;

  PVector pos, dir;
  boolean addVtx;
  float weight, magnitude = 3;
  int childAmt;

  VeinVtx(float initX, float initY) {
    pos = new PVector(initX, initY);
    dir = new PVector(0, 0);
    childrenVts = new ArrayList<VeinVtx>();
  }

  void grow() {
    if (addVtx) {
      childAmt++;
      dir.normalize();
      dir.mult(magnitude);
      PVector nextPos = PVector.add(pos, dir);
      addVein(nextPos.x, nextPos.y);

      VeinVtx nextVtx = veinVts.get(veinVts.size()-1);
      childrenVts.add(nextVtx);
      VeinEg addedEg = new VeinEg(this, nextVtx);
      veinEgs.add(addedEg);
    }
  }

  void update() {
    if (childAmt == 0) {
      weight = 1;
    } else {
      //Murray's Law - http://en.wikipedia.org/wiki/Murray's_law
      float sum = 0;
      for(int i=0; i<childrenVts.size(); i++){
        VeinVtx eachChild = childrenVts.get(i);
        sum += pow(eachChild.weight, 3);
      }
      weight = pow(sum, 1.0/3);
    }
  }

  void reset() {
    addVtx = false;
    dir.set(0, 0);
  }

  void display() {
    strokeWeight(weight);
    stroke(0);
    point(pos.x, pos.y);
  }
}

