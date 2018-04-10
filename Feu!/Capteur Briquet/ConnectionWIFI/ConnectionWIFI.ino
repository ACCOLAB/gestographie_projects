#include <ESP8266WiFi.h>

const char* ssid = "Bbox-A5CA69";
const char* pw = "15CDCE801A";
const char* host = "192.168.1.26";
const int port = 8080;

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, pw);
  Serial.println("Connecting to AP");
  while(WiFi.status() != WL_CONNECTED){
    delay(500);
    Serial.print("."); 
   }
  Serial.println(" connected");
  Serial.println("L'adresse de l'arduino");
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
  Serial.println("...TCP message fired!");
  delay(2000);
}
