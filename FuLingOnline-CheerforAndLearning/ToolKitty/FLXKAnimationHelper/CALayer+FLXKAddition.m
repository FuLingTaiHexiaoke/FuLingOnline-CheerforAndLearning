//
//  CALayer+FLXKAddition.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//



#import "CALayer+FLXKAddition.h"


#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式



@implementation CALayer (FLXKAddition)

#pragma mark - Create Layer Animation

//圆形定时器动画
-(void)createClockTickCircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock {
    CAShapeLayer *shapeLayer =(CAShapeLayer *) self;
    shapeLayer.frame =frame;
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
    pathAnima.repeatCount=1;
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [shapeLayer addAnimation:pathAnima forKey:@"ClockTickCircleAmination"];
}


//涪陵印象动画
-(void)createFuLingMemoryAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
    CAShapeLayer *shapeLayer = ( CAShapeLayer *)self;
    shapeLayer.frame =frame;
    UIBezierPath *path = [CALayer getFuLingMemoryPathWithFrame:frame];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeEnd = 0.0f;
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor colorWithRed:FBTweakValue(@"Animation", @"FuLingMemory_strokeColor", @"Red", 0.9, 0.0, 1.0)
                                                               green:FBTweakValue(@"Animation", @"FuLingMemory_strokeColor", @"Green", 0.9, 0.0, 1.0)
                                                                blue:FBTweakValue(@"Animation", @"FuLingMemory_strokeColor", @"Blue", 0.9, 0.0, 1.0)
                                                               alpha:1.0].CGColor;
    
    
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


//水流动动画-水波纹形式
-(void)createFlowingWater_SpindriftAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
    //create particle emitter layer
    CAEmitterLayer *emitterLayer = ( CAEmitterLayer *)self;
    emitterLayer.frame = CGRectMake(0, 0, 20, 20);
    [viewContainer.layer addSublayer:emitterLayer];
    //configure emitter
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0, emitterLayer.frame.size.height / 2.0);
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents=(__bridge id _Nullable)([CALayer getFlowingWater_SpindriftWithSize:CGSizeMake(20, 20)].CGImage);
    cell.birthRate = 10;
    cell.lifetime = 5.0;
    cell.alphaSpeed = -0.4;
    cell.velocity = 20;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI/3;
    //add particle template to emitter
    emitterLayer.emitterCells = @[cell];
    
    CAKeyframeAnimation* pathAnima=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnima.duration = duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.path=[[CALayer getYangtzeFlowingWaterRoutePathWithFrame:frame]CGPath];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=FBTweakValue(@"Animation", @"LaunchViewController",  @"Water_Spind_repeatCount", 5.0);
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [emitterLayer addAnimation:pathAnima forKey:@"FlowingWater_SpindriftAmination"];
    
}

//水流动动画-圆圈形式(长江)
-(void)createFlowingWater_CircleAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration  isYangtze:(BOOL)isYangtze  animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
    //create particle emitter layer
    CAEmitterLayer *emitterLayer = ( CAEmitterLayer *)self;
    emitterLayer.frame = CGRectMake(0, 0, 20, 20);
    [viewContainer.layer addSublayer:emitterLayer];
    //configure emitter
    //    emitterLayer.birthRate=10;
    //    emitterLayer.lifetime=5;
    
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0, emitterLayer.frame.size.height / 2.0);
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    cell.birthRate = 10;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:FBTweakValue(@"Animation", @"Water_CircleColor", @"Red", 0.9, 0.0, 1.0)
                                             green:FBTweakValue(@"Animation", @"Water_CircleColor", @"Green", 0.9, 0.0, 1.0)
                                              blue:FBTweakValue(@"Animation", @"Water_CircleColor", @"Blue", 0.9, 0.0, 1.0)
                                             alpha:1.0].CGColor;

    cell.contents=(__bridge id _Nullable)([CALayer getFlowingWaterWithSize:CGSizeMake(10, 10) withFillColor:cell.color].CGImage );

    //add particle template to emitter
    emitterLayer.emitterCells = @[cell];
    
    CAKeyframeAnimation* pathAnima=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnima.duration = duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    if(isYangtze){
          pathAnima.path=[[CALayer getYangtzeFlowingWaterRoutePathWithFrame:frame]CGPath];
    }
    else{
          pathAnima.path=[[CALayer getWujiangRiverFlowingWaterRoutePathWithFrame:frame]CGPath];
    }
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    pathAnima.repeatCount=FBTweakValue(@"Animation", @"LaunchViewController",  @"Water_Circle_repeatCount", 5.0);
    
    //add delegate and actions
    pathAnima.delegate=self;
    self.animationDidStopBlock=animationDidStopBlock;
    
    [emitterLayer addAnimation:pathAnima forKey:@"FlowingWater_CircleAmination"];
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

+(UIBezierPath*)getYangtzeFlowingWaterRoutePathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, height-30)];
    [path  addQuadCurveToPoint:CGPointMake(width, 0) controlPoint:CGPointMake(width/2, height)];
    
    return path;
}

+(UIBezierPath*)getWujiangRiverFlowingWaterRoutePathWithFrame:(CGRect)frame{
    CGFloat width=   CGRectGetWidth(frame);
    CGFloat height=   CGRectGetHeight(frame);
    UIBezierPath* path=[UIBezierPath bezierPath];
    

    [path moveToPoint:CGPointMake(width-20, height)];
    [path  addQuadCurveToPoint:CGPointMake(width-20, 0) controlPoint:CGPointMake(4*width/5, height/2)];
    
    return path;
}

+(UIImage*)getFlowingWaterWithSize:(CGSize)size withFillColor:(CGColorRef )color{
    
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(ctx, color);
    
    //    CGContextStrokeEllipseInRect(ctx, CGRectMake(0, 0, 10, 10));
    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 10, 10));
    
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*)getFlowingWater_SpindriftWithSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    //    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    //    CGContextStrokeEllipseInRect(ctx, CGRectMake(0, 0, 10, 10));
    //    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 10, 10));
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddArc(ctx,5, 0, 15, 20, M_PI/3, YES);
    CGContextStrokePath(ctx);
    
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.animationDidStopBlock();
}



@end





////水流动动画-水波纹形式
//-(void)createFlowingWater_SpindriftAminationLayerWithFrame:(CGRect)frame inView:(UIView*)viewContainer duration:(CGFloat)duration animationDidStopBlock:(animationDidStopBlock)animationDidStopBlock{
//    CAShapeLayer *shapeLayer = ( CAShapeLayer *)self;
//    shapeLayer.frame = CGRectMake(0, 0, 80, 30);
//    UIBezierPath *path = [CALayer getFlowingWaterPathWithFrame: shapeLayer.frame];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 2.0f;
//    shapeLayer.strokeEnd = 1.0f;
//    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
//    [viewContainer.layer addSublayer:shapeLayer];
//
//    CAKeyframeAnimation* pathAnima=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    pathAnima.duration = duration;
//    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    pathAnima.path=[[CALayer getFlowingWaterRoutePathWithFrame:frame]CGPath];
//    pathAnima.fillMode = kCAFillModeForwards;
//    pathAnima.removedOnCompletion = NO;
//    pathAnima.repeatCount=FBTweakValue(@"Animation", @"LaunchViewController",  @"FlowingWater_repeatCount", 5.0);
//
//    //add delegate and actions
//    pathAnima.delegate=self;
//    self.animationDidStopBlock=animationDidStopBlock;
//
//    [shapeLayer addAnimation:pathAnima forKey:@"FlowingWaterAmination"];
//}