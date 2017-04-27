//
//  NSString+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

//文字固定宽度下，获取动态高度
-(CGFloat)getBoundingHeightWithWidth:(CGFloat)width font:(UIFont*)font {
    //init attribute
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    //get Rect
    CGSize size=CGSizeMake(width, CGFLOAT_MAX);
    CGRect labelRect= [self boundingRectWithSize:size options: (NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil];
    
    //reture height
   return labelRect.size.height;
}


//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)randomText {
    CGFloat length = arc4random() % 150 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@" 测试数据，"];
    }
    
    return str;
}



@end
