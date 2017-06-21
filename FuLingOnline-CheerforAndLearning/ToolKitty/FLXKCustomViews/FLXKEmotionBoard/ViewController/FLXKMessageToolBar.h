//
//  FLXKMessageToolBar.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, MessageToolBarShowingOption) {
    MessageToolBarShowingOption_NONE_BUTTON  = 1 << 0,
    MessageToolBarShowingOption_EMOTION_BUTTON  = 1 << 1,
    MessageToolBarShowingOption_RECORD_BUTTON  = 1 << 2,
    MessageToolBarShowingOption_UTILITY_BUTTON        = 1 << 3,
    MessageToolBarShowingOption_ALL_BUTTON        = 1 << 4,
};


#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface FLXKMessageToolBar : UIView
@property (weak, nonatomic) IBOutlet HPGrowingTextView *growingTextView;

@property(nonatomic,strong)void(^sendMessageBlock)(NSString* message);
@property(nonatomic,strong)void(^growingTextViewChangeHeight)(CGFloat height);

+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder containerView:(UIView*)containerView showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption textViewFont:(UIFont*)textViewFont;

-(void)showToolBarWithPlaceholder:(NSString*)placeholder tapedView:(UIView*)tapedView scrollView:(UIScrollView*)scrollView;
-(void)hideToolBar;

#pragma mark - HPGrowingTextView Delegate
//开放出去方便 emotionBoard 调用
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView;

@end

