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
    //    NSString *imagePath = [[NSBundle bundleWithPath:[UIImage emotionBundlePath]] pathForResource:name ofType:@"png"inDirectory:@"EmotionItems/BasicEmotionImages"];
    //    if (!imagePath) {
    //        imagePath =[[NSBundle bundleWithPath:[UIImage emotionBundlePath]] pathForResource:name ofType:@"gif"inDirectory:@"EmotionItems/GifImageEmotions"];
    //    }
    //    if (!imagePath) {
    //        imagePath = [[NSBundle bundleWithPath:[UIImage emotionBundlePath]] pathForResource:name ofType:@"png"inDirectory:@"EmotionGroup"];
    //    }
    //    return [UIImage imageWithContentsOfFile:imagePath];
    //    return [UIImage imageNamed:name];
    
    UIImage* image=  [[UIImage emotionReuseImagesDictionary]objectForKey:name];
    if (!image ) {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        if (!imagePath) {
            imagePath =[[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        }
        image=[UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            [[UIImage emotionReuseImagesDictionary] setObject:image forKey:name];
        }
    }
    return image;
}

+(NSString*)emotionBundlePath{
    static   NSString *emotionBundlePath=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emotionBundlePath  = [[NSBundle mainBundle] pathForResource:@"FLXKEmotionResouceBundle" ofType:@"bundle"];
    });
    return emotionBundlePath;
}

+( NSMutableDictionary<NSString*,UIImage*>*)emotionReuseImagesDictionary{
    static  NSMutableDictionary<NSString*,UIImage*>* reuseImagesDictionary=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reuseImagesDictionary  = [NSMutableDictionary dictionary];
    });
    return reuseImagesDictionary;
}
@end
