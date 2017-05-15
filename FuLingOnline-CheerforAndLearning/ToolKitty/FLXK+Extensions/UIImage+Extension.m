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


//// 等比缩放
//- (UIImage *)hyb_cropEqualScaleImageToSize:(CGSize)size {
//    CGFloat scale =  [UIScreen mainScreen].scale;
//
//  UIGraphicsBeginImageContextWithOptions(size, YES, scale);
//
//  CGSize aspectFitSize = CGSizeZero;
//  if (self.size.width != 0 && self.size.height != 0) {
//    CGFloat rateWidth = size.width / self.size.width;
//    CGFloat rateHeight = size.height / self.size.height;
//
//    CGFloat rate = MIN(rateHeight, rateWidth);
//    aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
//  }
//
//
//  [self drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
//  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//  UIGraphicsEndImageContext();
//
//  return image;
//}

// 非等比缩放
- (UIImage *)hyb_cropEqualScaleImageToSize:(CGSize)size {
    CGFloat scale =  [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)hyb_addCornerRadius:(CGFloat)cornerRadius {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:cornerRadius];
    CGContextAddPath(c, path.CGPath);
    
    CGContextClip(c);
    [self drawInRect:rect];
    CGContextDrawPath(c, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//
//// 优化前
////  NSString *path = nil;
////  if ([model.headImg hasSuffix:@".png"]) {
////    path = model.headImg;
////  } else {
////    path = [[NSBundle mainBundle] pathForResource:model.headImg ofType:nil];
////  }
////  UIImage *image = [UIImage imageNamed:path];
////  self.headImageView.image = image;
//
//// 优化后
//dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    NSString *path = nil;
//    if ([model.headImg hasSuffix:@".png"]) {
//        path = model.headImg;
//    } else {
//        path = [[NSBundle mainBundle] pathForResource:model.headImg ofType:nil];
//    }
//    UIImage *image = [[UIImage imageNamed:path] hyb_cropEqualScaleImageToSize:self.headImageView.frame.size];
//    // 添加圆角
//    //    image = [image hyb_addCornerRadius:self.headImageView.frame.size.width / 2];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.headImageView setNeedsDisplay];
//        self.headImageView.image = image;
//    });
//});

@end
