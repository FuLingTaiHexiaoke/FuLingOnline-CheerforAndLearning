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

@end
