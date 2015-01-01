class VeinEg{
  
  VeinVtx v1, v2;
  float weight;
  
  VeinEg(VeinVtx v1, VeinVtx v2){
    this.v1 = v1;
    this.v2 = v2;
  }
  
  void display(){
    weight = (v1.weight + v2.weight)*.5;
    stroke(0);
    strokeWeight(weight);
    line(v1.pos.x, v1.pos.y, v2.pos.x, v2.pos.y);
  }
}
