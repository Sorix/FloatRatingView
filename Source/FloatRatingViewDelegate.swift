import Foundation

@available(*, deprecated, message: "Use the Target-Action design pattern, like it is used at UIButton")
public protocol FloatRatingViewDelegate: class {
	/// Returns the rating value when touch events end
	func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double)
	
	/// Returns the rating value as the user pans
	@available(*, deprecated, message: "To receive continuous updates set isContinuous to true")
	func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double)
}


public extension FloatRatingViewDelegate {
	func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {}
	func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {}
}
