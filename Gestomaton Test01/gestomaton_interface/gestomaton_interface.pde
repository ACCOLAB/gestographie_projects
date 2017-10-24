import processing.video.*;
int screen = 0;
int camPosX = 400;
int camPosY = 120;
int countdown = 30;
int seconds, startTime;
boolean startTimer = false;
String s1msg = "Pour démarrez, appuyer sur [A]";
String s2msgl1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String s2msgl2 = "Si vous êtes prêt, vous pouvez appuyer sur [OK]";

String time = "60";
int t;
int interval = 60;

Capture cam;

void setup() {
  size(1440, 900);
  background(255,255,255);
  
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
  background(255,255,255);
  fill(0);
  
  if(screen == 0) {
    s1();
  }
  if(screen == 1) {
    startTimer = true;
    s2();
  }
}
 
void keyPressed() {
  if (key == 'a') {
    screen = min(screen + 1, 1);
  }
}

void s1() {
  fill(0, 0, 0);
  text(s1msg, 270, 560);
}

void s2timer() {
  startTime = millis()/1000 + countdown;
  seconds = startTime - millis()/1000;
  if ((seconds < 0) && (startTimer = true)) { 
    startTime = millis()/1000 + countdown;
  } else {             
    fill(255, 255, 255);
    noStroke();
    rect(60, 60, 500, 60);
    fill(0, 0, 0);
    textSize(20);
    text("La photo va être prise dans " + seconds + " secondes", 80, 80);
  }
}

void s2timer2() {
    t = interval-int(millis()/1000);
    time = nf(t , 2);
    if(t == 0) {
      interval+=10;
    }
    text("La photo va être prise dans " + time + " secondes", 80, 80);
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

void s2message() {
  fill(0, 0, 0);
  text(s2msgl1, 270, 560);
  text(s2msgl2, 270, 590);
}

void s2() {
  if (startTimer = true) {
    s2timer2();
  }
  s2webcam();
  s2message();
}