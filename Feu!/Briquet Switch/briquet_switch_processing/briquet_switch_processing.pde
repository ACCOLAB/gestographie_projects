import processing.serial.*;
Serial myPort;   
 
int switchState;
boolean videoStart;
 
void setup() {
  size(100, 100);
  myPort = new Serial(this, Serial.list()[3], 9600); 
  // Important : se câler sur la valeur en baud du prog Arduino
  myPort.bufferUntil('\n');
}
  
void draw() {
  println(switchState);
  
  videoStart = false;
  background(255,0,0);
  
  if(switchState == 1) {
    videoStart = true;
  } 
  
  if(videoStart) {
    background(0,255,0);
  } 
}

void serialEvent (Serial myPort) { // récupère la valeur communiquée par l'Arduino
  
  String inString = myPort.readStringUntil('\n');
  
  if (inString != null){
    inString = trim(inString);
    int inputs[] = int(split(inString,','));
    switchState = inputs[0];
  }
}
