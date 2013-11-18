import GameModel;

class GameController {
	private var model : GameModel;
	// private var GameView view;

	public function new(model : GameModel) {
		this.model = model;
		// this.view = new GameView(this, this.models);
		// this.view.initializeGamePanels();
		// this.view.refreshGamePanels(this.models[0].getCurrentPlayer());
	}

	public function gameMoveMade() : Void {
		var playerWhoJustMadeThisMove = this.model.getCurrentPlayer();
		model.switchToNextTurn();

		// this.view.refreshGamePanels(this.models[0].getCurrentPlayer());

		var activeGame = model.doesCurrentPlayerHaveLegalMove();
		if (!activeGame) {
			trace("Player " + playerWhoJustMadeThisMove + " wins!");
			// this.view.announceWinner(playerWhoJustMadeThisMove);
			// this.view.askUserToPlayAgainOrNot();
		}
	}

	public function startNewGame() : Void {
		model.startNewGame();
		// this.view.initializeGamePanels();
		// this.view.refreshGamePanels(this.models[0].getCurrentPlayer());
	}

	public function currentPlayerGiveUp() : Void {
		// this.view.annoucePlayerGivingUp(this.models[0].getCurrentPlayer());
		trace("giving up");
	}

	public function toString() : String {
		return this.model.toString();
	}
}
