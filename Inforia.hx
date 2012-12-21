import js.Node;
import ToadsAndFrogsModel;

class Inforia {
	public static function main(){
		var gm = new ToadsAndFrogsModel();
		var server = Node.http.createServer (
			function(req : NodeHttpServerReq, res : NodeHttpServerResp) {
				res.setHeader("Content-Type","text/plain");
				res.writeHead(200);
				res.end(gm.toString());
			}
		);

		server.listen(1337, "localhost");
		trace('Server running at http://127.0.0.1:1337/');
	}
}