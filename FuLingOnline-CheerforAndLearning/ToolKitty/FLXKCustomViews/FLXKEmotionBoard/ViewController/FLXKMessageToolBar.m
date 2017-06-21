//
//  FLXKMessageToolBar.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKMessageToolBar.h"
//utilites
#import "Masonry.h"
#import "NSAttributedString+EmotionExtension.h"
#import "HPGrowingTextView.h"
#import "FLXKEmotionBoard.h"

@interface FLXKMessageToolBar ()<HPGrowingTextViewDelegate,MessageSendDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (strong, nonatomic) FLXKEmotionBoard* emotionKeyBoard;
@property (strong, nonatomic) UIFont* textViewFont;
@end

@implementation FLXKMessageToolBar

#pragma mark -  LifeCircle


+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder containerView:(UIView*)containerView showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption textViewFont:(UIFont*)textViewFont{
    FLXKMessageToolBar * sharedInstance;
    
    if (messageToolBarShowingOption&MessageToolBarShowingOption_NONE_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_EMOTION_BUTTON) {
        sharedInstance  =[FLXKMessageToolBar sharedInstance];
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_RECORD_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_UTILITY_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_ALL_BUTTON) {
        sharedInstance  =[FLXKMessageToolBar sharedInstanceALL];
    }
    sharedInstance.textViewFont=textViewFont;
    sharedInstance.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:sharedInstance.growingTextView.internalTextView swithButton:sharedInstance.emotionButton swithButtonContainer:sharedInstance emotionEditingVCView:containerView emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image) delegate:sharedInstance editingTextViewAttributes:@{NSFontAttributeName:textViewFont}  shouldAutoHideToolBar:YES SVO_ShouldAutoOffset:YES];
    
    return sharedInstance;
}

+(instancetype)sharedInstance{
    static FLXKMessageToolBar* sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
        sharedInstance=[nibViews objectAtIndex:0];
        HPGrowingTextView* textView= sharedInstance.growingTextView;
        textView.isScrollable = NO;
        textView.contentInset =  UIEdgeInsetsMake(5, 0, 5, 0);
        textView.minNumberOfLines = 1;
        textView.maxNumberOfLines = 6;
        // you can also set the maximum height in points with maxHeight
        textView.returnKeyType = UIReturnKeySend; //just as an example
        //        textView.font = [UIFont systemFontOfSize:FLXKMessageToolBar_Font;
        textView.delegate = sharedInstance;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor whiteColor];
        textView.placeholder = @"Type to see the textView grow!";
        textView.layer.cornerRadius=5.0;
        textView.layer.masksToBounds=YES;
    });
    return sharedInstance;
}

+(instancetype)sharedInstanceALL{
    static FLXKMessageToolBar* sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
        sharedInstance=[nibViews objectAtIndex:1];
        HPGrowingTextView* textView= sharedInstance.growingTextView;
        textView.isScrollable = NO;
        textView.contentInset =  UIEdgeInsetsMake(5, 0, 5, 0);
        
        textView.minNumberOfLines = 1;
        textView.maxNumberOfLines = 6;
        // you can also set the maximum height in points with maxHeight
        textView.returnKeyType = UIReturnKeySend; //just as an example
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.delegate = sharedInstance;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor whiteColor];
        textView.placeholder = @"Type to see the textView grow!";
    });
    
    return sharedInstance;
}
#pragma mark - MessageSendDelegate
-(void)sendMessageFiredByEmotionBoard{
    NSString * message= [self.growingTextView.internalTextView.attributedText getPlainString];
    if (self.sendMessageBlock) {
        self.sendMessageBlock(message);
    }
}

#pragma mark - HPGrowingTextView Delegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    CGFloat   newHeight=r.size.height;
    [self growingTextViewChangeHeight:newHeight];
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView{
    NSString * message= [growingTextView.internalTextView.attributedText getPlainString];
    if (self.sendMessageBlock) {
        self.sendMessageBlock(message);
    }
    return YES;
}

#pragma mark - Public methods
-(void)showToolBarWithPlaceholder:(NSString*)placeholder tapedView:(UIView*)tapedView scrollView:(UIScrollView*)scrollView{
    //emotionKeyBoard
    self.emotionKeyBoard.SVO_TapedView=tapedView;
    self.emotionKeyBoard.SVO_ScrollView=scrollView;
    
    self.growingTextView.placeholder =placeholder;
    [self.growingTextView.internalTextView becomeFirstResponder];
}

-(void)hideToolBar{
    self.growingTextView.internalTextView.text=nil;
    self.growingTextView.internalTextView.attributedText=nil;
    [self.growingTextView.internalTextView resignFirstResponder];
}
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods

- (void)growingTextViewChangeHeight:(float)height
{
    //below is for system autolayout,because Masonry can`t update system autolayout
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute==NSLayoutAttributeHeight) {
            obj.constant=height;
        }
    }];
    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.superview layoutIfNeeded];
    } completion:nil];
}

-(void)setShowingOption:(MessageToolBarShowingOption)messageToolBarShowingOption{
    if (messageToolBarShowingOption&MessageToolBarShowingOption_NONE_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_EMOTION_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_RECORD_BUTTON) {
        
    }
    if (messageToolBarShowingOption&MessageToolBarShowingOption_UTILITY_BUTTON) {
        
    }
}
#pragma mark - getter/setter

-(void)setTextViewFont:(UIFont *)textViewFont{
    self.growingTextView.font=textViewFont;
}

#pragma mark - Overriden methods

@end
