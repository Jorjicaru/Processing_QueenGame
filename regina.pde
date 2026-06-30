class Queen {
  float currentX, currentY;
  int gridX, gridY;
  int startGridX, startGridY;
  boolean isConflicting = false;
  boolean returnToStart = false;
  
  Queen(int startX, int startY) {
    this.startGridX = startX;
    this.startGridY = startY;
    this.gridX = startX;
    this.gridY = startY;
    this.currentX = startX * tileSize + tileSize/2;
    this.currentY = startY * tileSize + tileSize/2;
  }
  
  void setTarget(int tx, int ty) {
    this.gridX = tx;
    this.gridY = ty;
  }
  
  void update() {
    float targetX = gridX * tileSize + tileSize/2;
    float targetY = gridY * tileSize + tileSize/2;
    
    currentX = lerp(currentX, targetX, 0.1);
    currentY = lerp(currentY, targetY, 0.1);
    
    if (returnToStart && dist(currentX, currentY, targetX, targetY) < 1.0) {
      setTarget(startGridX, startGridY); 
      returnToStart = false;
      isConflicting = false;
    }
  }
  
  void display(boolean isSelected) {
    pushMatrix();
    translate(currentX, currentY, 5); 
    rotateX(-PI/2);
    
    if (isConflicting) fill(255, 50, 50); 
    else if (isSelected) fill(50, 255, 50); 
    else fill(220, 180, 40); 
    
    noStroke();
    float r = tileSize * 0.35; 
    
    drawCylinder(24, r, r * 0.8, 5);
    translate(0, -5, 0);
    drawCylinder(24, r * 0.8, r * 0.35, 22);
    translate(0, -22, 0);
    drawCylinder(24, r * 0.45, r * 0.5, 4);
    translate(0, -4, 0);
    drawCylinder(12, r * 0.35, r * 0.6, 8);
    translate(0, -8, 0);
    sphereDetail(30);
    sphere(r * 0.25);
    
    popMatrix();
  }
}
