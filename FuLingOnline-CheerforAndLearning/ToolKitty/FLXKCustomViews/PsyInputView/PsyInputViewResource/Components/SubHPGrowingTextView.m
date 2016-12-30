//
//  SubHPGrowingTextView.m
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SubHPGrowingTextView.h"
#import "EmojiTextAttachment.h"
#import "NSAttributedString+EmojiExtension.h"

@implementation SubHPGrowingTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化Manager

        // 获取所有表情
        NSString * path = [[NSBundle mainBundle]pathForResource:@"Faces" ofType:@"plist"];
        self.faceArray = [NSArray arrayWithContentsOfFile:path];

        self.functionKeyboard = [[FunctionKeyboard alloc]initWithFrame:CGRectMake(0, 0,FULL_WIDTH, 271)];
        self.functionKeyboard.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //      __block  __weak  __typeof(self) * copy_self = self;
        //        self.functionKeyboard.functionKeyboardBlock = ^(NSInteger index){
        //            if ([copy_self.delegate respondsToSelector:@selector(myTextView:didTapFunctionKeyboardButton:)])
        //            {
        //                [copy_self.myTextViewDelegate myTextView:copy_self didTapFunctionKeyboardButton:index];
        //            }
        //        };

        self.faceKeyboard = [[EmotionKeyBoard alloc]initWithFrame:CGRectMake(0, 0,FULL_WIDTH, 271)];
        self.faceKeyboard.backgroundColor = [UIColor greenColor];
        __weak __block __typeof(self) weakSelf=self;
        weakSelf.faceKeyboard.clickEmotionBlock=^(NSString* emotionName,NSString* imageName){
            [self insertEmoji:emotionName imageName:imageName];
        };
    }
    return self;
}
- (void)resetTextStyle {
    [self refreshHeight];
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, self.internalTextView.textStorage.length);

    [self.internalTextView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];

    [self.internalTextView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:wholeRange];

}

#pragma mark - Action

- (void)insertEmoji:(NSString*)emotionName imageName:(NSString*)imageName {
    //Create emoji attachment
    EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];

    //Set tag and image
    emojiTextAttachment.emojiTag =emotionName;
    emojiTextAttachment.image = [UIImage imageNamed:imageName];

    //Set emoji size
    //        emojiTextAttachment.emojiSize = CGSizeMake(_emojiSizeSlider.value * EMOJI_MAX_SIZE, _emojiSizeSlider.value * EMOJI_MAX_SIZE);
    emojiTextAttachment.emojiSize =  CGSizeMake(20, 20);
    //Insert emoji image
    [self.internalTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment]
                                                      atIndex:self.internalTextView.selectedRange.location];

    //Move selection location
    self.internalTextView.selectedRange = NSMakeRange(self.internalTextView.selectedRange.location + 1, self.internalTextView.selectedRange.length);

    //Reset text style
        [self resetTextStyle];
}

- (NSString*)showPlainText{
    //        _infoLabel.text = [NSString stringWithFormat:@"Output: %@", [self.internalTextView.textStorage getPlainString]];
    NSLog(@"%@",[NSString stringWithFormat:@"Output: %@", [self.internalTextView.textStorage getPlainString]]);
    NSString* result=[NSString stringWithFormat:@"Output: %@", [self.internalTextView.textStorage getPlainString]];
    return  result;
}



- (void)dealloc
{
    NSLog(@"%@ is dealloc",[self class]);
}

#pragma mark - changeKeyBoard
- (void)changeKeyboardType:(InputViewType)type
{
    switch (type)
    {
        case KeyboardSystem:
        {
            self.internalTextView.inputView = nil;
            break;
        }
        case KeyboardFunction:
        {
            self.internalTextView.inputView = self.functionKeyboard;
            break;
        }
        case KeyboardEmotion:
        {
            self.internalTextView.inputView = self.faceKeyboard;
            break;
        }
        default:
            break;
    }
    //    [self.inputView removeFromSuperview];


    if (self.isFirstResponder)
    {
        [self.internalTextView reloadInputViews];
    }else
    {
        [self.internalTextView becomeFirstResponder];
    }
}

@end
