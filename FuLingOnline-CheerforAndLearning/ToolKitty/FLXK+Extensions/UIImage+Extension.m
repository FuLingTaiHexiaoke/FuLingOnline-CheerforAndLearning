//
//  UIImage+Extension.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage*) imageWithName:(NSString*)name {
    UIImage * value;
    if (nil != name) {
        value = [UIImage imageNamed:name];
        if (nil == value) {
            NSString * jpgName = [NSString stringWithFormat:@"%@.jpg", name];
            value = [UIImage imageNamed:jpgName];
        }
    }
    return value;
}
@end
