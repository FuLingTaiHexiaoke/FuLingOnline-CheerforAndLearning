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
//utilites
//models
//subviews
//child viewController
@interface FLXKMessageToolBar : UIView
//public actions

+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder containerView:(UIView*)containerView showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption;

-(void)showToolBarWithPlaceholder:(NSString*)placeholder tapedView:(UIView*)tapedView scrollView:(UIScrollView*)scrollView;
-(void)hideToolBar;

//IBOutlet
//IBAction
//models
//UI state record properties
@property(nonatomic,strong)void(^sendMessageBlock)(NSString* message);
@property(nonatomic,strong)void(^growingTextViewChangeHeight)(CGFloat height);
//subviews
//child viewController

@end

