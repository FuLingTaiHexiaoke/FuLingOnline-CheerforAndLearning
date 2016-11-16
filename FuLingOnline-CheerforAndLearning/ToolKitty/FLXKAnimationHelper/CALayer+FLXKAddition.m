//
//  CALayer+FLXKAddition.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

//dignostic
#import <Tweaks/FBTweakInline.h>
#import "FBTweakViewController.h"


#import "CALayer+FLXKAddition.h"


#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式



@implementation CAShapeLayer (FLXKAddition)

#pragma mark - Create Layer Animation

//圆形定时器动画
-(void)createClockTickCircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock {
    CAShapeLayer *shapeLayer = self;
    shapeLayer.frame =frame;
    UIBezierPath *path = [CAShapeLayer getClockTickCirclePathWithFrame:frame];
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
    pathAnima.repeatCount=1;
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [shapeLayer addAnimation:pathAnima forKey:@"ClockTickCircleAmination"];
}


//涪陵印象动画
-(void)createFuLingMemoryAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
    CAShapeLayer *shapeLayer = self;
    shapeLayer.frame =frame;
    UIBezierPath *path = [CAShapeLayer getFuLingMemoryPathWithFrame:frame];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeEnd = 0.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [viewContainer.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=FBTweakValue(@"Animation", @"LaunchViewController",  @"FuLingMemory_repeatCount", 5.0);
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [shapeLayer addAnimation:pathAnima forKey:@"FuLingMemoryAmination"];
}


//水流动动画
-(void)createFlowingWaterAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
    CAShapeLayer *shapeLayer = self;
    shapeLayer.frame = CGRectMake(0, 0, 80, 30);
    UIBezierPath *path = [CAShapeLayer getFlowingWaterPathWithFrame: shapeLayer.frame];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeEnd = 1.0f;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    [viewContainer.layer addSublayer:shapeLayer];
    
    CAKeyframeAnimation* pathAnima=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnima.duration = duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.path=[[CAShapeLayer getFlowingWaterRoutePathWithFrame:frame]CGPath];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=FBTweakValue(@"Animation", @"LaunchViewController",  @"FlowingWater_repeatCount", 5.0);
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [shapeLayer addAnimation:pathAnima forKey:@"FlowingWaterAmination"];
}


#pragma mark - Make UIBezierPaths

+(UIBezierPath*)getClockTickCirclePathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width/2, 0)];
    [path addArcWithCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:M_PI/2*3 endAngle:-M_PI/2 clockwise:NO];
    return path;
}

+(UIBezierPath*)getFuLingMemoryPathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, height-50)];
    [path  addQuadCurveToPoint:CGPointMake(4*width/5, 0) controlPoint:CGPointMake(width/2, height/2)];
    
    [path moveToPoint:CGPointMake(width/3, height+1)];
    [path  addQuadCurveToPoint:CGPointMake(4*width/5, height) controlPoint:CGPointMake(width/3*2, height/2)];
    
    [path moveToPoint:CGPointMake(width, height)];
    [path  addQuadCurveToPoint:CGPointMake(width, 20) controlPoint:CGPointMake(4*width/5, height/2)];
    
    [path moveToPoint:CGPointMake(0, height-70)];
    [path addCurveToPoint:CGPointMake(3*width/5, 10) controlPoint1:CGPointMake(1*width/5,20) controlPoint2:CGPointMake(2*width/5,10)];
    
    return path;
}

+(UIBezierPath*)getFlowingWaterPathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    
//    [path moveToPoint:CGPointMake(0, height-30)];
//    [path  addQuadCurveToPoint:CGPointMake(5*width/6, 0) controlPoint:CGPointMake(width/2, height/2)];
    
    [path moveToPoint:CGPointMake(0, height/2)];
    [path addCurveToPoint:CGPointMake(0, height/2) controlPoint1:CGPointMake(1*width/4,0) controlPoint2:CGPointMake(1*width/4,height)];
    
    return path;
}

+(UIBezierPath*)getFlowingWaterRoutePathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, height-30)];
    [path  addQuadCurveToPoint:CGPointMake(width, 0) controlPoint:CGPointMake(width/2, height)];
    
    return path;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.animationDidStopBlock();
}

@end
