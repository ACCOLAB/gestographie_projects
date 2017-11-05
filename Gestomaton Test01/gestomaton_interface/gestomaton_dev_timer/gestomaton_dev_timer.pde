boolean processingTimer = false;
int currentTime;
int timerLenght = 5;
int startTimer;
int endTimer;

void setup() {
  size(500, 500);
  background(255,255,255);
}

void draw() {
  currentTime = int(millis()/1000);

  if ((processingTimer) && (currentTime == endTimer)) {
    println("Oké");
  }
}
 
void keyPressed() {
  if (key == 'a') {
    processingTimer = true;
    startTimer = int(millis()/1000);
    endTimer = startTimer + timerLenght;
    println("end : "+endTimer);
  }
}