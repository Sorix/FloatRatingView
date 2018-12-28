import UIKit

internal extension RatingControl {
	/// Get rating based on touch
	func rating(for touch: UITouch) -> Double {
		let touchLocation = touch.location(in: self)
		var newRating: Double = 0
		for i in stride(from: (maxRating-1), through: 0, by: -1) {
			let imageView = imageViewStorage.emptyImageViews[i]
			guard touchLocation.x > imageView.frame.origin.x else {
				continue
			}
			
			// Find touch point in image view
			let newLocation = imageView.convert(touchLocation, from: self)
			
			// Find decimal value for float or half rating
			if imageView.point(inside: newLocation, with: nil) && (type.supportsFractions()) {
				let decimalNum = Double(newLocation.x / imageView.frame.size.width)
				newRating = Double(i) + decimalNum
				if type == .halfRatings {
					newRating = Double(i) + (decimalNum > 0.75 ? 1 : (decimalNum > 0.25 ? 0.5 : 0))
				}
			} else {
				// Whole rating
				newRating = Double(i) + 1.0
			}
			break
		}
		
		if newRating < Double(minRating) {
			return Double(minRating)
		} else {
			return newRating
		}
	}
	
	/// Change rating, send actions, delegate events and haptics.
	///
	/// - Parameters:
	///   - type: if type is `continue` rating will be updated only if `isContinuous` is true. If type is `final` rating will be updated always.
	func handle(touch: UITouch, type: TouchType) {
		let newRating = rating(for: touch)

		// Haptic
		if let lastTouchedRating = self.lastTouchedRating {
			// touched previously
			if lastTouchedRating != newRating {
				// rating has changed
				haptic?.selectionChanged()
			}
		} else {
			// never touched previously
			if newRating != rating {
				// new touch is on another rating
				haptic?.selectionChanged()
			}
		}
		lastTouchedRating = newRating
		
		// Update
		switch type {
		case .continue:
			if isContinuous && newRating != rating {
				rating = newRating
				sendActions(for: [.valueChanged])
				delegate?.floatRatingView?(self, isUpdating: newRating)
			} else {
				imageViewStorage.setVisible(numberOfImages: newRating)
			}
		case .final:
			if newRating == rating { return }
			
			rating = newRating
			sendActions(for: [.valueChanged])
			delegate?.floatRatingView?(self, didUpdate: newRating)
		}
	}
	
	enum TouchType {
		case final, `continue`
	}
}
