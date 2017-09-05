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



//实时画线，自适应线条大小
//- (void)layoutSublayer {
//    for (int i = 0; i < _balls.count; i++) {
//        UIView *ball = [_balls objectAtIndex:i];
//        CAShapeLayer *subLayer = [_lines objectAtIndex:i];
//        
//        CGPoint anchorCenter = [[_anchors objectAtIndex:[_balls indexOfObject:ball]] center];
//        CGPoint ballCenter = [ball center];
//        
//        UIBezierPath *path = [[UIBezierPath alloc] init];
//        [path moveToPoint:anchorCenter];
//        [path addLineToPoint:ballCenter];
//        
//        [subLayer removeFromSuperlayer];
//        subLayer.path = path.CGPath;
//        subLayer.lineWidth = 1;
//        subLayer.strokeColor = [UIColor grayColor].CGColor;
//        CGPathRef bound = CGPathCreateCopyByStrokingPath(subLayer.path, nil, subLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, subLayer.miterLimit);
//        subLayer.bounds = CGPathGetBoundingBox(bound);
//        subLayer.position = CGPointMake((anchorCenter.x+ballCenter.x)/2, (anchorCenter.y+ballCenter.y)/2);
//        CGPathRelease(bound);
//        [self.view.layer addSublayer:subLayer];
//    }
//    
//}

@end
