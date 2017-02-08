//
//  UIImage+EmotionExtension.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "UIImage+EmotionExtension.h"

@implementation UIImage (EmotionExtension)

+(UIImage*)ImageWithName:(NSString*)name{
    NSString *imagePath = [[NSBundle bundleWithPath:[UIImage emotionBundlePath]] pathForResource:name ofType:@"png"inDirectory:@"EmotionItems/BasicEmotionImages"];
    if (!imagePath) {
        imagePath = [[NSBundle bundleWithPath:[UIImage emotionBundlePath]] pathForResource:name ofType:@"png"inDirectory:@"EmotionGroup"];
    }
    return [UIImage imageWithContentsOfFile:imagePath];
}

+(NSString*)emotionBundlePath{
    static   NSString *emotionBundlePath=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emotionBundlePath  = [[NSBundle mainBundle] pathForResource:@"FLXKEmotionResouceBundle" ofType:@"bundle"];
    });
    return emotionBundlePath;
}


@end
