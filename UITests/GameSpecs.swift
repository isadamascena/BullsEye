import Quick
import Nimble

// Cheat sheet: https://github.com/joemasilotti/UI-Testing-Cheat-Sheet

class AppSpecs: QuickSpec {
  override func spec() {
    describe("The BullsEye Game") {

      var app: XCUIApplication!

      beforeEach {
        app = XCUIApplication()
        app.launchArguments.append("ui-tests")
        app.launch()
      }

      afterEach {
        app.terminate()
      }

      it("opens the score screen") {
        app.buttons["starButton"].tap()

        expect(app.staticTexts["Juliana"].exists).toEventually(beTrue(), timeout: 10)
      }
    }
  }
}
