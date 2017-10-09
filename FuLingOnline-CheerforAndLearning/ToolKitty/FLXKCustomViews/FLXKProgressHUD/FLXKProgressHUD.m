//
//  FLXKProgressHUD.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/29.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKProgressHUD.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@implementation FLXKProgressHUD

/**
 @abstract 成功时的提示，有一个勾显示出来
 @param tip 显示标签提示文字
 */
+(void)showSuccessWithTip:(NSString*)tip{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self getTopMostVC].view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:[self getTopMostVC].view animated:YES];
        hud.backgroundView.color=[UIColor colorWithWhite:0.0f alpha:0.35];
        //        FBTweakValue(@"FLXKProgressHUD", @"showLoadingWithTip", @"alpha", 0.35)
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"FLXKProgressHUD_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = tip;
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

/**
 @abstract 错误时的提示，有一个勾显示出来
 @param tip 显示标签提示文字
 */
+(void)showErrorWithTip:(NSString*)tip {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self getTopMostVC].view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:[self getTopMostVC].view animated:YES];
        hud.backgroundView.color=[UIColor colorWithWhite:0.0f alpha:0.35];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"FLXKProgressHUD_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = tip;
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

/**
 @abstract 信息提示提示，圆圈里面有一个感叹号
 @param tip 显示标签提示文字
 */
+(void)showInfoWithTip:(NSString*)tip {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self getTopMostVC].view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:[self getTopMostVC].view animated:YES];
        hud.backgroundView.color=[UIColor colorWithWhite:0.0f alpha:0.35];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"FLXKProgressHUD_info"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = tip;
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

/**
 @abstract 不停旋转提示
 @param tip 显示标签提示文字
 */
+(void)showLoadingWithTip:(NSString*)tip{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self getTopMostVC].view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:[self getTopMostVC].view animated:YES];
        hud.backgroundView.color=[UIColor colorWithWhite:0.0f alpha:0.35];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = tip;
        [hud hideAnimated:YES afterDelay:60*10.f];
    });
}

/**
 @abstract 停止提示
 @param delayTime 延时时间
 */
+(void)dismissWithDelay:(CGFloat)delayTime{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self getTopMostVC].view];
    if (hud) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES afterDelay:delayTime];
        });
    }
}

/**
 得到当前显示的VC
 */
+ (UIViewController *)getTopMostVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *appRootVC =window.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
@end
