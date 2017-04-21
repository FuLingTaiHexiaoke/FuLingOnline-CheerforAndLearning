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
    
    sharedInstance.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:sharedInstance.growingTextView.internalTextView swithButton:sharedInstance.emotionButton swithButtonContainer:sharedInstance emotionEditingVCView:containerView emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image) shouldHideToolBar:YES];
    
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
        textView.returnKeyType = UIReturnKeyGo; //just as an example
        textView.font = [UIFont systemFontOfSize:15.0f];
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
        textView.returnKeyType = UIReturnKeyGo; //just as an example
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.delegate = sharedInstance;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor whiteColor];
        textView.placeholder = @"Type to see the textView grow!";
    });
    
    return sharedInstance;
}



//- (instancetype)initWithCustomFrame:(CGRect)frame{
////    NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
////    FLXKMessageToolBar*  messageToolBar=[nibViews objectAtIndex:0];
////    messageToolBar.growingTextView.delegate=messageToolBar;
////    HPGrowingTextView* textView= messageToolBar.growingTextView;
////    textView.isScrollable = NO;
////    textView.contentInset =  UIEdgeInsetsMake(5, 0, 5, 0);
////
////    textView.minNumberOfLines = 1;
////    textView.maxNumberOfLines = 6;
////    // you can also set the maximum height in points with maxHeight
////    textView.returnKeyType = UIReturnKeyGo; //just as an example
////    textView.font = [UIFont systemFontOfSize:15.0f];
////    textView.delegate = self;
////    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
////    textView.backgroundColor = [UIColor whiteColor];
////    textView.placeholder = @"Type to see the textView grow!";
////
////    return messageToolBar;
//}

//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}
//

#pragma mark - Delegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    //    self.frame = r;
    
    CGFloat   newHeight=r.size.height;
    CGFloat  newOrigin=r.origin.y;
    

    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.1 animations:^{
//        [self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj.firstItem==self) {
//                [self.superview removeConstraint:obj];
//            }
//        }];
//        [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj.firstAttribute==NSLayoutAttributeHeight) {
//                [self removeConstraint:obj];
//            }
//        }];
        //        NSLog(@"Delegate growingTextView %@", NSStringFromCGRect(r));
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(newHeight);
            make.top.mas_equalTo(self.superview).offset(newOrigin);
            make.width.mas_equalTo(self.superview.mas_width);
        }];
        [self layoutIfNeeded];
    }];
    
}
#pragma mark - Public methods
-(void)messageToolBarBecomeFirstResponder{
    [self.growingTextView.internalTextView becomeFirstResponder];
}
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods

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
