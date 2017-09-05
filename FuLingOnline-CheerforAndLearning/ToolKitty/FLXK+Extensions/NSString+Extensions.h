//
//  NSString+Extensions.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIFont;

@interface NSString (Extensions)
//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;

+ (NSString *)randomText;

//文字固定宽度下，获取动态高度
-(CGFloat)getBoundingHeightWithWidth:(CGFloat)width font:(UIFont * )font;

//将数字1，2，3转化成A,B,C
- (NSString*)convertNumToCharacter:(NSInteger)number;
@end
