//
//  EmojiTextAttachment.h
//  InputEmojiExample
//
//  Created by zorro on 15/3/7.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionTextAttachment : NSTextAttachment
@property(assign, nonatomic) NSInteger *emotionID;
@property(strong, nonatomic) NSString *emotionName;
@property(assign, nonatomic) CGSize emotionSize;  //For emoji image size
@end
