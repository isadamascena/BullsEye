import Quick
import Nimble

@testable import BullsEye

class BullsEyeSpecs: QuickSpec {
  override func spec() {
    describe("BullsEye Game") {

      var bullsEye: BullsEye!

      beforeEach {
        bullsEye = BullsEye()
      }

      it("conforms with Game protocol") {
        expect(bullsEye).to(beAKindOf(Game.self))
      }

      describe("round") {
        it("starts as 1") {
          expect(bullsEye.round).to(equal(1))
        }
      }

    describe("score") {
        it("starts as 0") {
            expect(bullsEye.score).to(equal(0))
        }
    }

      describe("newRound") {
        it("increments the round") {
          bullsEye.newRound()
          bullsEye.newRound()

          expect(bullsEye.round).to(equal(3))
        }

        it("changes the target to a new number") {
          let firstTarget = bullsEye.target

          bullsEye.newRound()
          let newTarget = bullsEye.target

          expect(firstTarget).toNot(equal(newTarget))
        }
      }

      describe("target") {
        it("is a number between 0 and 100") {
          expect(bullsEye.target).to(beGreaterThanOrEqualTo(0))
          expect(bullsEye.target).to(beLessThanOrEqualTo(100))
        }
      }

        describe("hit") {
            context("when the player hits the nail on the head") {
                it("scores 100 points plus another 100 as a bonus") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 70)

                    expect(result.score).to(equal(200))
                }

                it("returns the information that the guess was perfect") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 70)

                    expect(result.perfection).to(equal(Perfection.perfect))
                }
            }

            context("when the player misses by 1") {
                it("scores 99 points plus another 50 as bonus") {
                    bullsEye.target = 5

                    let result = bullsEye.hit(value: 4)

                    expect(result.score).to(equal(149))
                }
            }

            context("when the user misses by less than 5") {
                it("returns the information that the user almost had it") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 74)

                    expect(result.perfection).to(equal(Perfection.almostHadIt))
                }
            }

            context("when the player misses by 10") {
                it("scores 90 points") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 60)

                    expect(result.score).to(equal(90))
                }
            }

            context("when the player misses by less than 10") {
                it("returns the information that the user was pretty good") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 75)

                    expect(result.perfection).to(equal(Perfection.prettyGood))
                }
            }

            context("when the player misses by more than 9") {
                it("returns the information that the user was not even close") {
                    bullsEye.target = 70

                    let result = bullsEye.hit(value: 10)

                    expect(result.perfection).to(equal(Perfection.notEvenClose))
                }
            }

            context("when the user is alreading playing") {
                it("saves the old score plus the new one") {
                    bullsEye.target = 10
                    bullsEye.score = 1000

                    let result = bullsEye.hit(value: 10)

                    expect(bullsEye.score).to(equal(1200))
                }
            }
        }

        describe("reset") {
            it("resets score") {
                bullsEye.reset()

                expect(bullsEye.score).to(equal(0))
            }

            it("resets round") {
                bullsEye.reset()

                expect(bullsEye.round).to(equal(1))
            }

            it("generates a new random number") {
                bullsEye.newRound()
                let firstRandomNumber = bullsEye.target

                bullsEye.reset()
                let secondsRandomNumber = bullsEye.target

                expect(firstRandomNumber).toNot(equal(secondsRandomNumber))
            }
        }
    }
  }
}
