function GameModel() {
	// this.name = name;
	this.playerCount = 2;
	this.currentPlayer = 0;
};

GameModel.prototype.getNextPlayer = function () {
	var nextPlayer = this.currentPlayer + 1;
	if (nextPlayer >= this.playerCount)
		nextPlayer = 0;
	return nextPlayer;
};

GameModel.prototype.currentPlayerHasLegalMove = function () {
	return true;
};

GameModel.prototype.nextTurn = function () {
	this.currentPlayer = this.getNextPlayer();
}

GameModel.prototype.toString = function () {
	return "Standard Game Model";
};

GameModel.prototype.equals = function (other) {
	return false;
};


// Usage
/* var Inforia = require('./Inforia.js');
var gamemodel = new Inforia.GameModel('Will'); //*/