import UIKit
import RatingControl

class ViewController: UIViewController {
	@IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
	@IBOutlet weak var updateTypeSegmentedControl: UISegmentedControl!
	@IBOutlet weak var floatRatingView: RatingControl!
	@IBOutlet weak var ratingLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		ratingTypeChanged(ratingSegmentedControl)
		updateTypeChanged(updateTypeSegmentedControl)
		ratingChanged(floatRatingView)
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
	
	@IBAction func ratingChanged(_ sender: RatingControl) {
		ratingLabel.text = sender.rating.formatted
	}
}

private extension Double {
	var formatted: String {
		return String(format: "%.2f", self)
	}
}
