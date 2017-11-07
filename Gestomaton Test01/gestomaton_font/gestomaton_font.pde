//Font
PFont font;

String s1msg = "Pour commencer, appuyer sur";
String s2msg1 = "Réglez votre siège de sorte à placer votre visage dans le repère";
String s2msg2 = "Si vous êtes prêt, vous pouvez appuyer sur [Z]";
String s2msg3;
String s3msg = "Votre photo est prise ! Vous pouvez aller la récupérer à l'extérieur du gestomaton";

void setup() {
  size(1440, 900);
  background(255,255,255);
  
  //Setting font
  font = createFont("OpenSans-Regular.ttf", 32);
  
  smooth();
}

void draw() {
  background(255);
  fill(0);
  textFont(font, 32);
  text(s1msg, 325, 430);
  
  fill(242,0,35);
  noStroke();
  rect(800, 375, 126, 84);
  
  fill(255);
  textFont(font, 32);
  text("OK", 835, 430);
}