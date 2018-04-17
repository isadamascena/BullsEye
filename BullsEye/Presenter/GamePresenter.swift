class GamePresenter {
  let view: GameViewController
  let game: Game

  init(view: GameViewController, game: Game = BullsEye()) {
    self.view = view
    self.game = game
  }

  func hit(value: Int) {
    let roundResult = game.hit(value: value)
    view.updateScoreLabel(value: game.score)
    view.showMessage(score: roundResult.score, howClose: roundResult.perfection)
    game.newRound()
    view.updateRound(game.round)
    view.updateTarget(game.target)
    view.resetSlider()
  }

  func newGame() {
    game.reset()
    view.updateRound(game.round)
    view.updateTarget(game.target)
    view.resetSlider()
  }
}
