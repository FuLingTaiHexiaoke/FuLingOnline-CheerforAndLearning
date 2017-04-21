//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+EmotionExtension.h"

//utilites
#import "EmotionTextAttachment.h"
#import "UIImage+EmotionExtension.h"

//entity
#import "EmotionItem.h"

@implementation NSAttributedString (EmotionExtension)

- (NSString *)getPlainStringtest {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[EmotionTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmotionTextAttachment *) value).emotionName];
                          base += ((EmotionTextAttachment *) value).emotionName.length - 1;
                      }
                  }];
//    UserDefaultsRemoveObjForKey(@"plainString");
//    UserDefaultsSetObjForKey(plainString, @"plainString");
//    NSLog(@"plainString:%@", plainString);
    return plainString;
    
    
}

+(instancetype)attributedStringWithPlainString:(NSString *)plainString{
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:plainString];
    //       static let pattern = "\\[+[a-z]+\\]"
    //    NSString* regex_emoji= @"\\[[\\u4e00-\\u9fa5|a-z|A-Z]+\\]";
    NSString* regex_emoji= @"\\[\\w+\\]";
    //    NSString* regex_emoji=@"\\[[^\\[\\]]*\\]";
    NSError* error=nil;
    NSRegularExpression* regularExpression=[NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    //    [regularExpression enumerateMatchesInString:plainString options:NSMatchingReportProgress range:NSMakeRange(0, plainString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
    //        NSRange range =  [result range];
    //        NSString *subStr = [plainString substringWithRange:range];
    //        NSTextAttachment *emotionTextAttachment = [NSTextAttachment new];
    //        NSArray<EmotionItem*> * items=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where emotionItemName='%@' ",subStr] ];
    //        if (items.count>0) {
    //            emotionTextAttachment.image = [UIImage ImageWithName:items[0].emotionItemSmallImageUrl];
    //            [attributeString replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:emotionTextAttachment]];
    //        }
    //
    //    }];
    NSArray<NSTextCheckingResult *> * emtionStringArray=[regularExpression matchesInString:plainString  options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, plainString.length)];
    for (NSInteger i=emtionStringArray.count; i>0; i--) {
        NSTextCheckingResult* result=emtionStringArray[i-1];
        NSRange range =  [result range];
        NSString *subStr = [plainString substringWithRange:range];
        EmotionTextAttachment *emotionTextAttachment = [EmotionTextAttachment new];
        emotionTextAttachment.emotionName=subStr;
        NSArray<EmotionItem*> * items=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where emotionItemName='%@' ",subStr] ];
        if (items.count>0) {
            emotionTextAttachment.image = [UIImage ImageWithName:items[0].emotionItemSmallImageUrl];
            [attributeString replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:emotionTextAttachment]];
        }
    }
    //    NSLog(@"%@", emtionStringArray);
    return  attributeString;
}

@end
