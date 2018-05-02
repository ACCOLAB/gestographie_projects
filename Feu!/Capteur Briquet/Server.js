var http = require('http');
var io = require("socket.io")(http);
//var WebSocketServer = require('websocket').server;*/
var server = http.createServer();


console.log('message de démarrage console');
server.on('request',function(request, response){
	console.log("il y a eu une requête");
	response.writeHead(200,{
		'Content-type': 'text/html; charset=utf-8'
	});
	response.end('<h1>salut, comment ça va ?</h1>');
	console.log("serveur lancé");
})

//Identifier quand quelqu'un se connecte et se déconnecte
io.on('connection', function(socket){
  console.log('a user connected');
  socket.on('disconnect', function(){
    console.log('user disconnected');
  });
});

//Écrire un message reçu dans la console
io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    console.log('message: ' + msg);
  });
});


server.listen(8080);
