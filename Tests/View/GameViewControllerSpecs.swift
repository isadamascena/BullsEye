import Quick
import Nimble

@testable import BullsEye

class GameViewControllerSpecs: QuickSpec {
  override func spec() {
    xdescribe("GameViewController") {

      var viewController: GameViewController!

      beforeEach {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! GameViewController
        viewController.loadView()
      }

      describe("updateScoreLabel") {
        it("updates the score label text") {
          viewController.updateScoreLabel(value: 10)

          expect(viewController.scoreLabel.text).to(equal("10"))
        }
      }

      describe("updateRound") {
        it("updates the round label text") {
          viewController.updateRound(8)

          expect(viewController.roundLabel.text).to(equal("8"))
        }
      }

      describe("updateTarget") {
        it("updates the target label text") {
          viewController.updateTarget(4)

          expect(viewController.targetLabel.text).to(equal("4"))
        }
      }

      describe("resetSlider") {
        it("puts slider scrubber in the middle") {
          viewController.resetSlider()

          expect(viewController.slider.value).to(equal(50))
        }
      }

      describe("showMessage") {
        it("shows") {

        }
      }
    }
  }
}
