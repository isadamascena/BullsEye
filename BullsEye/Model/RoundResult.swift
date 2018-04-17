struct RoundResult {
  let score: Int
  let missedBy: Int
  var perfection: Perfection {
    if missedBy == 0 {
      return .perfect
    } else if missedBy < 5 {
      return .almostHadIt
    } else if missedBy < 10 {
      return .prettyGood
    } else {
      return .notEvenClose
    }
  }
}

enum Perfection {
  case perfect
  case almostHadIt
  case prettyGood
  case notEvenClose
}
