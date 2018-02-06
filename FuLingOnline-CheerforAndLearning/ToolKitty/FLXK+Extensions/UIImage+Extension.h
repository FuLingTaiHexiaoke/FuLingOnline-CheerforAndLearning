//
//  UIImage+Extension.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
- (UIImage*) imageWithName:(NSString*)name;

- (UIImage *)hyb_cropEqualScaleImageToSize:(CGSize)size;

- (UIImage *)hyb_addCornerRadius:(CGFloat)cornerRadius;


@end
