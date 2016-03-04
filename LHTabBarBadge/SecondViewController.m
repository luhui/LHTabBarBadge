//
//  SecondViewController.m
//  LHTabBarBadge
//
//  Created by 陆晖 on 16/3/4.
//  Copyright © 2016年 mluhui. All rights reserved.
//

#import "SecondViewController.h"
#import "PPDragDropBadgeView.h"
#import "UIViewController+LHTabBarBadge.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
