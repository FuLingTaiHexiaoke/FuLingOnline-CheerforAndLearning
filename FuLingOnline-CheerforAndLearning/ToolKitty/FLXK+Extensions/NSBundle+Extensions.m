//
//  NSBundle+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/2/8.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "NSBundle+Extensions.h"

@implementation NSBundle (Extensions)

+(NSBundle*)bundleWithName:(NSString*)bundleName{
       return [NSBundle bundleWithPath: [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
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
