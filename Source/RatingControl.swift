import UIKit

/// A simple rating control that can set whole, half or floating point ratings.
@IBDesignable open class RatingControl: UIControl {
	@available(*, deprecated: 4.0, message: "Use the Target-Action design pattern from UIControl, don't use delegate methods")
	open weak var delegate: FloatRatingViewDelegate?
	
	// MARK: - @IBInspectable Internal variables
	
	/// Sets the empty image (e.g. a star outline)
	@IBInspectable open var emptyImage: UIImage? {
		didSet {
			imageViewStorage.setEmptyImage(emptyImage)
			imageViewStorage.setVisible(numberOfImages: rating)
		}
	}
	
	/// Sets the full image that is overlayed on top of the empty image.
	/// Should be same size and shape as the empty image.
	@IBInspectable open var fullImage: UIImage? {
		didSet {
			// Update full image views
			imageViewStorage.setFullImage(fullImage)
			imageViewStorage.setVisible(numberOfImages: rating)
		}
	}
	
	/// Sets the empty and full image view content mode.
	@available(*, deprecated: 4.0, renamed: "contentMode")
	open var imageContentMode: UIView.ContentMode {
		get { return contentMode }
		set { contentMode = newValue }
	}
	
	/// Minimum rating.
	@IBInspectable open var minRating: Int  = 0 {
		didSet {
			// Update current rating if needed
			if rating < Double(minRating) {
				rating = Double(minRating)
				imageViewStorage.setVisible(numberOfImages: rating)
			}
		}
	}
	
	/// Max rating value.
	@IBInspectable open var maxRating: Int = 5 {
		didSet {
			if maxRating != oldValue {
				imageViewStorage.removeImageViews(from: self)
				
				imageViewStorage = ImageViewStorage(numberOfImages: maxRating, emptyImage: emptyImage, fullImage: fullImage, contentMode: contentMode)
			
				// Relayout and refresh
				setNeedsLayout()
				imageViewStorage.setVisible(numberOfImages: rating)
			}
		}
	}
	
	/// Set the current rating.
	@IBInspectable open var rating: Double = 0 {
		didSet {
			if rating != oldValue {
				imageViewStorage.setVisible(numberOfImages: rating)
			}
		}
	}
	
	open override var contentMode: UIView.ContentMode {
		didSet {
			imageViewStorage.setContentMode(contentMode)
		}
	}
	
	/// Sets whether or not the rating view can be changed by panning.
	@available(*, deprecated: 4.0, renamed: "isEnabled")
	open var editable: Bool {
		get { return isEnabled }
		set { isEnabled = newValue }
	}
	
	@available(*, deprecated: 4.0, message: "This value is ignored")
	open var minImageSize: CGSize = CGSize(width: 5.0, height: 5.0)
	
	/// Float rating view type
	@IBInspectable open var type: FloatRatingViewType = .wholeRatings
	
	/// A Boolean value indicating whether changes in the slider’s value generate continuous update events.
	///
	/// If true, the control triggers the associated target’s action method repeatedly. If false, the control triggers the associated action method just once, when the user releases the control to set the final value.
	/// The default value of this property is true.
	@IBInspectable open var isContinuous: Bool = false
	
	// MARK: Internal variables
	
	internal var imageViewStorage = ImageViewStorage()

	// Used to avoid excessive haptic feedbacks
	internal var lastTouchedRating: Double?
	internal var haptic: UISelectionFeedbackGenerator?
	
	// MARK: - Initializations
	
	required override public init(frame: CGRect) {
		super.init(frame: frame)
		
		imageViewStorage = ImageViewStorage(numberOfImages: maxRating, emptyImage: emptyImage, fullImage: fullImage, contentMode: contentMode)
		imageViewStorage.addImages(to: self)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		imageViewStorage = ImageViewStorage(numberOfImages: maxRating, emptyImage: emptyImage, fullImage: fullImage, contentMode: contentMode)
		imageViewStorage.addImages(to: self)
	}
	
	// MARK: -
	
	@objc public enum FloatRatingViewType: Int {
		/// Integer rating
		case wholeRatings
		/// Double rating in increments of 0.5
		case halfRatings
		/// Double rating
		case floatRatings
		
		/// Returns true if rating can contain decimal places
		internal func supportsFractions() -> Bool {
			return self == .halfRatings || self == .floatRatings
		}
	}
	
	// MARK: - Overrides
	
	open override var intrinsicContentSize: CGSize {
		guard let prototypeImageView = imageViewStorage.fullImageViews.first else {
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
			
			var imageView = imageViewStorage.emptyImageViews[i]
			imageView.frame = imageFrame
			
			imageView = imageViewStorage.fullImageViews[i]
			imageView.frame = imageFrame
		}
		
		imageViewStorage.setVisible(numberOfImages: rating)
	}
	
	// MARK: Tracking
	
	open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		haptic = UISelectionFeedbackGenerator()
		handle(touch: touch, type: .continue)
		return true
	}
	
	open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		handle(touch: touch, type: .continue)
		return true
	}
	
	open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		if let finalTouch = touch {
			handle(touch: finalTouch, type: .final)
		}
		
		haptic = nil
		lastTouchedRating = nil
		super.endTracking(touch, with: event)
	}
	
	open override func cancelTracking(with event: UIEvent?) {
		haptic = nil
		lastTouchedRating = nil
		super.cancelTracking(with: event)
	}
}
