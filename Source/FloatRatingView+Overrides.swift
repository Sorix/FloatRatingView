import UIKit

extension FloatRatingView {
	open override var intrinsicContentSize: CGSize {
		guard let prototypeImageView = fullImageViews.first else {
			return super.intrinsicContentSize
		}
		
		let desiredWidth = prototypeImageView.intrinsicContentSize.width * CGFloat(maxRating)
		let desiredSize = CGSize(width: desiredWidth, height: prototypeImageView.intrinsicContentSize.height)
		
		return desiredSize
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		
		let desiredImageWidth = frame.size.width / CGFloat(maxRating)
		
		var xOffset: CGFloat = 0
		for i in 0..<maxRating {
			xOffset = CGFloat(i) * desiredImageWidth
			let imageFrame = CGRect(x: xOffset, y: 0, width: desiredImageWidth, height: frame.size.height)
			
			var imageView = emptyImageViews[i]
			imageView.frame = imageFrame
			
			imageView = fullImageViews[i]
			imageView.frame = imageFrame
		}
		
		refreshMaskLayer()
	}
	
	// MARK: - Tracking
	
	open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		rating = rating(for: touch)
		return true
	}
	
	open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let newRating = rating(for: touch)
		if newRating != rating {
			rating = newRating
			
			if isContinuous { sendActions(for: [.valueChanged]) }
		}
		return true
	}
	
	open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)
		sendActions(for: [.valueChanged])
		delegate?.floatRatingView(self, didUpdate: rating)
	}
	
	open override func cancelTracking(with event: UIEvent?) {
		super.cancelTracking(with: event)
		sendActions(for: [.valueChanged])
		delegate?.floatRatingView(self, didUpdate: rating)
	}
}
