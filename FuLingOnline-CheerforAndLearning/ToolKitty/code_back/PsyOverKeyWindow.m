//
//  PsyOverKeyWindow.m
//  XKTestMathSecond
//
//  Created by 肖科 on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PsyOverKeyWindow.h"
#import "AppDelegate.h"
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

@implementation PsyOverKeyWindow

-(instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
    UIView* hitedView=[super hitTest:point withEvent:event];
    if ([hitedView isKindOfClass:NSClassFromString(@"")]) {
        return hitedView;
    }
    else {
        return nil;
    }
    return nil;
}

@end
