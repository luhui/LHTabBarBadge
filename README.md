# LHTabBarBadge
easy way to add a custom badge view to UITabBarController

### Usage

#### Use default red dot
just add the code to your `rootViewController` of `UITabBarController` 
```objc
- (void)awakeFromNib {
  self.badgeViewVisible = YES;
}
```

#### Use custom view

```objc
- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat width = 15;
    PPDragDropBadgeView *badgeView = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    badgeView.text = @"8";
    badgeView.hiddenWhenZero = YES;
    badgeView.fontSizeAutoFit = YES;
    
    self.badgeView = badgeView;
    self.badgeViewVisible = YES;
}
```

#### For more detail

see the sample code

### Configure

#### CocoaPods

* add `pod 'UIViewController+LHTabBarBadge'` to your podfile
* run `pod install` in command line

#### Manual
* Checkout LHTabBarBadge from github.
* Copy UIViewController+LHTabBarBadge folder to your project.
* Done.

### License
The code follows MIT Lisence.
