int n = 8; 
float tileSize = 50; 
int moveCount = 0;

// transformari 3D
float rotX = PI/4, rotY = 0, rotZ = 0;
float transX = 0, transY = 0, transZ = 0;
float scaleF = 1.0;

// setari
boolean isAutoMode = false;
ArrayList<Queen> queens;
int selectedQueenIndex = -1;

// automat
int[] autoBoard; 
int autoRow = 0;
int lastMoveTime = 0;
int moveDelay = 500;

String resetMessage = "";
int messageTimer = 0;

boolean gameWon = false;
ArrayList<Confetti> confettis = new ArrayList<Confetti>();

void setup() {
  size(1200, 800, P3D); 
  
  surface.setLocation((displayWidth - width) / 2, (displayHeight - height) / 2);
  
  transX = width / 2;
  transY = (height / 2) + 30; 
  
  initGame();
}

void initGame() {
  queens = new ArrayList<Queen>();
  moveCount = 0;
  
  gameWon = false;
  confettis.clear();
  
  for (int i = 0; i < n; i++) {
    queens.add(new Queen(-2, i)); 
  }
  
  autoBoard = new int[n];
  for(int i=0; i<n; i++) autoBoard[i] = -1;
  autoRow = 0;
}

void draw() {
  background(100);
  lights(); 
  
  if (isAutoMode) {
    handleAutoMode();
  }
  
  pushMatrix();
  translate(transX, transY, transZ);
  scale(scaleF);
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  translate(-n * tileSize / 2, -n * tileSize / 2, 0);
  
  drawBoard();
  
  for (int i = 0; i < queens.size(); i++) {
    queens.get(i).update();
    queens.get(i).display(i == selectedQueenIndex);
  }
  
  popMatrix();
  
  checkWinCondition();
  
  drawUI(); 
}

void checkWinCondition() {
  if (gameWon) return;
  
  int placedCount = 0;
  boolean anyConflict = false;
  
  for (Queen q : queens) {
    if (q.gridX >= 0) placedCount++;
    if (q.isConflicting) anyConflict = true;
  }
  
  if (placedCount == n && !anyConflict) {
    gameWon = true;
    
    if (!isAutoMode) {
      for (int i = 0; i < 300; i++) {
        confettis.add(new Confetti());
      }
    }
  }
}
