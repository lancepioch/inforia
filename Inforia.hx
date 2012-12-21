import js.Node;
import GameController;
import ToadsAndFrogsModel;

class Inforia {
	public static function main(){
		var gm = new ToadsAndFrogsModel();
		var gc = new GameController(gm);
		gc.startNewGame();

		var server = Node.http.createServer (
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

		server.listen(1337, "localhost");
		trace('Server running at http://127.0.0.1:1337/');
	}
}