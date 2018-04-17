import Quick
import Nimble

@testable import BullsEye

class GamePresenterSpecs: QuickSpec {
  override func spec() {
    describe("GamePresenter") {
      describe("init") {
        it("starts with a GameViewController") {
          let view = GameViewController()

          let presenter = GamePresenter(view: view)

          expect(presenter.view).to(equal(view))
        }

        it("starts with a Game instance") {
          let presenter = GamePresenter(view: GameViewControllerMock())

          expect(presenter.game).to(beAKindOf(Game.self))
        }
      }

      describe("hit") {
        it("calls the Game's hit method with proper value") {
          let gameMock = GameMock()
          let presenter = GamePresenter(view: GameViewControllerMock(), game: gameMock)

          presenter.hit(value: 16)

          expect(gameMock.didCallHit).to(beTrue())
          expect(gameMock.didCallHitWithValue).to(equal(16))
        }

        it("calls the View to update the score") {
          let gameMock = GameMock()
          let viewMock = GameViewControllerMock()
          let presenter = GamePresenter(view: viewMock, game: gameMock)
          gameMock.score = 666

          presenter.hit(value: 16)

          expect(viewMock.didCallUpdateScoreLabel).to(beTrue())
          expect(viewMock.didCallUpdateScoreLabelWithValue).to(equal(666))
        }

        it("calls the view to display the score and how close was the guess") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            let roundResult = RoundResult.init(score: 20, missedBy: 10)
            gameMock.returnRoundResult = roundResult

            presenter.hit(value: 16)

            expect(viewMock.didCallShowMessage).to(beTrue())
            expect(viewMock.didCallShowMessageWithScore).to(equal(20))
            expect(viewMock.didCallShowMessageWithHowClose).to(equal(Perfection.notEvenClose))
        }

        it("starts a new game round after a hit") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)

            presenter.hit(value: 16)

            expect(gameMock.didCallNewRound).to(beTrue())
        }

        it("calls the view with the new round") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.round = 2

            presenter.hit(value: 16)

            expect(viewMock.didCallUpdateRound).to(beTrue())
            expect(viewMock.didCallUpdateRoundWithValue).to(equal(2))
        }

        it("calls the view with the new target") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.target = 40

            presenter.hit(value: 16)

            expect(viewMock.didCallUpdateTarget).to(beTrue())
            expect(viewMock.didCallUpdateTargetWithValue).to(equal(40))
        }

        it("calls the view to reset the slider") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.target = 40

            presenter.hit(value: 16)

            expect(viewMock.didCallResetSlider).to(beTrue())
        }
      }

      describe("newGame") {
        it("resets the game") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.target = 40

            presenter.newGame()

            expect(gameMock.didCallReset).to(beTrue())
        }

        it("calls the view with the new round") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.round = 2

            presenter.newGame()

            expect(viewMock.didCallUpdateRound).to(beTrue())
            expect(viewMock.didCallUpdateRoundWithValue).to(equal(2))
        }

        it("calls the view with the new target") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.target = 40

            presenter.newGame()

            expect(viewMock.didCallUpdateTarget).to(beTrue())
            expect(viewMock.didCallUpdateTargetWithValue).to(equal(40))
        }

        it("calls the view to reset the slider") {
            let gameMock = GameMock()
            let viewMock = GameViewControllerMock()
            let presenter = GamePresenter(view: viewMock, game: gameMock)
            gameMock.target = 40

            presenter.newGame()

            expect(viewMock.didCallResetSlider).to(beTrue())
        }
      }
    }
  }
}

class GameViewControllerMock: GameViewController {
  var didCallUpdateScoreLabel = false
  var didCallShowMessage = false
  var didCallUpdateRound = false
  var didCallUpdateTarget = false
  var didCallResetSlider = false
  var didCallUpdateRoundWithValue: Int?
  var didCallUpdateScoreLabelWithValue: Int?
  var didCallShowMessageWithScore: Int?
  var didCallShowMessageWithHowClose: Perfection?
  var didCallUpdateTargetWithValue: Int?

  override func updateScoreLabel(value: Int) {
    didCallUpdateScoreLabel = true
    didCallUpdateScoreLabelWithValue = value
  }

  override func showMessage(score: Int, howClose: Perfection) {
    didCallShowMessage = true
    didCallShowMessageWithScore = score
    didCallShowMessageWithHowClose = howClose
  }

  override func updateRound(_ round: Int) {
    didCallUpdateRound = true
    didCallUpdateRoundWithValue = round
  }

  override func updateTarget(_ target: Int) {
    didCallUpdateTarget = true
    didCallUpdateTargetWithValue = target
  }

  override func resetSlider() {
    didCallResetSlider = true
  }
}

class GameMock: Game {
  var round: Int = 0
  var target: Int = 0
  var score: Int = 0

  var didCallHit = false
  var didCallHitWithValue: Int?
  var didCallNewRound = false
  var didCallReset = false

  var returnRoundResult: RoundResult?

  func newRound() {
    didCallNewRound = true
  }

  func hit(value: Int) -> RoundResult {
    didCallHit = true
    didCallHitWithValue = value
    if returnRoundResult != nil {
        return returnRoundResult!
    } else {
        return RoundResult(score: 0, missedBy: 0)
    }
  }

  func reset() {
    didCallReset = true
  }
}
