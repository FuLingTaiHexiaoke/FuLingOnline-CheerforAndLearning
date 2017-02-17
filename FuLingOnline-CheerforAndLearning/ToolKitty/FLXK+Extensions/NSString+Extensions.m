//
//  NSString+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

-(CGFloat)getAutoHeightWithWidth:(CGFloat)width{
    //init attribute
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : style };
    
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
@end
