import UIKit

extension Collection where Iterator.Element: UIImageView {
	/// - Parameter visibleNumberOfImages: if number is not integer, part of image will be masked
	func setVisible(numberOfImages visibleNumberOfImages: Double) {
		for (i, imageView) in self.enumerated() {
			if visibleNumberOfImages >= Double(i+1) {
				imageView.layer.mask = nil
				imageView.isHidden = false
			} else if visibleNumberOfImages > Double(i) && visibleNumberOfImages < Double(i+1) {
				// Set mask layer for full image
				let maskLayer = CALayer()
				maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(visibleNumberOfImages-Double(i))*imageView.frame.size.width, height: imageView.frame.size.height)
				maskLayer.backgroundColor = UIColor.black.cgColor
				imageView.layer.mask = maskLayer
				imageView.isHidden = false
			} else {
				imageView.layer.mask = nil
				imageView.isHidden = true
			}
		}
	}
}
