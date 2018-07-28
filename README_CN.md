# ZSNavigationBar[中文说明](https://github.com/ZakariyyaSv/ZSNavigationBar/blob/master/README_CN.md)

ZSNavigationBar 使用分类来允许你动态修改 UINaivegationBar 的外观。

## 安装

### CocoaPods

- **Swift：**

1. 将 `pod 'ZSNavigationBar'` 添加到 Podfile 中
2. 执行 `pod install` 或者 `pod update` 命令
3. 导入 `ZSNavigationBar`

- **Objective-c：**

1. 将 `pod 'ZSNavigationBar-oc'` 添加到 Podfile 中
2. 执行 `pod install` 或者 `pod update` 命令
3. 导入 `ZSNavigationBar`

### 手动安装

1. 将 `Source-oc` 或者 `Source-swift` 目录下的所有文件添加到你的项目中
2. 链接必要的框架：`UIKit`
3. 如果你使用的是 OC 版本，导入 `UINavigationBar+custom.h`

## 要求

- iOS 8+
- Xcode 9+
- swift 3.0+
- Objective-c

## 用法

- **Swift：**

此分类包含一些方法用来动态修改 UINavigaitonBar 的外观：

```swift
func setCustomBackgroundColor(_ backgroundColor: UIColor)
func setCustomTranslationY(translationY: CGFloat)
func reset()
```

通常，你应该在 `viewDidDisappear` 方法中调用下面的方法来避免一些副作用：

```swift
override func viewDidDisappear(_ animated: Bool) {
  super.viewDidDisappear(animated)
  self.navigationController?.navigationBar.reset()
}
```

- **Objective-c：**

首先，导入此库：

```Objectivec
#import "UINavigationBar+Custom.h"
```

此分类包含一些方法用来动态修改 UINavigaitonBar 的外观：

```Objectivec
- (void)zs_setBackgroundColor:(UIColor *)backgroundColor;
- (void)zs_setTranslationY:(CGFloat)translationY;
- (void)zs_reset;
```

通常，你应该在 `viewDidDisappear` 方法中调用下面的方法来避免一些副作用：

```Objectivec
- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.navigationController.navigationBar zs_reset];
}
```

## 许可证

ZSNavigationBar 使用 MIT 许可证，详情见 LICENSE 文件。