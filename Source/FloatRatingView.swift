import UIKit

/// A simple rating control that can set whole, half or floating point ratings.
@IBDesignable open class FloatRatingView: UIControl {
	@available(*, deprecated, message: "Use the Target-Action design pattern from UIControl, don't use delegate methods")
    open weak var delegate: FloatRatingViewDelegate?

	// MARK: - @IBInspectable Internal variables
	
    /// Sets the empty image (e.g. a star outline)
    @IBInspectable open var emptyImage: UIImage? {
        didSet {
            // Update empty image views
            for imageView in emptyImageViews {
                imageView.image = emptyImage
            }
            refreshMaskLayer()
        }
    }

    /// Sets the full image that is overlayed on top of the empty image.
    /// Should be same size and shape as the empty image.
    @IBInspectable open var fullImage: UIImage? {
        didSet {
            // Update full image views
            for imageView in fullImageViews {
                imageView.image = fullImage
            }
            refreshMaskLayer()
        }
    }

    /// Sets the empty and full image view content mode.
    open var imageContentMode: UIViewContentMode = UIViewContentMode.scaleAspectFit

    /// Minimum rating.
    @IBInspectable open var minRating: Int  = 0 {
        didSet {
            // Update current rating if needed
            if rating < Double(minRating) {
                rating = Double(minRating)
                refreshMaskLayer()
            }
        }
    }

    /// Max rating value.
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            if maxRating != oldValue {
                removeImageViews()
                initImageViews()
                
                // Relayout and refresh
                setNeedsLayout()
                refreshMaskLayer()
            }
        }
	}

    /// Set the current rating.
    @IBInspectable open var rating: Double = 0 {
        didSet {
            if rating != oldValue {
                refreshMaskLayer()
            }
        }
    }

    /// Sets whether or not the rating view can be changed by panning.
	@available(*, deprecated, renamed: "isEnabled")
	@IBInspectable open var editable: Bool {
		get { return isEnabled }
		set { isEnabled = newValue }
	}

    /// Float rating view type
    @IBInspectable open var type: FloatRatingViewType = .wholeRatings
	
	/// A Boolean value indicating whether changes in the slider’s value generate continuous update events.
	///
	/// If true, the control triggers the associated target’s action method repeatedly. If false, the control triggers the associated action method just once, when the user releases the control to set the final value.
	/// The default value of this property is true.
	@IBInspectable open var isContinuous: Bool = false
	
	// MARK: Internal variables
	
	/// Array of empty image views
	internal var emptyImageViews: [UIImageView] = []
	
	/// Array of full image views
	internal var fullImageViews: [UIImageView] = []
    
    // MARK: - Initializations
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initImageViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initImageViews()
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
	
	// MARK: Tracking
	
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
