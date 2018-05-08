#include <ESP8266WiFi.h>
#include <WebSocketClient.h>

WebSocketClient webSocketClient;

const char* ssid = "Bbox-A5CA69"; //Nom du réseau
const char* pw = "15CDCE801A"; //Mot de passe du réseau
char* host = "192.168.1.8"; //Remplacer par l'adresse IPV4 du serveur NodeJS
const int port = 8080;
char path[] = "/";
void setup() {
  Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);//initialisation LED DEBUG
  digitalWrite(LED_BUILTIN, LOW);// allumer en PERMANENCE LED DEBUG (l'allumage se fait en voltage LOW
  WiFi.begin(ssid, pw);
  Serial.println("Connecting to AP");
  while(WiFi.status() != WL_CONNECTED){
    delay(500);
    Serial.print("."); 
   }
  Serial.println(" connected");
  Serial.println("L'adresse de l'arduino sur le réseau:");
  Serial.println(WiFi.localIP());

}


void loop() {
  WiFiClient client;  
  Serial.println("Connecting to host");
  if(!client.connect(host, port)){
    Serial.println("...connection failed!");
    Serial.println("Retrying in 5 seconds...");
    delay(5000);
    return;  
  }
  client.print("A");
  client.write("je suis connecté");
  //webSocketClient.sendData("3");
  Serial.println("...TCP message fired!");
  delay(2000);
  
  webSocketClient.path = "/";
  webSocketClient.host = "192.168.1.8";
  if (webSocketClient.handshake(client)) {
    Serial.println("Handshake successful");
  } else {
    Serial.println("Handshake failed.");
  }
  
}
