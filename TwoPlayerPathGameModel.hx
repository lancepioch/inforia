import TwoPlayerPathGroupGameModel;

class TwoPlayerPathGameModel extends TwoPlayerPathGroupGameModel {
	public function new() {
    	super();
		this.state.push(new Array<Int>());
	}

	private function isValidIndex(index : Int) : Bool  {
		return super.isValidVertexIndex(0, index);
	}

	public function getIndexState(index : Int) : Int {
		return super.getVertexState(0, index);
	}

	private function setIndexState(index : Int, newState : Int) : Bool  { // setVertexState
		if (!this.isValidIndex(index))
			return false;
		this.state[0][index] = newState;
		return true;
	}

	private function hasLegalMoveAtIndex(index : Int) : Bool { // abstract
		return hasLegalMoveAtVertex(0, index);
	}

	public function loadNewGame(state : Array<Int>) : Void {
		this.state = new Array<Array<Int>>(); // this.state = new int[1][state.length];
		// System.arraycopy(state, 0, this.state[0], 0, state.length);
		this.state[0] = state.slice(0, state.length);
		this.currentPlayer = 0;
	}

	private override function hasLegalMoveAtVertex(pathIndex : Int, vertexIndex : Int) : Bool {
		if (pathIndex != 0)
			return false;
		return super.hasLegalMoveAtVertex(pathIndex, vertexIndex);
	}

	public override function doesCurrentPlayerHaveLegalMove() : Bool {
		for (i in 0...this.getVertexCount(0)) {
			if (this.hasLegalMoveAtIndex(i))
				return true;
			trace("Total vertices: " + this.getVertexCount(0));
			}
		return false;
	}

	public override function startNewGame() : Void {
		this.state = new Array<Array<Int>>(); // this.state = new int[1][state.length];
		// System.arraycopy(state, 0, this.state[0], 0, state.length);
		// this.state[0] = state.slice(0, state.length);
		this.currentPlayer = 0;
	}

}
