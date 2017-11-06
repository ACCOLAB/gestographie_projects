boolean processingTimer = false;
int timer;
int displayTime = 10;

void setup() {
  size(100, 100);
  background(255,255,255);
}

void draw() {
  if ((processingTimer) && (millis() - timer >= 1000)) {
    displayTime = displayTime - 1;
    println(displayTime);
    if (displayTime == 0) {
      println("Oki");
    }
    timer = millis();
  }
}

void keyPressed() {
  if (key == 'a') {
    processingTimer = true;
  }
}