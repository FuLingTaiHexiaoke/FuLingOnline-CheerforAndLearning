//
//  UIColor+FLXKStyle.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "UIColor+Custom.h"
#import "UIColor+Extensions.h"

@implementation UIColor (Custom)

+ (instancetype)customGray {
    static UIColor* c = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHex:0x9AA0A7 alpha:1.0];
    });
    return c;
}

+ (instancetype)blueTintColor {
    static UIColor* c = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHue:0.611 saturation:0.75 brightness:0.8 alpha:1];
    });
    return c;
}

+ (instancetype)customGreen {
    static UIColor* c = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHex:0x00AF89 alpha:1.0];
    });
    return c;
}

+ (instancetype)customRed {
    static UIColor* c = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [UIColor colorWithHex:0xFF6347 alpha:1.0];
    });
    return c;
}

@end
