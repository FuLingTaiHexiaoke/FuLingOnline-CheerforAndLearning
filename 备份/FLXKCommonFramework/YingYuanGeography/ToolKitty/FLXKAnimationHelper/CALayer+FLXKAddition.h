//
//  CALayer+FLXKAddition.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef void(^animationDidStopBlock)(void);

@interface CALayer (FLXKAddition)

@property(nonatomic)animationDidStopBlock animationDidStopBlock;

/**
 *  圆形定时器动画,模仿的网易新闻广告业加载倒计时动画效果。
 *
 *  @param frame         the frame of the circle layer
 *  @param viewContainer viewContainer to contain the circle layer
 *  @param duration      the animation duration
 */
-(void)createClockTickCircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock;

//涪陵印象动画
-(void)createFuLingMemoryAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock;

//水流动动画-水波纹形式
-(void)createFlowingWater_SpindriftAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock;

//水流动动画-圆圈形式(长江)
-(void)createFlowingWater_CircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration  isYangtze:(BOOL)isYangtze  animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock;
@end
