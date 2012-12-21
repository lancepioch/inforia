class GameModel {
    private var numberOfPlayers : Int;
    private var currentPlayer : Int;

	private function new() : Void {
		numberOfPlayers = 2;
		currentPlayer = 0;
	}

	public function getNumberOfPlayers() : Int {
		return this.numberOfPlayers;
	}

	public function getCurrentPlayer() : Int {
		return this.currentPlayer;
	}

	private function getNextPlayer() : Int {
		var nextPlayer = this.currentPlayer + 1;
		if (nextPlayer > this.numberOfPlayers - 1)
			nextPlayer = 0;
		return nextPlayer;
	}

	private function doesCurrentPlayerHaveLegalMove() : Bool {
		return false;
	}

	public function switchToNextTurn() : Void {
		this.currentPlayer = this.getNextPlayer();
	}
	
	public function getGameName() : String {
		return this.toString();
	}

	public function toString() : String {
		return "GameModel";
	}

	public function equals(other : Dynamic) : Bool {
		return Type.typeof(this) == Type.typeof(other);
	}

	// public function getNewGamePanel(controller : GameController) : GamePanel<?>;
	// public function loadAndContinueSavedGame(savedGameFile : File) : Void;
	// public function saveCurrentProgress(saveFile : File) : Void;
	
    /* public function accept(visitor : GameVisitor) : Void {
        visitor.visit(this);
    } // */
}