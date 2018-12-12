import UIKit

class ImageViewStorage {
	private(set) var emptyImageViews = [UIImageView]()
	private(set) var fullImageViews = [UIImageView]()
	
	init() {}
	
	init(numberOfImages: Int, emptyImage: UIImage?, fullImage: UIImage?, contentMode: UIView.ContentMode) {
		for _ in 0..<numberOfImages {
			let emptyImageView = UIImageView()
			emptyImageView.image = emptyImage
			emptyImageView.contentMode = contentMode
			emptyImageViews.append(emptyImageView)
			
			let fullImageView = UIImageView()
			fullImageView.image = fullImage
			fullImageView.contentMode = contentMode
			fullImageViews.append(fullImageView)
		}
	}
	
	func setContentMode(_ contentMode: UIView.ContentMode) {
		for imageView in allImageViews {
			imageView.contentMode = contentMode
		}
	}
	
	func addImages(to view: UIView) {
		for imageView in allImageViews {
			view.addSubview(imageView)
		}
	}
	
	func removeImageViews(from view: UIView) {
		for imageView in allImageViews {
			imageView.removeFromSuperview()
		}
		
		emptyImageViews.removeAll()
		fullImageViews.removeAll()
	}
	
	func setVisible(numberOfImages: Double) {
		fullImageViews.setVisible(numberOfImages: numberOfImages)
	}
}

extension ImageViewStorage {
	func setEmptyImage(_ image: UIImage?) {
		set(image: image, in: emptyImageViews)
	}
	
	func setFullImage(_ image: UIImage?) {
		set(image: image, in: fullImageViews)
	}
	
	private func set(image: UIImage?, in imageViews: [UIImageView]) {
		for imageView in imageViews {
			imageView.image = image
		}
	}
}

private extension ImageViewStorage {
	var allImageViews: [UIImageView] {
		return emptyImageViews + fullImageViews
	}
}
