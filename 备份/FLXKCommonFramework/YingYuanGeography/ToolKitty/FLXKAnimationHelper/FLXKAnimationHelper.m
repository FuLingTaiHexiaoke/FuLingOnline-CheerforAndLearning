//
//  FLXKAnimationHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKAnimationHelper.h"

@implementation FLXKAnimationHelper

+(void)scale{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=2;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:4.0];
//    [sender.imageView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}


////模拟地球公转
//+ (void)addEarthRotateAroundSoloar:(UIView *)baseView roundedRect:(CGRect)rotateFrame earthBtn:(UIView*)earthBtn{
//    //公转路径
//    UIBezierPath * path=[UIBezierPath bezierPathWithRoundedRect:CGRectInset(rotateFrame, 100, 100) cornerRadius:300];
//    
//    CAShapeLayer* layer=[CAShapeLayer layer];
//    layer.frame=baseView.frame;
//    layer.path=path.CGPath;
//    layer.strokeStart=0.0;
//    layer.strokeEnd=1.0;
//    layer.lineWidth=10.0;
//    layer.strokeColor=[UIColor redColor].CGColor;
//    layer.fillColor=[UIColor clearColor].CGColor;
//    [baseView.layer addSublayer:layer];
//    
//    //沿着公转路径添加动画
//    CAKeyframeAnimation * anim=[CAKeyframeAnimation animation];
//    anim.keyPath=@"position";
//    anim.path=path.CGPath;
//    anim.calculationMode = kCAAnimationPaced;
//    anim.rotationMode = kCAAnimationRotateAutoReverse;
//    anim.fillMode=kCAFillModeForwards;
//    anim.duration=100.0;
//    anim.repeatCount=CGFLOAT_MAX;
//    anim.removedOnCompletion = NO;
//    // 始终保持最新的效果
//    anim.fillMode = kCAFillModeForwards;
//    
//    [earthBtn.layer addAnimation:anim forKey:[earthBtn description]];
//}

////模拟地球自转
//+ (void)addEarthRotateBySelf:(UIView*)earthBtn{
//    CABasicAnimation * anim1=[CABasicAnimation animation];
//    anim1.keyPath=@"transform.rotation.z";
//    anim1.fromValue=[NSNumber numberWithFloat:0.0f];
//    anim1.toValue=[NSNumber numberWithFloat:(M_PI*2)];
//    anim1.removedOnCompletion=NO;
//    anim1.duration=3.0;
//    anim1.repeatCount=CGFLOAT_MAX;
//    anim1.fillMode=kCAFillModeForwards;
//    [earthBtn.layer addAnimation:anim1 forKey:[earthBtn description]];
//}


//画任意椭圆
//-(UIBezierPath *)drawBezierPath:(CGFloat)x{
//    CGFloat radius = self.bounds.size.height/2 - 3;
//    CGFloat right = self.bounds.size.width-x;
//    CGFloat left = x;
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    bezierPath.lineJoinStyle = kCGLineJoinRound;
//    bezierPath.lineCapStyle = kCGLineCapRound;
//    //右边圆弧
//    [bezierPath addArcWithCenter:CGPointMake(right, self.bounds.size.height/2) radius:radius startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
//    //左边圆弧
//    [bezierPath addArcWithCenter:CGPointMake(left, self.bounds.size.height/2) radius:radius startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:YES];
//    //闭合弧线
//    [bezierPath closePath];
//    
//    return bezierPath;
//}
//

//画圆的一个线段
//-(UIBezierPath *)drawLoadingBezierPath{
//    CGFloat radius = self.bounds.size.height/2 - 3;
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    [bezierPath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:M_PI/2 endAngle:M_PI/2+M_PI/2 clockwise:YES];
//    return bezierPath;
//}
//
////画圆
//-(UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius{
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    /**
//     *  center: 弧线中心点的坐标
//     radius: 弧线所在圆的半径
//     startAngle: 弧线开始的角度值
//     endAngle: 弧线结束的角度值
//     clockwise: 是否顺时针画弧线
//     *
//     */
//    [bezierPath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    return bezierPath;
//}

////接收点击事件，暂停动画
//- (void)pauseAnimations{
//    [self.animationBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self pauseLayer:obj.layer];
//    }];
//}
//
////取消接收点击事件，重新开始动画
//- (void)resumeAnimations{
//    [self.animationBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self resumeLayer:obj.layer];
//    }];
//}

//动画的暂停实现方法
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed= 0.0;
    
    layer.timeOffset= pausedTime;
}

//动画的恢复方法

-(void)resumeLayer:(CALayer*)layer
{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    
    layer.speed= 1.0;
    
    layer.timeOffset= 0.0;
    
    layer.beginTime= 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    
    layer.beginTime= timeSincePause;
    
}

@end
