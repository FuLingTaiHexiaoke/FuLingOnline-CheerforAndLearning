//
//  FLXKFLXKStyleManager.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKStyleManager.h"
#import "UIColor+Custom.h"

static FLXKStyleManager* _styleManager = nil;

@implementation FLXKStyleManager
+ (void)setSharedStyleManager:(FLXKStyleManager*)styleManger {
    _styleManager = styleManger;
}

- (void)applyStyleToWindow:(UIWindow*)window {
    window.backgroundColor = [UIColor whiteColor];
    [[UIButton appearance] setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    [[UIButton appearance] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
//    UIImage* backChevron = [UIImage wmf_imageFlippedForRTLLayoutDirectionNamed:@"chevron-left"];
//    [[UINavigationBar appearance] setBackIndicatorImage:backChevron];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backChevron];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.305 green:0.305 blue:0.296 alpha:1]];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UITabBar appearance] setTranslucent:NO];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"clear.png"]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar-shadow"]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor customGray] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor customRed] }
                                             forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:[UIColor customRed]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTintColor:[UIColor blueTintColor]];
    
    [[UISwitch appearance] setOnTintColor:[UIColor customGreen]];
}
@end
