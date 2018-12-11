# RatingControl
A simple `@IBDesignable` rating control for iOS written in Swift. Supports whole, half or floating point values.

![iOS Demo](https://user-images.githubusercontent.com/5610904/49809977-470d8400-fd71-11e8-92fe-456c090be727.gif)

## Installation
**FloatingRatingView** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RatingControl', '~> 3.5'
```

## Usage
You can add rating view through Interface Builder, just drag new *View* object to a view and set class and module to `RatingControl`.

RatingControl is a subclass of `UIControl`.

You can configure almost everything in a storyboard.

![Storyboard configuration of control](https://user-images.githubusercontent.com/5610904/49812013-81792000-fd75-11e8-9af7-e3b790b4f293.png)

In a code you can additionally configure:
```swift
/// Float rating view type
var type: FloatRatingViewType = .wholeRatings

/// If control is not enabled, it can't be changed with user interaction
var isEnabled: Bool = true
```

To respond on events you may use storyboard's value changed connection to `@IBAction` or do it in only in code:

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  floatRatingView.addTarget(self, action: #selector(ratingChanged(_:)), for: .valueChanged)
}

func ratingChanged(_ sender: RatingControl) {
  print("New rating: \(sender.rating)")
}
```

## Author
- Current maintainer: [Sorix](https://github.com/Sorix)
- Original author and repo: [glenyi/FloatRatingView](https://github.com/glenyi/FloatRatingView)
