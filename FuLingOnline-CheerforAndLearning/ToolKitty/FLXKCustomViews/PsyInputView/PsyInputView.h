//
//  PsyKeyBoardView.h
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubHPGrowingTextView.h"
typedef enum
{
    JSInputBarStyleDefault,
    JSInputBarStyleFlat
} JSInputBarStyle;


@protocol PsyInputViewDelegate <NSObject>

- (void)viewheightChanged:(float)height;
- (void)textViewEnterSend;
- (void)textViewChanged;

@end

@interface PsyInputView : UIView

//@property (strong) HPGrowingTextView *textView;
@property (strong) SubHPGrowingTextView *textView;
@property (strong) UIButton *sendButton;
@property (strong) UIButton *showUtilitysButton;
@property (strong) UIButton *voiceButton;
@property (strong) UIImageView *recordButton;
@property (strong) UIButton *emotionButton;
@property (assign) id<PsyInputViewDelegate> delegate;
@property(strong)UILabel *ButtonTitle;
#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame delegate:(id<PsyInputViewDelegate>)delegate;

#pragma mark - Message input view
- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight;

+ (CGFloat)textViewLineHeight;
+ (CGFloat)maxLines;
+ (CGFloat)maxHeight;
-(void)setDefaultHeight;
+ (JSInputBarStyle)inputBarStyle;
- (void)willBeginRecord;
- (void)willBeginInput;;
@end
