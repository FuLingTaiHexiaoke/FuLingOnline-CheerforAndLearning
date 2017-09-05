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

//
//transform.scale = 比例轉換
//
//transform.scale.x = 闊的比例轉換
//
//transform.scale.y = 高的比例轉換
//
//transform.rotation.z = 平面圖的旋轉
//
//opacity = 透明度
//
//margin = 布局
//
//zPosition = 翻转
//
//backgroundColor = 背景颜色
//
//cornerRadius = 圆角
//
//borderWidth = 边框宽
//
//bounds = 大小
//
//contents = 内容
//
//contentsRect = 内容大小
//
//cornerRadius = 圆角
//
//frame = 大小位置
//
//hidden = 显示隐藏
//
//mask
//
//masksToBounds
//
//opacity
//
//position
//
//shadowColor
//
//shadowOffset
//
//shadowOpacity
//
//shadowRadius
//
//作者：iOS_windKing
//链接：http://www.jianshu.com/p/d42012d3588c
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
