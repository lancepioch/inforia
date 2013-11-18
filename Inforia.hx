class Inforia {
	// Sample Code
	public static function main(){
		var gc = new GameController(new ToadsAndFrogsModel());
		gc.startNewGame();
		var server = new GameServer(gc);
	}
}