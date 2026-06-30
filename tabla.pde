void drawBoard() {
  
  // masa
  pushMatrix();
  
  float tableWidth = (n + 5) * tileSize; 
  float tableHeight = (n + 3) * tileSize;
  
  translate((n * tileSize / 2) - tileSize, n * tileSize / 2, -20); 
  
  fill(110, 75, 45);
  noStroke();
  box(tableWidth, tableHeight, 30); 
  
  translate(0, 0, 15.1); 
  
  stroke(80, 50, 30);
  strokeWeight(2);
  for (float y = -tableHeight/2 + 20; y < tableHeight/2; y += 40) {
    line(-tableWidth/2, y, 0, tableWidth/2, y, 0);
  }
  
  noFill();
  stroke(60, 35, 15);
  strokeWeight(10);
  rectMode(CENTER);
  rect(0, 0, tableWidth - 10, tableHeight - 10);
  rectMode(CORNER);
  
  popMatrix();

  // tabla sah
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      pushMatrix();
      translate(i * tileSize + tileSize/2, j * tileSize + tileSize/2, 0);

      if ((i + j) % 2 == 0) fill(255); 
      else fill(30);  
      
      noStroke();
      box(tileSize, tileSize, 10); 
      popMatrix();
    }
  }
  
  for (int i = 0; i < n; i++) {
    pushMatrix();

    translate(-2 * tileSize + tileSize/2, i * tileSize + tileSize/2, 2); 
    rotateX(-PI/2);
    
    fill(70, 40, 20);
    noStroke();
    drawCylinder(24, tileSize * 0.4, tileSize * 0.45, 4);
    popMatrix();
  }
}

void drawCylinder(int sides, float r1, float r2, float h) {
  float angle = 360.0 / sides;
  
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0); 
  for (int i = 0; i <= sides; i++) {
    float x = cos(radians(i * angle)) * r1;
    float z = sin(radians(i * angle)) * r1;
    vertex(x, 0, z);
  }
  endShape();
  
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= sides; i++) {
    float x1 = cos(radians(i * angle)) * r1;
    float z1 = sin(radians(i * angle)) * r1;
    float x2 = cos(radians(i * angle)) * r2;
    float z2 = sin(radians(i * angle)) * r2;
    vertex(x1, 0, z1);
    vertex(x2, -h, z2);
  }
  endShape();
  
  beginShape(TRIANGLE_FAN);
  vertex(0, -h, 0); 
  for (int i = 0; i <= sides; i++) {
    float x = cos(radians(i * angle)) * r2;
    float z = sin(radians(i * angle)) * r2;
    vertex(x, -h, z);
  }
  endShape();
}
