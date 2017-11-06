import processing.video.*;
import processing.sound.*;
//Valentin the best

//Camera
int screen = 0;
int camPosX = -(1440/2+640/2);
int camPosY = 120;
Capture cam;

//Audio
SoundFile photoTake;

//Message
String s1msg = "Pour démarrez, appuyer sur [A]";
String s2msg1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String s2msg2 = "Si vous êtes prêt, vous pouvez appuyer sur [Z]";
String s2msg3;
String s3msg = "Votre photo est prise ! Vous pouvez aller la récupérer à l'extérieur du gestomaton";

//Timer
boolean timerOver = false;
int timer;
int timerCurrent = 10;


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
    timer();
    s2();
  }
  if((timerOver) || (screen == 2)) {
    s3();
  }
}
 
void keyPressed() {
  if (key == 'a') {
    screen = min(screen + 1, 2);
  }
  if (key == 'z') {
    screen = min(screen + 1, 2);
  }
}

void s1() {
  fill(0, 0, 0);
  text(s1msg, 270, 560);
}

void s2() {
  background(255);
  
  // Image capture
  if (cam.available() == true) {
    cam.read();
  }
  pushMatrix();
  scale(-1, 1);
  image(cam, camPosX, camPosY, 640, 360);
  popMatrix();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(10);
  ellipse(width/2, 300, 200, 280);
  noStroke();
  fill(255, 0, 0);
  for(int i = 600; i<840; i+=10){
    ellipse (i, 280, 4, 4);  
  }
  
  // Message
  fill(0, 0, 0);
  text(s2msg1, 270, 560);
  text(s2msg2, 270, 590);
  text(s2msg3, 270, 50);
}

void timer() {
  if ((millis() - timer >= 1000)) {
    timerCurrent = timerCurrent - 1;
    println(timerCurrent);
    s2msg3 = "La photo sera prise dans "+ timerCurrent +" secondes";
    if (timerCurrent == 0) {
      timerOver = true;
    }
    timer = millis();
  }
}

void s3() {
  background(255);
  
  // Image capture
  if (cam.available() == true) {
    cam.stop();
  }
  pushMatrix();
  scale(-1, 1);
  image(cam, camPosX, camPosY, 640, 360);
  popMatrix();
  noFill();
  
  // Camera sound
  photoTake = new SoundFile(this, "camera.mp3");
  photoTake.play();
  noLoop();
  
  // Message
  fill(0, 0, 0);
  text(s3msg, 270, 560);
}