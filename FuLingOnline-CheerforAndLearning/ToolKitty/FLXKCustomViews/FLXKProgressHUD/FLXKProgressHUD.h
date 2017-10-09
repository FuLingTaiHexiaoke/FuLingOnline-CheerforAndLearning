//
//  FLXKProgressHUD.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/29.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKProgressHUD : NSObject

/**
 @abstract 成功时的提示，有一个勾显示出来
 @param tip 显示标签提示文字
 */
+(void)showSuccessWithTip:(NSString*)tip;

/**
 @abstract 错误时的提示，有一个勾显示出来
 @param tip 显示标签提示文字
 */
+(void)showErrorWithTip:(NSString*)tip;

/**
 @abstract 不停旋转提示
 @param tip 显示标签提示文字
 */
+(void)showLoadingWithTip:(NSString*)tip;

/**
 @abstract 信息提示提示，圆圈里面有一个感叹号
 @param tip 显示标签提示文字
 */
+(void)showInfoWithTip:(NSString*)tip;

/**
 @abstract 停止提示
 @param delayTime 延时时间
 */
+(void)dismissWithDelay:(CGFloat)delayTime;
@end
