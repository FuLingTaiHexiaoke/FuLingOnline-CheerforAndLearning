//
//  EmojiTextAttachment.m
//  InputEmojiExample
//
//  Created by zorro on 15/3/7.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "EmojiTextAttachment.h"

@implementation EmojiTextAttachment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
//    return CGRectMake(0, 0, _emojiSize.width, _emojiSize.height);
//     return CGRectMake(0, 0, _emojiSize.width, lineFrag.size.height);
        return CGRectMake(0, -lineFrag.size.height/5, lineFrag.size.height, lineFrag.size.height);
}
@end
