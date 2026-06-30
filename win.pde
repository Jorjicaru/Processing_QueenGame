class Confetti {
  float x, y;
  float speedX, speedY;
  color c;
  float size;
  float rot, rotSpeed;
  
  Confetti() {
    x = random(width);
    y = random(-800, -50); 
    speedX = random(-2, 2);
    speedY = random(3, 8);
    size = random(8, 16);
    rot = random(TWO_PI);
    rotSpeed = random(-0.1, 0.2);
    
    c = color(random(100, 255), random(100, 255), random(100, 255));
  }
  
  void update() {
    x += speedX;
    y += speedY;
    rot += rotSpeed;
    

    speedX += random(-0.2, 0.2);
    
    if (y > height + 20) {
      y = random(-200, -50);
      x = random(width);
      speedX = random(-2, 2);
    }
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rot);
    fill(c);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, size, size * 0.6);
    rectMode(CORNER);
    popMatrix();
  }
}
