void drawUI() {
  hint(DISABLE_DEPTH_TEST); 
  textSize(16);
  noStroke();
  
  // info joc
  fill(0, 0, 0, 170); 
  rect(10, 10, 250, 130, 15); 
  
  fill(255, 220, 0);
  text("=== JOCUL REGINE 3D ===", 25, 35);
  fill(255);
  text("Mod curent: " + (isAutoMode ? "AUTOMAT" : "INTERACTIV"), 25, 65);
  text("Mutări: " + moveCount, 25, 85);
  text("N: " + n, 25, 105);
  
  // controale
  int rightPanelX = width - 370; 
  fill(0, 0, 0, 170);
  rect(rightPanelX, 10, 360, 200, 15); 
  
  fill(255, 220, 0);
  text("CONTROALE:", rightPanelX + 15, 35);
  fill(255);
  textSize(14); 
  text("Taste 5-9, 0: Schimbă dimensiunea N", rightPanelX + 15, 60);
  text("Tasta M: Mod Auto / Interactiv", rightPanelX + 15, 80);
  text("Tasta R: Resetează jocul", rightPanelX + 15, 100);
  text("Tasta Z: Ia ultima piesă înapoi (Undo)", rightPanelX + 15, 120); 
  text("Click Stânga: Selectează / Plasează / Scoate", rightPanelX + 15, 140);
  text("Hold Click Dreapta: Rotație liberă 3D", rightPanelX + 15, 160);
  text("Rotiță Mouse / (+ / -): Zoom", rightPanelX + 15, 180);
  text("Săgeți: Translație cameră plană", rightPanelX + 15, 200); 
  
  // mesaj reset
  if (millis() < messageTimer) {
    fill(50, 255, 50); 
    textSize(24);
    textAlign(CENTER);
    text(resetMessage, width / 2, 40); 
    textAlign(LEFT); 
  }
  
  // win & confetti
  if (gameWon) {
    fill(0, 0, 0, 150);
    rect(0, 0, width, height);
    
    textAlign(CENTER, CENTER); 
    
    if (!isAutoMode) {
      // win manual/interactiv
      fill(255, 220, 0); // Auriu
      textSize(70);
      text("NIVEL COMPLETAT!", width / 2, height / 2 - 40);
      
      fill(255);
      textSize(24);
      text("Ai plasat corect toate cele " + n + " regine!", width / 2, height / 2 + 30);
      text("Apasă Tasta 'R' sau o Cifră pentru a începe din nou.", width / 2, height / 2 + 70);
      
      for (Confetti c : confettis) {
        c.update();
        c.display();
      }
    } else {
      // win automat
      fill(100, 200, 255);
      textSize(60);
      text("COMPLETAT AUTOMAT", width / 2, height / 2 - 40);
      
      fill(255);
      textSize(24);
      text("Algoritmul a găsit o soluție pentru " + n + " regine.", width / 2, height / 2 + 30);
      text("Apasă Tasta 'M' pentru modul interactiv sau 'R' pentru a reseta.", width / 2, height / 2 + 70);
    }
    
    textAlign(LEFT, BASELINE);
  }
  
  hint(ENABLE_DEPTH_TEST); 
}
