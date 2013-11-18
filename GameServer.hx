import js.Node;
import Common;

class GameServer {
	private var server : NodeHttpServer;
	private var controller : GameController;
	private var socket : SocketIO;

	public function new(gameController : GameController) {
		this.controller = gameController;
		this.start();
	}

	public function start() {
		this.server = Node.http.createServer(this.handler);
		this.socket = Node.require('socket.io').listen(8008);

		// Test Message
		var chat : Dynamic = this.socket.sockets.on('connection', function (socket : Socket) { socket.emit('news', { hello: 'world' }); });

		this.server.listen(1337, "localhost");
		trace('Server running at http://127.0.0.1:1337/');
	}

	private function handler(req : NodeHttpServerReq, res : NodeHttpServerResp) {
		var url_parts = Node.url.parse(req.url, true);
		var query = url_parts.query;

		if (query.newgame == "true")
			this.controller.startNewGame();

		/*if (query.move >= 0){
			var moves = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
			if (gm.makeMove(moves[query.move])){
				this.controller.gameMoveMade();
				trace('Successful Move');
			}
			else {
				trace('Move not made...');
			}
		}*/
		
		res.setHeader("Content-Type", "text/plain");
		res.writeHead(200);
		res.end(this.controller.toString());
	}
}