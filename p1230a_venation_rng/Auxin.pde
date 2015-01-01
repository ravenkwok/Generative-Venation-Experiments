class Auxin {
  
  ArrayList <VeinVtx> affectingVeins;
  PVector pos;

  Auxin(float initX, float initY) {
    pos = new PVector(initX, initY);
    affectingVeins = new ArrayList<VeinVtx>();
  }
  
  void reset(){
    for(int i=affectingVeins.size()-1; i>-1; i--){
      affectingVeins.remove(i);
    }
  }

  void display() {
    strokeWeight(2);
    stroke(#0000FF);
    point(pos.x, pos.y);
    
    /*strokeWeight(0.5);
    stroke(#31C96F, 128);
    line(pos.x, pos.y, closestV.pos.x, closestV.pos.y);*/
  }
}

