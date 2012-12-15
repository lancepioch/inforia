var EventEmitter = require("events").EventEmitter;
var util = require("util");

// Class GameModel
function GameModel() {
	GameModel.super_.call(this); // not necessary, but it's neater to keep it there.
	this.playerCount = 2;
	this.currentPlayer = 0;
};
util.inherits(GameModel, EventEmitter);

GameModel.prototype.getNextPlayer = function() {
	var nextPlayer = this.currentPlayer + 1;
	if (nextPlayer >= this.playerCount)
		nextPlayer = 0;
	return nextPlayer;
};

GameModel.prototype.currentPlayerHasLegalMove = function() {
	return true;
};

GameModel.prototype.nextTurn = function() {
	this.currentPlayer = this.getNextPlayer();
}

GameModel.prototype.toString = function() {
	return "Standard Game Model";
};

GameModel.prototype.equals = function(other) {
	return false;
};

// Class TwoPlayerPathGroupGameModel
function TwoPlayerPathGroupGameModel() {
	TwoPlayerPathGroupGameModel.super_.call(this);

	this.playerCount = 2;

	// An 2D-array representing the vertex state in the group of paths
    // protected int[][] state;
}
util.inherits(TwoPlayerPathGroupGameModel, GameModel);

// Checks if a given index is a valid path index.
TwoPlayerPathGroupGameModel.prototype.isValidPathIndex = function(index) {
	return index >= 0 && index < this.getPathCount();
}

// Checks if a given index is a valid vertex index in a path.
TwoPlayerPathGroupGameModel.prototype.isValidVertexIndex = function(pathIndex, vertexIndex) {
	return this.isValidPathIndex(pathIndex) && vertexIndex >= 0 && vertexIndex < this.getVertexCount(pathIndex);
}

// Checks whether there is a legal move for the current player at the specified vertex.
TwoPlayerPathGroupGameModel.prototype.hasLegalMoveAtVertex = function(pathIndex, vertexIndex) {
	return false;
}

// An array of the same length of the number of paths. The i-th element of the array is the number of vertices in the path with index i.
// public int[] getAllVertexCounts() {
TwoPlayerPathGroupGameModel.prototype.getAllVertexCounts = function() {
	var vertexCountInPath = new Array(this.getPathCount());
	for (var i = 0; i < this.getPathCount(); i++)
		vertexCountInPath[i] = this.getVertexCount(i);
	return vertexCountInPath;
}


// Starts a new game with the specified number of vertices in each path.
TwoPlayerPathGroupGameModel.prototype.startNewGame = function(vertexCountInPath) { // (int[] vertexCountInPath) {
	// this.state = new int[vertexCountInPath.length][];
	this.state = new array(vertexCountInPath);
	for (var i = 0; i < this.state.length; i++)
		this.state = new array();
	for (var i = 0; i < this.getPathCount(); i++)
		this.state[i] = new Array(vertexCountInPath[i]);
	this.currentPlayer = 1;
}

TwoPlayerPathGroupGameModel.prototype.doesCurrentPlayerHaveLegalMove = function() {
	for (var i = 0; i < this.getPathCount(); i++)
		for (var j = 0; j < this.getVertexCount(i); j++)
			if (this.hasLegalMoveAtVertex(i, j))
				return true;
	return false;
}

// Returns the number of vertices in a path.
TwoPlayerPathGroupGameModel.prototype.getVertexCount = function(index) {
	if (this.isValidPathIndex(index))
		return this.state[index].length;
	return -1;
}

// Number of paths in the group
TwoPlayerPathGroupGameModel.prototype.getPathCount = function() {
	return this.state.length;
}

// Sets the state of the specified vertex.
TwoPlayerPathGroupGameModel.prototype.setVertexState = function(pathIndex, vertexIndex, newState) {
	if (!this.isValidVertexIndex(pathIndex, vertexIndex))
		return false;
	this.state[pathIndex][vertexIndex] = newState;
	return true;
}

// Returns the current state of the specified vertex.
TwoPlayerPathGroupGameModel.prototype.getVertexState = function(pathIndex, vertexIndex) {
	if (!this.isValidVertexIndex(pathIndex, vertexIndex))
		return Number.MIN_VALUE;
	return this.state[pathIndex][vertexIndex];
}

TwoPlayerPathGroupGameModel.prototype.equals = function(other) {
	// TwoPlayerPathGroupGameModel otherGame = (TwoPlayerPathGroupGameModel) other;
	var otherGame = other;
	return this.getCurrentPlayer() == otherGame.getCurrentPlayer() && this.state.equals(otherGame.state);
}

TwoPlayerPathGroupGameModel.prototype.toString = function(prefix, displayPathNumber) {
	var stringBuffer = new array();
	stringBuffer.push(prefix);
	for (var i = 0; i < this.getPathCount(); i++) {
		if (displayPathNumber)
			stringBuffer.push("path ", i, ":");
		for (var j = 0; j < this.getVertexCount(i); j++)
			stringBuffer.push(" ", this.getVertexState(i, j));
		stringBuffer.push("\n");
	}
	stringBuffer.push("\n");
	return stringBuffer.join("");
}


// Class TwoPlayerPathGameModel
function TwoPlayerPathGameModel() {
	TwoPlayerPathGameModel.super_.call(this);
};
util.inherits(TwoPlayerPathGameModel, TwoPlayerPathGroupGameModel);

// Checks if a given index is a valid vertex index.
TwoPlayerPathGameModel.prototype.isValidIndex = function(index) {
	return isValidVertexIndex(0, index);
}

TwoPlayerPathGameModel.prototype.setVertexState = function(index, newState) {
	if (!this.isValidIndex(index)) {
		return false;
	}
	this.state[0][index] = newState;
	return true;
}

// Check whether there exists a legal move for the current player at the specified vertex.
// protected abstract boolean hasLegalMoveAtVertex(int index);
TwoPlayerPathGameModel.prototype.hasLegalMoveAtVertex = function(index) {
	return false;
}

TwoPlayerPathGameModel.prototype.hasLegalMoveAtVertex = function(pathIndex, vertexIndex) {
	if (pathIndex != 0)
		return false;
	return hasLegalMoveAtVertex(vertexIndex);
}

TwoPlayerPathGameModel.prototype.startNewGame = function(state) { // int[]
	// this.state = new int[1][state.length];
	this.state = state;
	// System.arraycopy(state, 0, this.state[0], 0, state.length);
	this.currentPlayer = 1;
}

TwoPlayerPathGameModel.prototype.getVertexCount = function() {
	return this.getVertexCount(0);
}

TwoPlayerPathGameModel.prototype.getVertexState = function(index) {
	return this.getVertexState(0, index);
}

/* Usage
// var Inforia = require('./Inforia.js');
// var gamemodel = new Inforia.GameModel('Will');
*/


// Examples

// Class ToadsAndFrogsModel
function ToadsAndFrogsModel() {
	/**
	 * ToadsAndFrogsModel describes the model component of the game Toads and Frogs. More information
	 * about this game is available here:
	 * http://en.wikipedia.org/wiki/Toads_and_Frogs_%28game%29
	 */

	ToadsAndFrogsModel.super_.call(this);
	// Player description: Player 1(Left) - Toads; Player 2(Right) - Frogs.
	// Vertex State description: 0 - Empty; 1 - Toad; 2 - Frog.

	// A constant array containing the direction of movement for both players.
	this.DELTA = [0, 1, -1];
	// Default range for randomized number of boxes
	this.DEFAULT_RANDOM_BOX_COUNT_RANGE = 7;
	// Default minimum number of boxes
	this.DEFAULT_MIN_BOX_COUNT = 8;
	// Three possible states: Empty, Toad and Frog.
	this.POSSIBLE_STATES_COUNT = 3;
};
util.inherits(ToadsAndFrogsModel, TwoPlayerPathGameModel);


ToadsAndFrogsModel.prototype.startNewGame = function() {
	Random randomNumberGenerator = new Random();
	var boxCount = randomNumberGenerator.nextInt(DEFAULT_RANDOM_BOX_COUNT_RANGE) + DEFAULT_MIN_BOX_COUNT;
	var initialState = new array(boxCount);
	initialState[0] = 1;
	initialState[boxCount - 1] = 2;
	for (var i = 2; i < boxCount - 2; i++)
		initialState[i] = Math.floor(Math.random() * POSSIBLE_STATES_COUNT);
	this.startNewGame(initialState);
}

ToadsAndFrogsModel.prototype.getMoveDestination = function(index) {
	if (!this.isValidIndex(index) || this.getVertexState(index) != this.getCurrentPlayer())
		return -1;
	var destinationIndex = index + DELTA[this.getCurrentPlayer()];
	if (!this.isValidIndex(destinationIndex))
		return -1;
	if (this.isEmptyState(destinationIndex))
		return destinationIndex;
	if (this.getVertexState(destinationIndex) == this.getCurrentPlayer())
		return -1;
	destinationIndex += DELTA[this.getCurrentPlayer()];
	if (!this.isValidIndex(destinationIndex) || !this.isEmptyState(destinationIndex))
		return -1;
	return destinationIndex;
}

ToadsAndFrogsModel.prototype.hasLegalMoveAtVertex = function(index) {
	return this.isValidIndex(this.getMoveDestination(index));
}

// Moves a piece of the current player at a specified location.
ToadsAndFrogsModel.prototype.makeMove = function(index) {
	if (!this.hasLegalMoveAtVertex(index))
		return false;
	this.setVertexState(this.getMoveDestination(index), this.getCurrentPlayer());
	this.setVertexState(index, 0);
	return true;
}

// Returns if the specified box is empty (contains neither toad nor frog).
ToadsAndFrogsModel.prototype.isEmptyState = function(index) {
	return this.isValidIndex(index) && this.getVertexState(index) == 0;
}

// public GamePanel<?> getNewGamePanel(GameController controller) {
ToadsAndFrogsModel.prototype.getNewGamePanel = function(controller){
	return new ToadsAndFrogsPanel(this, controller);
}

ToadsAndFrogsModel.prototype.getGameName = function() {
	return "Toads&Frogs";
}