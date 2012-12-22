import js.Node;
// import js.node.SocketIo;
// import js.node.SocketIoClient;
import GameController;
import ToadsAndFrogsModel;
import Common;
import Std;

class Inforia {
	public static function main(){
		var gm = new ToadsAndFrogsModel();
		var gc = new GameController(gm);
		gc.startNewGame();

		var app = Node.http.createServer (
			function(req : NodeHttpServerReq, res : NodeHttpServerResp) {
				var url_parts = Node.url.parse(req.url, true);
				var query = url_parts.query;

				if (query.newgame == "true")
					gm = new ToadsAndFrogsModel();

				if (query.move >= 0){
					var moves = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
					if (gm.makeMove(moves[query.move])){
						gc.gameMoveMade();
						trace('Successful Move');
					}
					else {
						trace('Move not made...');
					}
				}
				
				res.setHeader("Content-Type", "text/plain");
				res.writeHead(200);
				res.end(gm.toString());
			}
		);

		var io : SocketIO = Node.require('./socket.io').listen(8008);

		// wrap socket.io with basic identification and message queueing
		// code is in lib/socket_manager.js
		//var socket_managerB : SocketManagerBuilder = Node.require("socket_manager");
		//var socket_manager = socket_managerB.create(io);

		var chat = io.sockets.on('connection', function (socket : Socket) {
			socket.emit('news', { hello: 'world' });
			// chat.emit('a message', { everyone: 'in', '/chat': 'will get' });
		});

		/*/ use xhr-polling as the transport for socket.io
		io.configure(function () {
			io.set('transports', ['xhr-polling']);
			io.set('polling duration', 10);
		}); //
		var ws = SocketIo.listen(80);
		ws.of(SocketNamespace).on('connection',
			function (socket : SocketNamespace) {
				socket.on('set nickname',
					function (name) {
						socket.set('nickname', name,
							function () {
								socket.emit('ready');
							}
						);
					}
				);
				socket.on('msg',
					function () {
						socket.get('nickname',
							function (err, name) {
								console.log('Chat message by ', name);
							}
						);
					}
				);
			}
		);

		/*var ws = SocketIo.listen(80);
		ws.sockets.on('connection',
			function (socket : SocketNamespace) {
				socket.on('set nickname',
					function (name) {
						socket.set('nickname', name,
							function () {
								socket.emit('ready');
							}
						);
					}
				);
				socket.on('msg',
					function () {
						socket.get('nickname',
							function (err, name) {
								console.log('Chat message by ', name);
							}
						);
					}
				);
			}
		); // */

		app.listen(1337, "localhost");
		trace('Server running at http://127.0.0.1:1337/');
	}
}