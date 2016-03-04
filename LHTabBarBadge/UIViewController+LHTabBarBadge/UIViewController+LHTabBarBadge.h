//
//  UIViewController+LHBadgeView.h
//  LHTabBarBadge
//
//  Created by 陆晖 on 16/3/4.
//  Copyright © 2016年 mluhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGPoint(^LHBadgeCenter)(UITabBar *tabBar, UIView *badgeView, CGFloat tabItemWdith, CGFloat tabIndex);
@interface UIViewController (LHTabBarBadge)

@property (nonatomic, getter=isBadgeViewVisible) BOOL badgeViewVisible;
@property (copy, nonatomic) LHBadgeCenter badgeCenter;


- (void)setTabBarIndex:(NSInteger)index;
- (NSInteger)tabBarIndex;
- (void)setBadgeView:(UIView *)badgeView;
- (UIView *)badgeView;

@end
