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

	this._register();
}
util.inherits(TwoPlayerPathGroupGameModel, GameModel);
TwoPlayerPathGroupGameModel.prototype._register = function() {
	var self = this; // Set the variable "self" to avoid issues with scope and "this" in the callback
	
	/* Example:
	// registry.register(this, function() { self.emit("created and registered", self });
	// Register this instance and pass a callback to emit an event once registered.
	*/
}

// Checks if a given index is a valid path index.
TwoPlayerPathGroupGameModel.prototype.isValidPathIndex = function(index) {
	return index >= 0 && index < this.getPathCount();
}

// Checks if a given index is a valid vertex index in a path.
TwoPlayerPathGroupGameModel.prototype.isValidVertexIndex = function(pathIndex, vertexIndex) {
	return this.isValidPathIndex(pathIndex) && vertexIndex >= 0 && vertexIndex < this.getVertexCount(pathIndex);
}

// Checks whether there is a legal move for the current player at the specified vertex.
TwoPlayerPathGroupGameModel.prototype.hasLegalMoveAtVertex = function(int pathIndex, int vertexIndex) {
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
	TwoPlayerPathGroupGameModel otherGame = (TwoPlayerPathGroupGameModel) other;
	return this.getCurrentPlayer() == otherGame.getCurrentPlayer() && this.state.equals(otherGame.state);
}

TwoPlayerPathGroupGameModel.prototype.toString = function(prefix, displayPathNumber) {
	var stringBuffer = new array();
	stringBuffer.push(prefix);
	for (var i = 0; i < this.getPathCount(); i++) {
		if (displayPathNumber)
			stringBuffer.push("path ", i, ":");
		for (int j = 0; j < this.getVertexCount(i); j++)
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

/* Usage
// var Inforia = require('./Inforia.js');
// var gamemodel = new Inforia.GameModel('Will');
*/