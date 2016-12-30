//
//  PsyKeyBoardView.m
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PsyInputView.h"
#import "PsyCommonMacro.h"
#import "UIView+Frame.h"
#import "FaceKeyBoard.h"


@interface PsyInputView()<HPGrowingTextViewDelegate>
@property(nonatomic,assign) CGRect originInputViewFrame;
@end

@implementation PsyInputView
#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame delegate:(id<PsyInputViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        _delegate = delegate;
        _originInputViewFrame=frame;
        //        [self setAutoresizesSubviews:NO];


    }
    return self;
}



- (void)dealloc
{
    NSLog(@"%@ is dealloc",[self class]);
    self.textView = nil;
    self.sendButton = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}

- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

+ (JSInputBarStyle)inputBarStyle
{
    return JSInputBarStyleDefault;
}

#pragma mark - Setup
- (void)setup
{
    //add NSNotification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardDidChangeFrameNotification object:nil ];

    self.autoresizesSubviews=YES;
    //    self.image = [UIImage inputBar];
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
    //    [self setSendButton:self.emotionButton];
    [self addSubview:self.emotionButton];
    //    UIViewAutoresizingNone                 = 0,
    //    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    //    UIViewAutoresizingFlexibleWidth        = 1 << 1,
    //    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
    //    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
    //    UIViewAutoresizingFlexibleHeight       = 1 << 4,
    //    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
    self.emotionButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;

    self.showUtilitysButton  = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.showUtilitysButton setBackgroundImage:[UIImage imageNamed:@"dd_utility"] forState:UIControlStateNormal];
    self.showUtilitysButton.frame=CGRectMake(FULL_WIDTH-38, 9.0f, 28.0f, 28.0f);
    [self.showUtilitysButton addTarget:self action:@selector(showPlainText) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showUtilitysButton];
    self.showUtilitysButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;


    self.voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.voiceButton setBackgroundImage:[UIImage imageNamed:@"dd_record_normal"] forState:UIControlStateNormal];
    self.voiceButton.tag = 0;
    self.voiceButton.frame = CGRectMake(10, 9.0, 28.0f, 28.0f);
    [self addSubview:self.voiceButton];
    self.voiceButton.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;

    [self setupRecordButton];
    [self setupTextView];
}

- (void)setupTextView
{
    //    CGFloat width = self.frame.size.width - SEND_Button_WIDTH;
    CGFloat height = [PsyInputView textViewLineHeight];

    self.textView = [[SubHPGrowingTextView  alloc] initWithFrame:CGRectMake(46.0f, 7.0f, self.emotionButton.frame.origin.x-self.emotionButton.frame.size.width-30, height)];
    //    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.minHeight = 31;
    self.textView.maxNumberOfLines = 5;
    self.textView.animateHeightChange = YES;
    self.textView.animationDuration = 0.25;
    self.textView.delegate = self;
    self.textView.backgroundColor=[UIColor yellowColor];

    [self.textView.layer setBorderWidth:0.5];
    [self.textView.layer setBorderColor:RGB(188, 188, 188).CGColor];
    [self.textView.layer setCornerRadius:2];
    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textView];
}

- (void)setupRecordButton
{
    //    CGFloat width = self.frame.size.width - SEND_Button_WIDTH;
    CGFloat height = [PsyInputView textViewLineHeight];

    self.recordButton = [[UIImageView alloc] initWithFrame:CGRectMake(46, 7.0f, self.emotionButton.frame.origin.x-self.emotionButton.frame.size.width-30, height)];
    [self.recordButton setClipsToBounds:YES];
    [self.recordButton.layer setBorderWidth:1.0];
    [self.recordButton.layer setBorderColor:RGB(192, 192, 192).CGColor];
    [self.recordButton.layer setCornerRadius:3.0];
    [self.recordButton setUserInteractionEnabled:YES];

    [self.recordButton setImage:[self createImageWithColor:RGB(248, 248, 248)]];
    [self.recordButton setHighlightedImage:[self createImageWithColor:RGB(230, 230, 230)]];
    self.ButtonTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, self.emotionButton.frame.origin.x-self.emotionButton.frame.size.width-30, 18)];
    self.ButtonTitle.text=@"按住说话";
    [self.ButtonTitle setTextColor:RGB(86, 86, 86)];
    [self.ButtonTitle setTextAlignment:NSTextAlignmentCenter];
    [self.recordButton addSubview:self.ButtonTitle];
    [self.recordButton setOpaque:YES];
    [self.recordButton setHidden:YES];
    [self addSubview:self.recordButton];
    //    [self.recordButtonaddObserver:self  forKeyPath:@"image" options:0 context:NULL];
}

#pragma mark - HPTextViewDelegate
//- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView;
//- (BOOL)growingTextViewShouldEndEditing:(HPGrowingTextView *)growingTextView;

//- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView;
//- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView;

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"])
    {
        //        [self.delegate textViewEnterSend];
        return NO;
    }
    return YES;
}
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    //    [self.delegate textViewChanged];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float bottom = self.bottom;
    NSLog(@"bottom:%f",bottom);

    if ([growingTextView.text length] == 0)
    {
        [self setHeight:height + 30];
    }
    else
    {
        [self setHeight:height + 30];
    }
    //    [self setY:]
    [self setBottom:bottom];
    //    [growingTextView setContentInset:UIEdgeInsetsZero];
    //    [UIView animateKeyframesWithDuration:0.25 delay:0 options:0 animations:^{
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
    //    [self.delegate viewheightChanged:height];
}

//- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height
//{
//}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    return YES;
}

#pragma mark - Private Methods
- (void)tapFaceButton:(UIButton *)sender
{
        if (self.emotionButton.tag == KeyboardEmotion)
        {
            [self changeMoudleToNormal];
            self.emotionButton.tag = KeyboardSystem;
            [self.textView changeKeyboardType:KeyboardEmotion];
        }else
        {
            [self changeMoudleToNormal];
              [self.textView changeKeyboardType:KeyboardSystem];
        }
}

- (void)showPlainText
{
    [self.textView  showPlainText];

   }
//function:-[PsyInputView keyboardNotification:] line:277 content:dic = {
//    UIKeyboardAnimationCurveUserInfoKey = 7;
//    UIKeyboardAnimationDurationUserInfoKey = "0.25";
//    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 271}}";
//    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 871.5}";
//    UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 600.5}";
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 271}}";
//    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 465}, {414, 271}}";
//    UIKeyboardIsLocalUserInfoKey = 1;
//}


- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary * dic = notification.userInfo;
//    NSLog(@"dic = %@",dic);
    NSValue * value = dic[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    CGRect currentFrame=self.frame;
//    NSLog(@"currentFrame = %@",NSStringFromCGRect(currentFrame));
//    currentFrame.origin.y= _originInputViewFrame.origin.y-keyboardFrame.size.height;
        currentFrame.origin.y= FULL_HEIGHT-( currentFrame.size.height+keyboardFrame.size.height);
    self.frame = currentFrame;
    [self layoutIfNeeded];
}



- (void)changeMoudleToNormal
{

    self.voiceButton.tag = KeyboardVoice;
    self.emotionButton.tag = KeyboardEmotion;
    self.showUtilitysButton.tag = KeyboardFunction;
    self.textView.hidden = NO;
    self.recordButton.hidden = YES;
}

#pragma mark - Setters
- (void)setSendButton:(UIButton *)btn
{
    if(_sendButton)
    [_sendButton removeFromSuperview];

    _sendButton = btn;
    [self addSubview:self.sendButton];
}

#pragma mark - Message input view

+ (CGFloat)textViewLineHeight
{
    return 32.0f; // for fontSize 16.0f
}

+ (CGFloat)maxLines
{
    return 5.0f;
}

+ (CGFloat)maxHeight
{
    return ([PsyInputView maxLines] + 1.0f) * [PsyInputView textViewLineHeight];
}

//- (void)willBeginRecord
//{
//    [self.textView setHidden:YES];
//    [self.recordButton setHidden:NO];
//}
//
//- (void)willBeginInput
//{
//    [self.textView setHidden:NO];
//    [self.recordButton setHidden:YES];
//}
-(void)setDefaultHeight
{

}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
