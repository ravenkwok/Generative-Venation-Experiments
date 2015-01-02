void addVertex(float x, float y){
  Vertex addedV = new Vertex(x, y);
  vts.add(addedV);
}

void addVertices(int amt){
  randomSeed(0);
  for(int i=0; i<amt; i++){
    float radians = random(2*PI);
    float radius = random(float(width)/48, float(width)/3);
    float x = cos(radians)*radius + width/2;
    float y = sin(radians)*radius + height/2;
    addVertex(x, y);
  }
}
