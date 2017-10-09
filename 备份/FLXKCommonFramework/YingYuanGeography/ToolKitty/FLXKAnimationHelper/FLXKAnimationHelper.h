//
//  FLXKAnimationHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLXKAnimationHelper : NSObject


//模拟地球公转
//+ (void)addEarthRotateAroundSoloar:(UIView *)baseView roundedRect:(CGRect)rotateFrame earthBtn:(UIView*)earthBtn;

//模拟地球自转
+ (void)addEarthRotateBySelf:(UIView*)earthBtn;
@end
