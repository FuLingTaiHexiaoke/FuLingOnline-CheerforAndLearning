//
//  CALayer+FLXKAddition.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (FLXKAddition)

/**
 *  圆形定时器动画,模仿的网易新闻广告业加载倒计时动画效果。
 *
 *  @param frame         the frame of the circle layer
 *  @param viewContainer viewContainer to contain the circle layer
 *  @param duration      the animation duration
 */
+(void)createClockTickCircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration;
@end
