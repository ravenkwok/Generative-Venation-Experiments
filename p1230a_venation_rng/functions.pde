void addVein(float initX, float initY) {
  VeinVtx addedV = new VeinVtx(initX, initY);
  veinVts.add(addedV);
}

void addAuxin(float initX, float initY) {
  Auxin addedAx = new Auxin(initX, initY);
  auxins.add(addedAx);
}

void resetAuxins() {
  for (int i=0; i<auxins.size (); i++) {
    Auxin eachAx = auxins.get(i);
    eachAx.reset();
  }
}

//Relative Neighbors (RNG)
void updateAuxins() {
  for (int i=0; i<auxins.size (); i++) {
    Auxin eachAx = auxins.get(i);

    for (int j=0; j<veinVts.size (); j++) {
      VeinVtx eachV1 = veinVts.get(j);
      boolean interfered = true;
      float distAxV1 = dist(eachAx.pos.x, eachAx.pos.y, eachV1.pos.x, eachV1.pos.y);

      for (int k=0; k<veinVts.size (); k++) {
        if (j == k) {
          continue;
        } else {
          VeinVtx eachV2 = veinVts.get(k);
          float distAxV2 = dist(eachAx.pos.x, eachAx.pos.y, eachV2.pos.x, eachV2.pos.y);
          float distV1V2 = dist(eachV1.pos.x, eachV1.pos.y, eachV2.pos.x, eachV2.pos.y);
          if (distAxV2 < distAxV1 && distV1V2 < distAxV1) {
            interfered = false;
            break;
          }
        }
      }

      if (interfered) {
        PVector diff = PVector.sub(eachAx.pos, eachV1.pos);
        if (diff.mag()>distThreshold) {
          eachV1.addVtx = true;
          diff.normalize();
          eachV1.dir.add(diff);

          eachAx.affectingVeins.add(eachV1);
        }
      }
    }
  }
}

void checkAuxins() {
  for (int i=auxins.size ()-1; i>-1; i--) {
    Auxin eachAx = auxins.get(i);
    boolean removeAx = true;
    for (int j=0; j<eachAx.affectingVeins.size (); j++) {
      VeinVtx compV = eachAx.affectingVeins.get(j);
      float distance = dist(eachAx.pos.x, eachAx.pos.y, compV.pos.x, compV.pos.y);
      if (distance>distThreshold) {
        removeAx = false;
        break;
      }
    }
    if (removeAx) auxins.remove(i);
  }
}

void clearAuxins() {
  for (int i=auxins.size ()-1; i>-1; i--) {
    auxins.remove(i);
  }
}

void updateVeins() {

  for (int i=0; i<veinVts.size (); i++) {
    VeinVtx eachV = veinVts.get(i); 
    eachV.grow(); 
    eachV.reset();
  }

  for (int i=veinVts.size ()-1; i>-1; i--) {
    VeinVtx eachV = veinVts.get(i); 
    eachV.update();
  }

  //Compare positions of the new added veins with existing veins, clear out the overlapped ones
  for (int i=veinVts.size ()-1; i>veinsLastAmt-1; i--) {
    VeinVtx eachV = veinVts.get(i); 
    for (int j=veinsLastAmt-1; j>-1; j--) {
      VeinVtx previousV = veinVts.get(j); 
      float distance = dist(eachV.pos.x, eachV.pos.y, previousV.pos.x, previousV.pos.y); 
      if (distance<1) {
        veinVts.remove(i);
      }
    }
  }
  if (veinsLastAmt == veinVts.size() && auxins.size()>0) {
    clearAuxins();
    finished = true;
  } else {
    veinsLastAmt = veinVts.size();
  }
}

void drawAuxins() {
  for (int i=0; i<auxins.size (); i++) {
    Auxin eachAx = auxins.get(i); 
    eachAx.display();
  }
}

void drawVeins() {
  //Display vein vertices
  /*for (int i=0; i<veinVts.size (); i++) {
   VeinVtx eachV = veinVts.get(i);
   eachV.display();
   }*/

  //Display vein connections
  for (int i=0; i<veinEgs.size (); i++) {
    VeinEg eachV = veinEgs.get(i); 
    eachV.display();
  }
}
void drawInfo() {
  noStroke(); 
  fill(0); 
  rect(0, 0, width, 25); 
  fill(255); 
  textSize(12); 
  textAlign(LEFT, BOTTOM); 
  text("Veins amt: "+veinVts.size()+"; Auxins left: "+auxins.size(), 20, 20);
}





//Nearest Neighbor (NNG)

/*void updateAuxins() {
 for (int i=0; i<auxins.size (); i++) {
 Auxin eachAx = auxins.get(i);
 VeinVtx lastV = veinVts.get(veinVts.size()-1);
 eachAx.closestV = lastV;
 
 float minDist = 1000;
 int minIdx = 0;
 
 for (int j=0; j<veinVts.size (); j++) {
 VeinVtx eachV = veinVts.get(j);
 float distance = dist(eachAx.pos.x, eachAx.pos.y, eachV.pos.x, eachV.pos.y);
 if (distance<minDist) {
 minDist = distance;
 minIdx = j;
 } else {
 continue;
 }
 }
 VeinVtx closestV = veinVts.get(minIdx);
 eachAx.closestV = closestV;
 PVector diff = PVector.sub(eachAx.pos, closestV.pos);
 closestV.addVtx = true;
 diff.normalize();
 closestV.dir.add(diff);
 }
 }*/





//Relative Neighbors Urquhart Graph

/*void updateAuxins() {
 for (int i=0; i<auxins.size (); i++) {
 Auxin eachAx = auxins.get(i);
 
 float [][] pts = new float[veinVts.size ()+1][2];
 for (int j = 0; j<veinVts.size (); j++) {
 VeinVtx eachV = veinVts.get(j);
 pts[j][0] = eachV.pos.x;
 pts[j][1] = eachV.pos.y;
 }
 pts[veinVts.size()][0] = eachAx.pos.x;
 pts[veinVts.size()][1] = eachAx.pos.y;
 
 Delaunay dln = new Delaunay(pts);
 int[] idcs = dln.getLinked(veinVts.size());
 
 for (int j=0; j<idcs.length; j++) {
 boolean interfered = true;
 VeinVtx v1 = veinVts.get(idcs[j]);
 float distAxV1 = dist(eachAx.pos.x, eachAx.pos.y, v1.pos.x, v1.pos.y);
 
 for (int k=0; k<idcs.length; k++) {
 if (k == j) {
 continue;
 } else {
 VeinVtx v2 = veinVts.get(idcs[k]);
 if (distAxV1 == maxEdge(eachAx.pos, v1.pos, v2.pos)) {
 interfered = false;
 break;
 }
 }
 }
 
 if (interfered) {
 PVector diff = PVector.sub(eachAx.pos, v1.pos);
 v1.addVtx = true;
 diff.normalize();
 v1.dir.add(diff);
 eachAx.affectingVeins.add(v1);
 }
 }
 }
 }*/





/*float maxEdge(PVector v1, PVector v2, PVector v3) {
 float dist1 = dist(v1.x, v1.y, v2.x, v2.y);
 float dist2 = dist(v1.x, v1.y, v3.x, v3.y);
 float dist3 = dist(v2.x, v2.y, v3.x, v3.y);
 return max(dist1, dist2, dist3);
 }*/





//checkAuxins for NNG
/*void checkAuxins() {
 for (int i=auxins.size ()-1; i>-1; i--) {
 Auxin eachAx = auxins.get(i);
 
 for (int j=0; j<veinVts.size (); j++) {
 VeinVtx eachV = veinVts.get(j);
 float distance = dist(eachAx.pos.x, eachAx.pos.y, eachV.pos.x, eachV.pos.y);
 if (distance<distThreshold) {
 auxins.remove(i);
 break;
 }
 }
 }
 }*/
