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
//child viewController
//models
//subviews
#import "HPGrowingTextView.h"
#import "FLXKEmotionBoard.h"

@interface FLXKMessageToolBar ()<HPGrowingTextViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (weak, nonatomic) IBOutlet HPGrowingTextView *growingTextView;
@property (strong, nonatomic) FLXKEmotionBoard* emotionKeyBoard;

//IBAction
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXKMessageToolBar

#pragma mark -  LifeCircle


+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder containerView:(UIView*)containerView showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption {
    FLXKMessageToolBar * sharedInstance;
    //    sharedInstance.growingTextView.placeholder=placeholder;
    //    [sharedInstance setShowingOption:messageToolBarShowingOption];
    
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
    
    sharedInstance.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:sharedInstance.growingTextView.internalTextView swithButton:sharedInstance.emotionButton swithButtonContainer:sharedInstance emotionEditingVCView:containerView emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image) shouldHideToolBar:YES SVO_ShouldAutoOffset:YES];
    
    return sharedInstance;
}

+(instancetype)sharedInstance{
    static FLXKMessageToolBar* sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
        sharedInstance=[nibViews objectAtIndex:0];
        HPGrowingTextView* textView= sharedInstance.growingTextView;
        
        //set emotionboard
        
        //        sharedInstance.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:textView.internalTextView swithButton:sharedInstance.emotionButton swithButtonContainer:sharedInstance emotionEditingVCView:sharedInstance.superview emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image)];
        
        textView.isScrollable = NO;
        textView.contentInset =  UIEdgeInsetsMake(5, 0, 5, 0);
        
        textView.minNumberOfLines = 1;
        textView.maxNumberOfLines = 6;
        // you can also set the maximum height in points with maxHeight
        textView.returnKeyType = UIReturnKeySend; //just as an example
        textView.font = [UIFont systemFontOfSize:FBTweakValue(@"FLXKMessageToolBar", @"sharedInstance",  @"font", 15.0)];
        textView.delegate = sharedInstance;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor whiteColor];
        textView.placeholder = @"Type to see the textView grow!";
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
        //        //set emotionboard
        //
        //        sharedInstance.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:textView.internalTextView swithButton:sharedInstance.emotionButton swithButtonContainer:sharedInstance emotionEditingVCView:sharedInstance.superview emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image)];
        
        
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
    //below is just for Masonry
    //    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [self mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(height);
    //        }];
    //        [self.superview layoutIfNeeded];
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    //below is for system autolayout,because Masonry can`t update system autolayout
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute==NSLayoutAttributeHeight) {
            //                    [self removeConstraint:obj];
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
#pragma mark - Overriden methods

@end
