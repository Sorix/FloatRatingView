import UIKit
import FloatRatingView

class ViewController: UIViewController {
	@IBOutlet var ratingSegmentedControl: UISegmentedControl!
	@IBOutlet var floatRatingView: FloatRatingView!
	@IBOutlet var ratingLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		floatRatingView.type = .halfRatings
		
		// Labels init
		ratingLabel.text = floatRatingView.rating.formatted
	}
	
	@IBAction func ratingTypeChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0: floatRatingView.type = .wholeRatings
		case 1: floatRatingView.type = .halfRatings
		case 2: floatRatingView.type = .floatRatings
		default: return
		}
	}
	
	@IBAction func updateTypeChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0: floatRatingView.isContinuous = false
		case 1: floatRatingView.isContinuous = true
		default: return
		}
	}
	
	@IBAction func ratingChanged(_ sender: FloatRatingView) {
		ratingLabel.text = sender.rating.formatted
	}
}

private extension Double {
	var formatted: String {
		return String(format: "%.2f", self)
	}
}
