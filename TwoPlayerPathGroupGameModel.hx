import GameModel;

class TwoPlayerPathGroupGameModel extends GameModel {
    private var state : Array<Array<Int>>; // Int[][]

    private function new() {
    	super();
		this.numberOfPlayers = 2;
		currentPlayer = 0;
		this.state = new Array<Array<Int>>();
	}

	private function isValidPathIndex(index : Int) : Bool {
		return index >= 0 && index < this.getPathCount();
	}

	private function isValidVertexIndex(pathIndex : Int, vertexIndex : Int) : Bool {
		return this.isValidPathIndex(pathIndex) && vertexIndex >= 0 && vertexIndex < this.getVertexCount(pathIndex);
	}

	private function hasLegalMoveAtVertex(pathIndex : Int, vertexIndex : Int) : Bool { // abstract
		return false;
	}

	public function getAllVertexCounts() : Array<Int> {
		var vertexCountInPath = new Array<Int>(); // this.getPathCount());
		for (i in 0...this.getPathCount())
			vertexCountInPath[i] = this.getVertexCount(i);
		return vertexCountInPath;
	}

	public override function startNewGame() : Void {
		this.state = new Array<Array<Int>>(); // vertexCountInPath.length
		for (i in 0...this.getPathCount())
			this.state[i] = new Array<Int>(); // vertexCountInPath[i]);
		this.currentPlayer = 0;
	}

	public override function doesCurrentPlayerHaveLegalMove() : Bool {
		for (i in 0...this.getPathCount())
			for (j in 0...this.getVertexCount(i))
				if (this.hasLegalMoveAtVertex(i, j))
					return true;
		return false;
	}

	public function getVertexCount(index : Int = 0) : Int {
		if (this.isValidPathIndex(index))
			return this.state[index].length;
		return -1;
	}

	public function getPathCount() : Int {
		return this.state.length;
	}

	private function setVertexState(pathIndex : Int, vertexIndex : Int, newState : Int) : Bool {
		if (!this.isValidVertexIndex(pathIndex, vertexIndex))
			return false;
		this.state[pathIndex][vertexIndex] = newState;
		return true;
	}

	public function getVertexState(pathIndex : Int = 0, vertexIndex : Int) : Int {
		if (!this.isValidVertexIndex(pathIndex, vertexIndex))
			return -1;
		return this.state[pathIndex][vertexIndex];
	}

	public override function equals(other : Dynamic) : Bool {
		if (Type.typeof(this) != Type.typeof(other))
			return false;
		var otherGame : TwoPlayerPathGroupGameModel = cast(other, TwoPlayerPathGroupGameModel);
		return this.getCurrentPlayer() == otherGame.getCurrentPlayer(); // && this.state.equals(otherGame.state);
	}

	public function toStringHelper(prefix : String = "", displayPathNumber : Bool = false) : String {
		var stringBuffer = new StringBuf();

		stringBuffer.add(prefix);
		for (i in 0...this.getPathCount()){
			if (displayPathNumber){
				stringBuffer.add("path ");
				stringBuffer.add(i);
				stringBuffer.add(":");
			}
			for (j in 0...this.getVertexCount(i)){
				stringBuffer.add(" ");
				stringBuffer.add(this.getVertexState(i, j));
			}
			stringBuffer.add("\n");
		}
		stringBuffer.add("Current Player: ");
		stringBuffer.add(this.getCurrentPlayer());
		stringBuffer.add("\n");
		return stringBuffer.toString();
	}

	public override function toString() : String {
		return this.toStringHelper("TwoPlayerPathGroupGameModel", true);
	}

}