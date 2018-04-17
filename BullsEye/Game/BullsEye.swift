import Foundation

protocol Game {
  var round: Int { get }
  var target: Int { get }
  var score: Int { get }

  func newRound()
  func hit(value: Int) -> RoundResult
  func reset()
}

enum Bonus: Int {
  case perfect = 100
  case good = 50
}

class BullsEye: Game {
  var round = 1
  var target = 0
  var score = 0

  init() {
    target = generateRandomNumber()
  }

  func newRound() {
    round += 1
    target = generateRandomNumber()
  }

  func hit(value: Int) -> RoundResult {
    let difference = abs(value - target)
    score += (100 - difference) + calculateBonus(forDifference: difference)
    return RoundResult(score: score, missedBy: difference)
  }

  func reset() {
    round = 1
    score = 0
    target = generateRandomNumber()
  }

  private func generateRandomNumber() -> Int {
    var randomTarget = target
    while randomTarget == target {
      randomTarget = 1 + Int(arc4random_uniform(100))
    }
    return randomTarget
  }

  private func calculateBonus(forDifference difference: Int) -> Int {
    if difference == 0 {
      return Bonus.perfect.rawValue
    } else if difference == 1 {
      return Bonus.good.rawValue
    }
    return 0
  }
}
