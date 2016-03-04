//
//  FirstViewController.m
//  LHTabBarBadge
//
//  Created by 陆晖 on 16/3/4.
//  Copyright © 2016年 mluhui. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+LHTabBarBadge.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.badgeViewVisible = YES;
    self.badgeCenter = ^CGPoint(UITabBar *tabBar, UIView *badgeView, CGFloat tabItemWdith, CGFloat tabIndex) {
        return CGPointMake(tabItemWdith*(tabIndex+0.5) + 10, 12);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
