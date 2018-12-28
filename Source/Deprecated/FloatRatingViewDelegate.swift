import Foundation

@available(*, deprecated: 4.0, message: "Use the Target-Action design pattern from UIControl")
@objc public protocol FloatRatingViewDelegate {
	/// Returns the rating value when touch events end
	@available(*, deprecated: 4.0, message: "Use `addTarget(target:action:for:)` or Storyboard's valueChanged connection")
	@objc optional func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double)
	
	/// Returns the rating value as the user pans
	@available(*, deprecated: 4.0, message: "Use `addTarget(target:action:for:)` or Storyboard's valueChanged connection and set `isContinuous` to `true`")
	@objc optional func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double)
}

