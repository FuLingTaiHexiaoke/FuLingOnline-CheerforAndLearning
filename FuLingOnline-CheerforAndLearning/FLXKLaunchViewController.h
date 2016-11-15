//
//  FLXKLaunchViewController.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLXKLaunchViewController : UIViewController

+(FLXKLaunchViewController*)initialAppViewControllerFromDefaultStoryBoard;

- (void)launchAppInWindow:(UIWindow*)window;

//判断是否加载公告页
+(void)checkIfNeedloadAdvertisement;
//请求广告图片
+(void)loadAdvertisementImages;
//加载倒计时动画
//加载底部视图
@end
