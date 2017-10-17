import processing.video.*;
int camPosX = 400;
int camPosY = 120;

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