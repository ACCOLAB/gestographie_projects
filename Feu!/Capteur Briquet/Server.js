var http = require('http');
console.log("Serveur Lancé");


var server = http.createServer(function(req, res) {

  res.writeHead(200);
  res.end('Salut tout le monde !');

});

server.listen(8080);
