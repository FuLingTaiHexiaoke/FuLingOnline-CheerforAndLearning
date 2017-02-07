//
//  EmojiTextAttachment.m
//  InputEmojiExample
//
//  Created by zorro on 15/3/7.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "EmotionTextAttachment.h"

@implementation EmotionTextAttachment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
        return CGRectMake(0, -lineFrag.size.height/5, lineFrag.size.height, lineFrag.size.height);
}
@end
