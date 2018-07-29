import processing.video.*;
import processing.sound.*;

// Camera
int screen = 0;
int camPosX = -(1440/2+640/2);
int camPosY = 120;
Capture cam;

// Audio
SoundFile photoTake;
SoundFile feedback;
boolean feedback1Playing = false;
boolean feedback2Playing = false;
boolean photoTakePlaying = false;

// Message
String s1msg = "Pour commencer, appuyer sur le bouton rouge";
String s2msg1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String s2msg2;
String s3msg1 = "Votre photo est prise !";
String s3msg2 = "Vous pouvez aller la récupérer à l'extérieur du photomaton";

// timer Screen 2
boolean timerSc2Over = false;
int timerSc2;
int timerSc2Current = 30;

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
  
  photoTake = new SoundFile(this, "camera.mp3");
  feedback = new SoundFile(this, "feedback.mp3");
  smooth();
}

void draw() {
  background(255,255,255);
  fill(0);
  
  if(screen == 0) {
    s1();
  }
  if(screen == 1) {
    timer2();
    s2();
  }
  if(screen == 2) {
    s3();
  }
}
 
void keyPressed() {
  if(key == '0') {
    screen = 1;
  }
  if(key == 'a'){
    screen = 0;
  }
}

void s1() {
  // Message
  background(255);
  fill(0);
  textFont(font, 45);
  text(s1msg, 200, 430);
  
  // OK button
  fill(242,0,35);
  noStroke();
  rect(width/2, 500, 126, 84);
  //fill(255);
  //textFont(font, 40);
  //text("OK", 1017, 430);
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
  strokeWeight(7);
  ellipse(width/2, 280, 100, 130);
  noStroke();
  fill(255, 0, 0);
  for(int i = 650; i<800; i+=10){
    ellipse (i, 270, 4, 4);  
  }
  
  // Camera sound
  if (!feedback1Playing) {
    feedback.play();
    feedback1Playing = true;
  }
  
  // Image cropping
  fill(255);
  noStroke();
  rect(400, 120, 180, 360);
  rect(860, 120, 180, 360);
  
  // Messages
  fill(0);
  textFont(font, 37);
  text(s2msg1, 180, 577);
  text(s2msg2, 297, 672);
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
  if (!photoTakePlaying) {
    photoTake.play();
    photoTakePlaying = true;
  }
  
  // Image cropping
  fill(255);
  noStroke();
  rect(400, 120, 180, 360);
  rect(860, 120, 180, 360);
  
  // Message Please wait
  fill(0, 0, 0);
  textFont(font, 37);
  text(s3msg1, 512, 618);
  text(s3msg2, 258, 675);
}

void timer2() {
  if ((millis() - timerSc2 >= 1000)) {
    timerSc2Current = timerSc2Current - 1;
    
    fill(0);
    textFont(font, 37);
    s2msg2 = "Il reste "+ timerSc2Current +" secondes avant la prise de votre photo";
    
    if (timerSc2Current == 0) {
      screen = min(screen + 1, 2);
    }
    timerSc2 = millis();
    
    // Camera sound
    if ((timerSc2Current == 8) && (!feedback2Playing)) {
      feedback.play();
      feedback2Playing = true;
    }
  }
}