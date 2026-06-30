void mousePressed() {
  if (isAutoMode) return;
  
  if (mouseButton == LEFT) {
    pushMatrix();
    translate(transX, transY, transZ);
    scale(scaleF);
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    translate(-n * tileSize / 2, -n * tileSize / 2, 0);
    
    int bestX = -1;
    int bestY = -1;
    float minDist = Float.MAX_VALUE;
    
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        float cx = i * tileSize + tileSize/2;
        float cy = j * tileSize + tileSize/2;
        float sx = screenX(cx, cy, 0);
        float sy = screenY(cx, cy, 0);
        float d = dist(mouseX, mouseY, sx, sy);
        
        if (d < minDist) {
          minDist = d;
          bestX = i;
          bestY = j;
        }
      }
    }
    popMatrix();
    
    boolean clickedOnBoard = (minDist < (tileSize * scaleF));

    if (selectedQueenIndex == -1) {
      for (int i = 0; i < queens.size(); i++) {
        if (queens.get(i).gridX < 0) {
          selectedQueenIndex = i;
          break;
        }
      }
    } else {
      if (clickedOnBoard) {
        int gridX = bestX;
        int gridY = bestY;
        
        Queen sq = queens.get(selectedQueenIndex);
        sq.setTarget(gridX, gridY);
        moveCount++; 
        
        boolean conflict = false;
        for (int i = 0; i < queens.size(); i++) {
          if (i != selectedQueenIndex && queens.get(i).gridX >= 0) {
            Queen other = queens.get(i);
            if (other.gridX == gridX || other.gridY == gridY || Math.abs(other.gridX - gridX) == Math.abs(other.gridY - gridY)) {
              conflict = true;
              other.isConflicting = true; 
            }
          }
        }
        
        if (conflict) {
          sq.isConflicting = true;
          sq.returnToStart = true; 
        } else {
           for(Queen q : queens) q.isConflicting = false;
        }
        selectedQueenIndex = -1; 
      } else {
        selectedQueenIndex = -1;
      }
    }
  }
}

//rotatie click dreapta
void mouseDragged() {
  if (mouseButton == RIGHT) {
    float deltaX = mouseX - pmouseX;
    float deltaY = mouseY - pmouseY;
    rotZ -= deltaX * 0.01; 
    rotX -= deltaY * 0.01; 
  }
}

//zoom rotita
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scaleF -= e * 0.05; 
  if (scaleF < 0.1) scaleF = 0.1; 
}

//tastatura
void keyPressed() {
  if (keyCode == LEFT) transX -= 15;
  if (keyCode == RIGHT) transX += 15;
  if (keyCode == UP) transY -= 15;
  if (keyCode == DOWN) transY += 15;
  
  if (key == '+') scaleF += 0.05;
  if (key == '-') { scaleF -= 0.05; if (scaleF < 0.1) scaleF = 0.1; }
  
  if (key == 'm' || key == 'M') {
    isAutoMode = !isAutoMode;
    initGame();
  }
  
  if (key == 'r' || key == 'R') {
    initGame();
    resetMessage = "JOCUL A FOST RESETAT!";
    messageTimer = millis() + 3000; 
  }
  
  if (key == 'z' || key == 'Z') {
     for (int i = queens.size() - 1; i >= 0; i--) {
        Queen q = queens.get(i);
        if (q.gridX >= 0) {
           q.setTarget(q.startGridX, q.startGridY);
           q.isConflicting = false; 
           for(Queen other : queens) other.isConflicting = false; 
           break;
        }
     }
  }
  
  if (key >= '5' && key <= '9') { n = key - '0'; initGame(); }
  if (key == '0') { n = 10; initGame(); }
}
