import UIKit

internal extension FloatRatingView {
	func initImageViews() {
		guard emptyImageViews.isEmpty && fullImageViews.isEmpty else {
			return
		}
		
		// Add new image views
		for _ in 0..<maxRating {
			let emptyImageView = UIImageView()
			emptyImageView.contentMode = contentMode
			emptyImageView.image = emptyImage
			emptyImageViews.append(emptyImageView)
			addSubview(emptyImageView)
			
			let fullImageView = UIImageView()
			fullImageView.contentMode = contentMode
			fullImageView.image = fullImage
			fullImageViews.append(fullImageView)
			addSubview(fullImageView)
		}
	}
	
	func removeImageViews() {
		// Remove old image views
		for i in 0..<emptyImageViews.count {
			var imageView = emptyImageViews[i]
			imageView.removeFromSuperview()
			imageView = fullImageViews[i]
			imageView.removeFromSuperview()
		}
		emptyImageViews.removeAll(keepingCapacity: false)
		fullImageViews.removeAll(keepingCapacity: false)
	}
	
	// Refresh hides or shows full images
	func refreshMaskLayer() {
		for i in 0..<fullImageViews.count {
			let imageView = fullImageViews[i]
			
			if rating >= Double(i+1) {
				imageView.layer.mask = nil
				imageView.isHidden = false
			} else if rating > Double(i) && rating < Double(i+1) {
				// Set mask layer for full image
				let maskLayer = CALayer()
				maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Double(i))*imageView.frame.size.width, height: imageView.frame.size.height)
				maskLayer.backgroundColor = UIColor.black.cgColor
				imageView.layer.mask = maskLayer
				imageView.isHidden = false
			} else {
				imageView.layer.mask = nil;
				imageView.isHidden = true
			}
		}
	}
	
	// Calculates new rating based on touch location in view
	func rating(for touch: UITouch) -> Double {
		let touchLocation = touch.location(in: self)
		var newRating: Double = 0
		for i in stride(from: (maxRating-1), through: 0, by: -1) {
			let imageView = emptyImageViews[i]
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
}
