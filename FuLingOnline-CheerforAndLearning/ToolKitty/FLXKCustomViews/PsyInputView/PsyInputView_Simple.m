//
//  PsyKeyBoardView.m
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PsyInputView_Simple.h"
#import "Global.h"
#import "UIView+Extensions.h"
#import "FaceKeyBoard.h"
#import "EmojiTextAttachment.h"

@interface PsyInputView_Simple()<HPGrowingTextViewDelegate>
@property(nonatomic,assign) CGRect originInputViewFrame;
@property(nonatomic,assign) CGRect keyboradFrame;
@end

@implementation PsyInputView_Simple
#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame delegate:(id<PsyInputView_SimpleDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        _delegate = delegate;
        _originInputViewFrame=frame;

    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ is dealloc",[self class]);
    self.textView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}

#pragma mark - Public Methods

- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}


#pragma mark - Setup basic uicontroller
- (void)setup
{
    //add NSNotification
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrameNotification:) name:UIKeyboardDidChangeFrameNotification object:nil ];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil ];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil ];
    //set to layoutSubviews
    //    self.autoresizesSubviews=YES;

    self.backgroundColor = [UIColor whiteColor];
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    line.backgroundColor=RGB(188, 188, 188);
    [self addSubview:line];

    self.emotionButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emotionButton setBackgroundImage:[UIImage imageNamed:@"dd_emotion"] forState:UIControlStateNormal];
    self.emotionButton.frame=CGRectMake(FULL_WIDTH-36-38, 9.0f, 28.0f, 28.0f);
    [self.emotionButton addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.emotionButton.tag=KeyboardEmotion;
    [self addSubview:self.emotionButton];
    self.emotionButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;

    self.showUtilitysButton  = [UIButton  buttonWithType:UIButtonTypeCustom];
    //    [self.showUtilitysButton setBackgroundImage:[UIImage imageNamed:@"dd_utility"] forState:UIControlStateNormal];
    self.showUtilitysButton.backgroundColor=[UIColor grayColor];
    [self.showUtilitysButton setTitle:@"Exist" forState:UIControlStateNormal];
    self.showUtilitysButton.titleLabel.font=[UIFont systemFontOfSize:12];
    self.showUtilitysButton.frame=CGRectMake(FULL_WIDTH-38, 9.0f, 32.0f, 28.0f);
    //    [self.showUtilitysButton addTarget:self action:@selector(showPlainText) forControlEvents:UIControlEventTouchUpInside];
    [self.showUtilitysButton addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showUtilitysButton];
    self.showUtilitysButton.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    [self.showUtilitysButton.layer setCornerRadius:5];

    [self setupTextView];
}

- (void)setupTextView
{
    CGFloat height = [PsyInputView_Simple textViewLineHeight];

    self.textView = [[SubHPGrowingTextView  alloc] initWithFrame:CGRectMake(7, 6.0f, self.emotionButton.frame.origin.x-self.emotionButton.frame.size.width-30+47, height)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.minHeight = 36;
    self.textView.maxNumberOfLines = 4;
    self.textView.animateHeightChange = YES;
    self.textView.animationDuration = 0.25;
    self.textView.delegate = self;
    //    self.textView.backgroundColor=[UIColor yellowColor];

    [self.textView.layer setBorderWidth:0.5];
    [self.textView.layer setBorderColor:RGB(188, 188, 188).CGColor];
    [self.textView.layer setCornerRadius:2];
    //    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textView];
    //    [self setupConstraint];

    //    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(7, height+9,  self.emotionButton.frame.origin.x-self.emotionButton.frame.size.width-30+47, 0.5)];
    //    line.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
    //    line.backgroundColor=RGB(188, 188, 188);
    //    [self addSubview:line];

}


#pragma mark - HPTextViewDelegate

//- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqual:@"\n"])
//    {
//        return NO;
//    }
//    return YES;
//}
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    if ([growingTextView.text length] == 0)
    {
        [self.showUtilitysButton setTitle:@"Exist" forState:UIControlStateNormal];
        [self.showUtilitysButton removeTarget:self action:@selector(showPlainText)  forControlEvents:UIControlEventTouchUpInside];
        [self.showUtilitysButton addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        self.showUtilitysButton.backgroundColor=[UIColor grayColor];
    }
    else
    {
        [self.showUtilitysButton setTitle:@"Send" forState:UIControlStateNormal];
        [self.showUtilitysButton removeTarget:self action:@selector(resignFirstResponder)  forControlEvents:UIControlEventTouchUpInside];
        [self.showUtilitysButton addTarget:self action:@selector(showPlainText) forControlEvents:UIControlEventTouchUpInside];
        self.showUtilitysButton.backgroundColor=[UIColor greenColor];
    }

}

#pragma mark - 添加约束

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{

    float bottom = self.bottom;

    if ([growingTextView.text length] == 0)
    {
        [self setHeight:height+ 10];
    }
    else
    {
        [self setHeight:height+10];
    }
    [self setBottom:bottom];
}

//
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    return YES;
}

#pragma mark - Private Methods

+ (CGFloat)textViewLineHeight
{
    return 32.0f; // for fontSize 16.0f
}

- (void)tapFaceButton:(UIButton *)sender
{
    if (self.emotionButton.tag == KeyboardEmotion)
    {
        [self changeMoudleToNormal];
        self.emotionButton.tag = KeyboardSystem;
        [self.emotionButton setBackgroundImage:[UIImage imageNamed:@"dd_input_normal"] forState:UIControlStateNormal];

        [self.textView changeKeyboardType:KeyboardEmotion];
    }else
    {
        [self changeMoudleToNormal];
        [self.emotionButton setBackgroundImage:[UIImage imageNamed:@"dd_emotion"] forState:UIControlStateNormal];
        [self.textView changeKeyboardType:KeyboardSystem];
    }
}

- (void)showPlainText
{
    [self.textView.internalTextView resignFirstResponder];
    NSString*  plainText=[self.textView  showPlainText];


    if (plainText&&self.delegate&&[self.delegate respondsToSelector:@selector(inputView_SimpleSendingMessage:)]) {
        [self.delegate inputView_SimpleSendingMessage: plainText];
    }

}

- (void)changeMoudleToNormal
{

    self.voiceButton.tag = KeyboardVoice;
    self.emotionButton.tag = KeyboardEmotion;
    self.showUtilitysButton.tag = KeyboardFunction;
    self.textView.hidden = NO;
    self.recordButton.hidden = YES;
}


#pragma mark - keyboard Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    if (![self.textView isFirstResponder]) {
        return;
    }
    NSDictionary * dic = notification.userInfo;
    NSValue * value = dic[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];

    CGRect currentFrame=self.frame;
    currentFrame.origin.y= FULL_HEIGHT-( currentFrame.size.height+keyboardFrame.size.height);
    self.frame = currentFrame;
    [self layoutIfNeeded];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    if (![self.textView isFirstResponder]) {
        return;
    }

    NSDictionary * dic = notification.userInfo;
    NSValue * value = dic[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];

    CGRect currentFrame=  self.frame;
    currentFrame.origin.y+= keyboardFrame.size.height;
    self.frame = currentFrame;
    [self layoutIfNeeded];
}


@end
