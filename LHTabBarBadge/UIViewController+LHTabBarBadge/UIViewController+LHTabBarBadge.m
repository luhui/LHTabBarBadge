//
//  UIViewController+LHBadgeView.m
//  LHTabBarBadge
//
//  Created by 陆晖 on 16/3/4.
//  Copyright © 2016年 mluhui. All rights reserved.
//

#import "UIViewController+LHTabBarBadge.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@implementation UIViewController (LHTabBarBadge)

#pragma mark - Accessor

- (void)setTabBarIndex:(NSInteger)index {
    objc_setAssociatedObject(self, @selector(tabBarIndex), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.isBadgeViewVisible) {
        [self updateBadgeViewFrame:self.badgeView];
    }
}

- (NSInteger)tabBarIndex {
    NSNumber *number = objc_getAssociatedObject(self, @selector(tabBarIndex));
    if (number) {
        return [number integerValue];
    } else {
        NSInteger index = -1;
        for (UIViewController *vc in self.tabBarController.viewControllers) {
            ++index;
            if (self == vc) {
                break;
            }
        }
        NSAssert(index != -1, @"cannot found tab index, should use UITabBarController's rootController or use setTabIndex:");
        objc_setAssociatedObject(self, @selector(tabBarIndex), @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return index;
    }
}

- (UIView *)badgeView {
    UIView *view = objc_getAssociatedObject(self, @selector(badgeView));
    if (!view) {
        CGFloat radius = 5;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, radius * 2, radius *2)];
        view.layer.cornerRadius = radius;
        view.backgroundColor = [UIColor redColor];
        view.layer.shouldRasterize = YES;
        objc_setAssociatedObject(self, @selector(badgeView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addUpdateFrameHook:view];
    }
    return view;
}

- (void)setBadgeView:(UIView *)badgeView {
    //clear last badeView
    BOOL isVisible = self.isBadgeViewVisible;
    UIView *prevBadgeView = [self badgeView];
    [self removeUpdateFrameHook:prevBadgeView];
    [prevBadgeView removeFromSuperview];
    
    //add new one
    [badgeView removeFromSuperview];
    objc_setAssociatedObject(self, @selector(badgeView), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addUpdateFrameHook:badgeView];
    [self setBadgeViewVisible:isVisible];
}

- (void)setBadgeViewVisible:(BOOL)badgeViewVisible {
    UIView *badgeView = self.badgeView;
    if (badgeViewVisible && !self.badgeView.superview) {
        [self.tabBarController.tabBar addSubview:badgeView];
    }
    badgeView.hidden = !badgeViewVisible;
}

- (BOOL)isBadgeViewVisible {
    UIView *badgeView = self.badgeView;
    return !badgeView.hidden && !!badgeView.superview;
}

- (void)setBadgeCenter:(LHBadgeCenter)badgeCenter {
    objc_setAssociatedObject(self, @selector(badgeCenter), badgeCenter, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LHBadgeCenter)badgeCenter {
    return objc_getAssociatedObject(self, @selector(badgeCenter));
}

#pragma mark - Utils

- (void)addUpdateFrameHook:(UIView *)view {
    NSError *error;
    __weak typeof(self) weakSelf = self;
    id<AspectToken> token = [view aspect_hookSelector:@selector(didMoveToWindow) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        [weakSelf updateBadgeViewFrame:[info instance]];
    } error:&error];
    NSAssert(error == nil, @"can not hook view for didMoveToWindow, error: %@", error);
    objc_setAssociatedObject(view, @selector(addUpdateFrameHook:), token, OBJC_ASSOCIATION_ASSIGN);
}

- (void)removeUpdateFrameHook:(UIView *)view {
    id<AspectToken> token = objc_getAssociatedObject(view, @selector(addUpdateFrameHook:));
    [token remove];
    objc_setAssociatedObject(view, @selector(addUpdateFrameHook:), nil, OBJC_ASSOCIATION_ASSIGN);
}

- (void)updateBadgeViewFrame:(UIView *)badgeView {
    UITabBar *tabBar = self.tabBarController.tabBar;
    NSUInteger itemCount = MAX(tabBar.items.count, 1);
    NSInteger index = self.tabBarIndex;
    CGFloat tabBarItemWidth = tabBar.itemWidth > 0?:CGRectGetWidth(tabBar.frame)/itemCount;
    CGPoint center;
    if (self.badgeCenter) {
        center = self.badgeCenter(tabBar, badgeView, tabBarItemWidth, index);
    } else {
        center = CGPointMake(tabBarItemWidth * index + tabBarItemWidth/2.0 + 10, 10.0);
    }
    badgeView.center =  center;
}

@end


