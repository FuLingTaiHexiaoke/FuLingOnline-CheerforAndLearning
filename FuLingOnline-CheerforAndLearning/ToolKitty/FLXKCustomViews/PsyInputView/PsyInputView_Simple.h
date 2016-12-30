//
//  PsyKeyBoardView.h
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubHPGrowingTextView.h"


@protocol PsyInputView_SimpleDelegate <NSObject>

- (void)inputView_SimpleSendingMessage:(NSString*)message;
@end

@interface PsyInputView_Simple : UIView

//@property (strong) HPGrowingTextView *textView;
@property (strong) SubHPGrowingTextView *textView;
@property (strong) UIButton *sendButton;
@property (strong) UIButton *showUtilitysButton;
@property (strong) UIButton *voiceButton;
@property (strong) UIImageView *recordButton;
@property (strong) UIButton *emotionButton;
@property (assign) id<PsyInputView_SimpleDelegate> delegate;
@property(strong)UILabel *ButtonTitle;
#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame delegate:(id<PsyInputView_SimpleDelegate>)delegate;

@end
