var http = require('http');

var server = http.createServer();

server.on('request',function(request, response){
	console.log("il y a eu une requête");
	response.writeHead(200,{
		'Content-type': 'text/html; charset=utf-8'
	});
	response.end('<h1>ok</h1>');
})

server.listen(8080);
