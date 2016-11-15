//
//  CALayer+FLXKAddition.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "CALayer+FLXKAddition.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

typedef void(^animationDidStopBlock)(void);

@implementation CALayer (FLXKAddition)

//圆形定时器动画
+(void)createClockTickCircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame =frame;
    //UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
    UIBezierPath *path = [CALayer getClockTickCirclePathWithFrame:frame];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeEnd = 1.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [viewContainer.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=100;
    pathAnima.delegate=self;
    
    [shapeLayer addAnimation:pathAnima forKey:@"ClockTickCircleAmination"];
}

+(UIBezierPath*)getClockTickCirclePathWithFrame:(CGRect)frame{
    
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width/2, 0)];
    [path addArcWithCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:M_PI/2*3 endAngle:-M_PI/2 clockwise:NO];
    return path;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

@end
