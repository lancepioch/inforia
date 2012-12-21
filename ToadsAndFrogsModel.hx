import TwoPlayerPathGameModel;
import Std;

class ToadsAndFrogsModel extends TwoPlayerPathGameModel {
	/*
	 * Player description: Player 0 (Left) - Toads; Player 1 (Right) - Frogs.
	 * Vertex State description: 0 - Empty; 1 - Toad; 2 - Frog.
	 */

	private var DELTA : Array<Int>;

	private static var DEFAULT_RANDOM_BOX_COUNT_RANGE = 7;
	private static var DEFAULT_MIN_BOX_COUNT = 8;
	private static var POSSIBLE_STATES_COUNT = 3;

    public function new() {
    	super();
		this.DELTA = [1, -1];
	}

	public override function startNewGame() : Void {
		// int boxCount = randomNumberGenerator.nextInt(DEFAULT_RANDOM_BOX_COUNT_RANGE) + DEFAULT_MIN_BOX_COUNT;
		var boxCount = Std.random(DEFAULT_RANDOM_BOX_COUNT_RANGE) + DEFAULT_MIN_BOX_COUNT;
		var initialState = new Array<Int>();
		initialState[0] = 1;
		initialState[1] = 0; // temp fix
		initialState[boxCount - 1] = 2;
		initialState[boxCount - 2] = 0; // temp fix
		
		for (i in 2...boxCount-2) // for (int i = 2; i < boxCount - 2; i++)
			initialState[i] = Std.random(POSSIBLE_STATES_COUNT); // initialState[i] = randomNumberGenerator.nextInt(POSSIBLE_STATES_COUNT);
		super.loadNewGame(initialState);
	}

	private function getMoveDestination(index : Int) {
		if (!this.isValidIndex(index) || this.getIndexState(index) != this.getCurrentPlayer() + 1)
			return -1;
		var destinationIndex = 0 + index + DELTA[this.getCurrentPlayer()];
		if (!this.isValidIndex(destinationIndex))
			return -1;
		if (this.isEmptyState(destinationIndex)){
			return destinationIndex;
		}
		else if (this.getIndexState(destinationIndex) == this.getCurrentPlayer() + 1){
			return -1;
		}
		else {
			destinationIndex += DELTA[this.getCurrentPlayer()];
			if (!this.isValidIndex(destinationIndex) || !this.isEmptyState(destinationIndex))
				return -1;
			return destinationIndex;
		}
	}

	public override function hasLegalMoveAtIndex(index : Int) : Bool {
		return this.isValidIndex(this.getMoveDestination(index));
	}

	public function makeMove(index : Int) : Bool {
		if (!this.hasLegalMoveAtIndex(index))
			return false;
		this.setIndexState(this.getMoveDestination(index), this.getCurrentPlayer() + 1);
		this.setIndexState(index, 0);
		return true;
	}

	private function isEmptyState(index : Int) : Bool {
		return this.isValidIndex(index) && this.getIndexState(index) == 0;
	}

	/*public override function getNewGamePanel(controller : GameController) : GamePanel<?> {
		return new ToadsAndFrogsPanel(this, controller);
	}//*/

	public override function toString() : String {
		return this.toStringHelper("ToadAndFrog Game State:", false);
	}

	public override function getGameName() : String {
		return "Toads and Frogs";
	}
}