//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (EmotionExtension)
- (NSString *)getPlainString;
+(instancetype)attributedStringWithPlainString:(NSString *)plainString;
@end
