# Le projet

L'idée du projet est de créer un capteur de type bouton à insérer au coeur d'un briquet. Le bouton est relayé à un arduino ESP8266-01 qui permet d'envoyer par réseau l'événement "le bouton a été appuryé".

# Le matériel
Un **esp8266-01**

https://www.amazon.fr/gp/product/B06XJVX9G7/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1
![](https://jpralves.net/img/mcb/esp_pinout_55.png)

Un **adaptateur USB**

https://www.amazon.fr/gp/product/B077Z4L8DD/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1

L'ensemble étant assemblé de cette manière

![](https://i.pinimg.com/originals/ce/3e/0b/ce3e0ba31f28c2d312614c087a0d944b.jpg)

# Communication Réseau

Un serveur central Node.js permet de faire le lien entre, d'un côté le déclencheur (arduino esp8266-01) et le lecteur vidéo (géré par processing et resolume)

Piste à explorer pour la communication réseau :

OSC,

Websocket (utilisé dans le projet Totem)

# Comment intégrer l'arduino dans le briquet
**ATTENTION !** 
À l'étape de découpe du briquet, faire attention. Si le briquet n'est pas entiérement vide, la découpe du boitier entraine une petite explosion de gaz sous pression. 
![](https://github.com/ACCOLAB/Gestographie/blob/master/Feu!/Capteur%20Briquet/Archives_Images/Briquet%20Coupe.jpg)

**Modèle 3D**
Le lien après est un lien vers le modèle 3D du boitier de briquet à imprimer. Sur Onshape, il peut être modifiable directement sur le logiciel.
https://cad.onshape.com/documents/e3a519272aa943a477717af4/w/0d420bd723d1671b3431d051/e/b1c039a791d6e8db9fc0c773
