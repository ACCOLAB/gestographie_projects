# Briquet Switch

A button connected to an Arduino board sends data to a Processing sketch. This sketch is connected to Resolume.

## Arduino 

![](https://www.arduino.cc/en/uploads/Tutorial/button.png)

Hardware required :
- Arduino or Genuino Board
- Momentary button or switch
- 10k ohm resistor
- Wires


## Processing to Resolume

Ce code permet de contrôler un logiciel video (Résolume) grâce à Processing via du MIDI. L'idée est de récupérer les données Arduino, les traiter via ce code dans Processing, puis d'envoyer des notes MIDI à Résolume pour switcher proprement de vidéo.

Pour que ça fonctionne, il est nécessaire de paramétrer Resolume sur le bon port d'entré MIDI et de bien mapper les videos

```
import themidibus.*;

MidiBus bus;
int velocity;
int note;

int timer_briq=0;
int timer_allu=0;

boolean playvideo_briq=false;
boolean playvideo_allu=false;

void setup()
{
  size(256, 256);
  background(0);

  //list the available MIDI devices
  MidiBus.list(); 

  //logiciels LOOPBE ou LOOPMIDI pour émuler un port MIDI virtuel sur PC
  // émulation d'un port MIDI virtuel sur mac dans utilitaire 
  // (voir https://www.youtube.com/watch?v=MK4hrjfJEX4 ) 
  // sélection du MIDI IN et MIDI OUT
  bus= new MidiBus(this, 0, 1);
}

void draw(){
  
  //start manuel des video 
  // remplacer le  "if key" par "if signal arduino > x..."
  if (keyPressed) {
    if (key == 'a'){
      // channel (-1 avec Resolume) / note / velocity (apparait pas dans Resolume)
      bus.sendNoteOn(0, 1, 1);
     
    }
    if (key == 'b'){
      bus.sendNoteOn(0, 2, 1); 
      playvideo_briq=true;
    }
    if (key == 'c'){
      bus.sendNoteOn(0, 3, 1); 
      playvideo_allu=true;
    }
  }
  
  //switch auto des video quand elles arrivent a la fin (video 2 to video 1 OU video 3 to video 1)
  
  // POUR VIDEO BRIQUET
  if(playvideo_briq==true){
    timer_briq++;
  }
  if(timer_briq>=200){
    timer_briq=0;
    playvideo_briq=false;
    bus.sendNoteOn(0, 1, 1);
  }
  
  // POUR VIDEO ALLUMETTE
  if(playvideo_allu==true){
    timer_allu++;
  }
  if(timer_allu>=200){
    timer_allu=0;
    playvideo_allu=false;
    bus.sendNoteOn(0, 1, 1);
  }
  
  
  //println(frameRate);
  println(timer_briq);
  println(timer_allu);
}
```
