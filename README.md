# ZSNavigationBar

ZSNavigationBar uses category to allow you change UINavigationBar appearance dynamically.(supported iOS 11+)

### Installation

#### CocoaPods

- **Swift：**

1. Add `pod 'ZSNavigationBar'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import `ZSNavigationBar`.

- **Objective-c：**

1. Add `pod 'ZSNavigationBar-oc'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import `ZSNavigationBar`.

#### Manually

1. Add all files under `Source-oc` or `Source-swift` folder.
2. Link with required frameworks: `UIKit`.
3. If you use oc version, just import `UINavigationBar+custom.h`.

### Requirements

- iOS 8+
- Xcode 9+
- swift 3.0+
- Objective-c

### Usage

- **Swift：**

The category includes several methods that helps to change UINavigationBar's appearance dynamically:

```swift
func setCustomBackgroundColor(_ backgroundColor: UIColor)
func setCustomTranslationY(translationY: CGFloat)
func reset()
```

And usually in `viewDidDisappear`, you should call this method to avoid any side effects:

```swift
override func viewDidDisappear(_ animated: Bool) {
  super.viewDidDisappear(animated)
  self.navigationController?.navigationBar.reset()
}
```

- **Objective-c：**

First, import this lib:

```Objectivec
#import "UINavigationBar+Custom.h"
```

The category includes several methods that helps to change UINavigationBar's appearance dynamically

```Objectivec
- (void)zs_setBackgroundColor:(UIColor *)backgroundColor;
- (void)zs_setTranslationY:(CGFloat)translationY;
- (void)zs_reset;
```

And usually in `viewDidDisappear`, you should call this method to avoid any side effects:

```Objectivec
- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.navigationController.navigationBar zs_reset];
}
```

### License

ZSNavigationBar is available under the MIT license. See the LICENSE file for more info.