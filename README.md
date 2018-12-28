# RatingControl
A simple `@IBDesignable` rating control for iOS written in Swift. Supports whole, half or floating point values.

![iOS Demo](https://user-images.githubusercontent.com/5610904/49809977-470d8400-fd71-11e8-92fe-456c090be727.gif)

## Installation
Framework is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your **Podfile**:

```ruby
pod 'RatingControl', '~> 4.0.1'
```

Framework is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your **Cartfile**:
```
github "Sorix/RatingControl" ~> 4.0.1
```

## Usage
You can add rating view through Interface Builder, just drag new *View* object to a view and set class and module to `RatingControl`.

RatingControl is a subclass of `UIControl`.

You can configure almost everything in a storyboard.

<img height="300" alt="Storyboard configuration of control" src="https://user-images.githubusercontent.com/5610904/49812013-81792000-fd75-11e8-9af7-e3b790b4f293.png">

In a code you can additionally configure:
```swift
/// Float rating view type
var type: FloatRatingViewType = .wholeRatings

/// If control is not enabled, it can't be changed with user interaction
var isEnabled: Bool = true
```

To respond on events you may use **storyboard**'s `@IBAction` connection. Also you can do it in the code:

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  floatRatingView.addTarget(self, action: #selector(ratingChanged(_:)), for: .valueChanged)
}

func ratingChanged(_ sender: RatingControl) {
  print("New rating: \(sender.rating)")
}
```

### Tint color
You can apply custom color to images, to do that:
  1. Go to your assets and select empty and full images.
  2. At attribute inspector (on the right side) choose:
     > Render as: **Template Image**
  3. Set desired tint color at RatingControl or use default tint color.

## Author
- Current maintainer: [Sorix](https://github.com/Sorix)
- Original author and repo: [glenyi/FloatRatingView](https://github.com/glenyi/FloatRatingView)
