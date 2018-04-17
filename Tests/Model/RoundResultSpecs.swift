import Quick
import Nimble

@testable import BullsEye

class RoundResultSpecs: QuickSpec {
  override func spec() {
    describe("RoundResult") {
      describe("perfection") {
        context("when user hits the nail on the head") {
          it("returns perfect") {
            let result = RoundResult(score: 0, missedBy: 0)

            expect(result.perfection).to(equal(Perfection.perfect))
          }
        }

        context("when user misses by less than 5") {
          it("returns almost had it") {
            let result = RoundResult(score: 0, missedBy: 1)

            expect(result.perfection).to(equal(Perfection.almostHadIt))
          }
        }

        context("when user misses by less than 10") {
          it("returns perfect") {
            let result = RoundResult(score: 0, missedBy: 8)

            expect(result.perfection).to(equal(Perfection.prettyGood))
          }
        }

        context("when user misses by 10 or more") {
          it("returns perfect") {
            let result = RoundResult(score: 0, missedBy: 10)

            expect(result.perfection).to(equal(Perfection.notEvenClose))
          }
        }
      }
    }
  }
}
