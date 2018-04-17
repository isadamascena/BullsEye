import UIKit

class GameViewController: UIViewController {
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBAction func hitMeTapped() {

  }

  @IBAction func sliderMoved(_ slider: UISlider) {

  }

  @IBAction func startNewGame() {

  }

  func updateScoreLabel(value: Int) {
    scoreLabel.text = "\(value)"
  }

  func showMessage(score: Int, howClose: Perfection) {

  }

  func updateRound(_ round: Int) {
    roundLabel.text = "\(round)"
  }

  func updateTarget(_ target: Int) {
    targetLabel.text = "\(target)"
  }

  func resetSlider() {
    slider.value = Float(50)
  }
}
