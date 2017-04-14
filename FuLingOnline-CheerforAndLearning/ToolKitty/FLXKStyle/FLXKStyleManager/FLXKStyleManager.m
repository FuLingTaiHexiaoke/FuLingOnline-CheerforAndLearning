//
//  FLXKFLXKStyleManager.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKStyleManager.h"
#import "UIColor+Extensions.h"

static FLXKStyleManager* _styleManager = nil;

@implementation FLXKStyleManager
+ (void)setSharedStyleManager:(FLXKStyleManager*)styleManger {
    _styleManager = styleManger;
}

- (void)applyStyleToWindow:(UIWindow*)window {
    window.backgroundColor = [UIColor whiteColor];
#pragma mark - UIButton
//    [[UIButton appearance] setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
//    [[UIButton appearance] setBackgroundImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
//    [[UIButton appearance] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
#pragma mark - UINavigationBar
    
    //灰色背景
        [[UINavigationBar appearance] setTintColor:RGBA(91, 92, 94, 1.0)];
        [[UINavigationBar appearance] setBarTintColor:RGBA(248, 249, 250, 1.0)];
    
    //橙色背景
//    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //    [[UINavigationBar appearance] setTintColor:RGBA(255, 255, 255, 1.0)];
    //    [[UINavigationBar appearance] setBarTintColor:RGBA(244, 126, 37, 1.0)];
//    [[UINavigationBar appearance] setBarTintColor:RGBA(255, 255, 255, 1.0)];
//    [[UINavigationBar appearance] setTranslucent:YES];

    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btn_navigation_back"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_navigation_back"]];
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
    //    [[UIBarButtonItem appearance] setBackgroundVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
    

    /*
     //在Translucent:YES为透明的情况下，两行代码使navigationBar完全透明。Translucent:NO时，黑色背景
     [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     
     [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setShadowImage:nil];
     */
    
    /*
     //在Translucent:YES为透明的情况下，两行代码使navigationBar完全透明。Translucent:NO时，黑色背景
     [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     
     [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setShadowImage:nil];
     */
    
    
    
#pragma mark - UITabBar

    [[UITabBar appearance] setTranslucent:YES];//设置为YES，就有模糊效果，NO就没有
    [[UITabBar appearance] setBarStyle:UIBarStyleDefault];
//    [[UITabBar appearance] setTranslucent:YES];//设置为YES，就有模糊效果，NO就没有
//    [[UITabBar appearance] setBarStyle:UIBarStyleDefault];
    [[UITabBar appearance] setTintColor:[UIColor customRed]];
    //    [[UITabBar appearance] setBarTintColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    //    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"clear.png"]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar-shadow"]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor customGray] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor customRed] }
                                             forState:UIControlStateSelected];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTintColor:[UIColor blueTintColor]];
    
#pragma mark - UISwitch
    [[UISwitch appearance] setOnTintColor:[UIColor customGreen]];
}
@end
