void handleAutoMode() {
  if (millis() - lastMoveTime > moveDelay && autoRow < n) {
    boolean moved = false;
    while (!moved && autoRow >= 0 && autoRow < n) {
      autoBoard[autoRow]++;
      
      if (autoBoard[autoRow] >= n) {
        autoBoard[autoRow] = -1;
        queens.get(autoRow).setTarget(-2, autoRow); 
        autoRow--;
        moveCount++;
        moved = true;
      } else if (isValidAuto(autoRow, autoBoard[autoRow])) {
        queens.get(autoRow).setTarget(autoBoard[autoRow], autoRow);
        moveCount++;
        autoRow++;
        moved = true;
      } else {
         queens.get(autoRow).setTarget(autoBoard[autoRow], autoRow);
         moveCount++;
         moved = true; 
      }
    }
    lastMoveTime = millis();
  }
}

boolean isValidAuto(int r, int c) {
  for (int i = 0; i < r; i++) {
    if (autoBoard[i] == c || Math.abs(i - r) == Math.abs(autoBoard[i] - c)) {
      return false;
    }
  }
  return true;
}
