# Le projet

L'idée du projet est de créer un capteur de type bouton à insérer au coeur d'un briquet. Le bouton est relayé à un arduino ESP8266-01 qui permet d'envoyer par réseau l'événement "le bouton a été appuryé".

# Communication Réseau

Un serveur central Node.js permet de faire le lien entre, d'un côté le déclencheur (arduino esp8266-01) et le lecteur vidéo (géré par processing et resolume)

Piste à explorer pour la communication réseau :

OSC,

Websocket (utilisé dans le projet Totem)

# Comment intégrer l'arduino dans le briquet

![](https://github.com/ACCOLAB/Gestographie/blob/master/Feu!/Capteur%20Briquet/Archives_Images/Briquet%20Coupe.jpg)
