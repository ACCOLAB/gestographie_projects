import processing.video.*;
import processing.sound.*;

// Camera
int screen = 0;
int camPosX = -(1440/2+640/2);
int camPosY = 120;
Capture cam;

// Audio
SoundFile photoTake;

// Message
String s1msg = "Pour commencer, appuyer sur";
String s2msg1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String s2msg2;
String s2msg3 = "Si vous êtes prêt, vous pouvez appuyer sur";
String s3msg1 = "Votre photo est prise !";
String s3msg2 = "Vous pouvez aller la récupérer à l'extérieur du Gestomaton";

// Timer
boolean timerOver = false;
int timer;
int timerCurrent = 60;

// Font
PFont font;


void setup() {
  size(1440, 900);
  //fullScreen();
  background(255);
  
  // Setting the webcam
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
  
  // Setting font
  font = createFont("OpenSans-Regular.ttf", 32);
  
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
  // Message
  background(255);
  fill(0);
  textFont(font, 45);
  text(s1msg, 325, 430);
  
  // OK button
  fill(242,0,35);
  noStroke();
  rect(988, 375, 126, 84);
  fill(255);
  textFont(font, 40);
  text("OK", 1017, 430);
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
  fill(0);
  textFont(font, 37);
  text(s2msg1, 180, 577);
  text(s2msg2, 195, 672);
  text(s2msg3, 297, 730);
  
  // OK button
  fill(37,177,239);
  noStroke();
  rect(1048, 690, 94, 63);
  fill(255);
  textFont(font, 33);
  text("OK", 1070, 731);
  
  // Image cropping
  fill(255);
  noStroke();
  rect(400, 120, 180, 360);
  rect(860, 120, 180, 360);
}

void timer() {
  if ((millis() - timer >= 1000)) {
    timerCurrent = timerCurrent - 1;
    
    fill(0);
    textFont(font, 37);
    s2msg2 = "Si vous ne faites rien, votre photo sera prise dans "+ timerCurrent +" secondes";
    
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
  textFont(font, 37);
  text(s3msg1, 512, 576);
  text(s3msg2, 260, 633);
  
  // Image cropping
  fill(255);
  noStroke();
  rect(400, 120, 180, 360);
  rect(860, 120, 180, 360);
}