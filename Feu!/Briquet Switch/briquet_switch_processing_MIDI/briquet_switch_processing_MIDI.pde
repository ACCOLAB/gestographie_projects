import processing.serial.*;
Serial myPort;   
 
// pour MIDI
import themidibus.*;

MidiBus bus;
int velocity;
int note;

int timer_briq=0;
int timer_allu=0;

boolean playvideo_briq=false;
boolean playvideo_allu=false;
 
// pour briquet 
int switchState;
boolean play_midi_briquet=false;

// timer briquet
boolean timerBriqOver = false;
int timerBriq;
// remplacer cette valeur par la durée de la video
int timerBriqCurrent = 5;

boolean play_video_base=true;

//boolean switchVideoBase=true;
 
void setup() {
  size(100, 100);
  myPort = new Serial(this, Serial.list()[3], 9600); 
  // Important : se câler sur la valeur en baud du prog Arduino
  myPort.bufferUntil('\n');
  
    //list the available MIDI devices
  MidiBus.list(); 

  //logiciels LOOPBE ou LOOPMIDI pour émuler un port MIDI virtuel sur PC
  // émulation d'un port MIDI virtuel sur mac dans utilitaire 
  // (voir https://www.youtube.com/watch?v=MK4hrjfJEX4 ) 
  // sélection du MIDI IN et MIDI OUT
  bus= new MidiBus(this, 0, 1);
}
  
void draw() {
  //println(switchState);
 //start manuel des video 
  // remplacer le  "if key" par "if signal arduino > x..."
  //if (keyPressed) {
    
    if (play_video_base==true){
      // channel (-1 avec Resolume) / note / velocity (apparait pas dans Resolume)
      
      bus.sendNoteOn(0, 1, 1);
      println("video-base"); 
      play_video_base=false;
    }
    
    if (switchState==1 && play_midi_briquet==false){
      bus.sendNoteOn(0, 2, 1); 
      playvideo_briq=true;
      println("video-briquet");
      play_midi_briquet=true;
    }
    if (key == 'c'){
      bus.sendNoteOn(0, 3, 1); 
      playvideo_allu=true;
      println("video-allumette");
    }
 
   
   /*
   if(play_midi_briquet==true){
     timer_briquet++;
     if(timer_briquet>=100){
       timer_briquet=0;
       play_midi_briquet=false;
     }
   }
 */
 
 
if(play_midi_briquet==true){

 if ((millis() - timerBriq >= 1000)) {
    timerBriqCurrent = timerBriqCurrent - 1;
   
    timerBriq = millis();
    
    // ici j'assigne ce que je veux activer quand le timer atteint la limitte
    // !!!! Remplacer le "5" de timerBriqCurrent par la durée de la video
    if ((timerBriqCurrent == 0)) {
       timerBriqCurrent=5;
       play_midi_briquet=false; 
       play_video_base=true;
    }
  }
 
 }
 
 //println(timerBriqCurrent);
}

void serialEvent (Serial myPort) { // récupère la valeur communiquée par l'Arduino
  
  String inString = myPort.readStringUntil('\n');
  
  if (inString != null){
    inString = trim(inString);
    int inputs[] = int(split(inString,','));
    switchState = inputs[0];
  }
}
