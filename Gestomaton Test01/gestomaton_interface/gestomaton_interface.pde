import processing.video.*;
int camPosX = 400;
int camPosY = 120;
int countdown = 30;
int seconds, startTime;
String txtSc2line1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String txtSc2line2 = "Quand vous êtes prêt, vous pouvez appuyer sur [OK]";

Capture cam;

void setup() {
  size(1440, 900);
  background(255,255,255);
  startTime = millis()/1000 + countdown;
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
  smooth();
}

void draw() {
  s2();
}

void s2() {
  s2webcam();
  s2timer();
  s2message();
}

void s2webcam() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, camPosX, camPosY, 640, 360);
  noFill();
  stroke(255, 0, 0);
  strokeWeight(10);
  ellipse(width/2, 300, 200, 280);
  noStroke();
  fill(255, 0, 0);
  for(int i = 600; i<840; i+=10){
    ellipse (i, 280, 4, 4);  
  }
}

void s2timer() {
  seconds = startTime - millis()/1000;
  if (seconds < 0) { 
    startTime = millis()/1000 + countdown;
  } else {             
    fill(255, 255, 255);
    noStroke();
    rect(60, 60, 500, 60);
    fill(0, 0, 0);
    textSize(20);
  }
  
  if (seconds == 0) {
    noLoop();
  } 
}

void s2message() {
  text("La photo va être prise dans " + seconds + " secondes", 80, 80);
  text(txtSc2line1, 270, 560);
  text(txtSc2line2, 270, 590);
  noLoop();
}