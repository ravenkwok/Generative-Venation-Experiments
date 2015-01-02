class Vertex{
  
  PVector pos;
  
  Vertex(float initX, float initY){
    pos = new PVector(initX, initY);
  }
  
  void display(){
    strokeWeight(2);
    stroke(0);
    point(pos.x, pos.y);
  }
}
