//
//  FLXKMessageToolBar.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

//0:basic_text_emotion_image
//1:emoji_text_emotion_image
//2:additonal_text_emotion_image
//3:recent_text_emotion_image
//4:big_static_image
//5:big_gif_image
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
- (instancetype)initWithCustomFrame:(CGRect)frame;
+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption;
+(instancetype)sharedMessageToolBarWithPlacehoder:(NSString*)placeholder containerView:(UIView*)containerView showingOption:(MessageToolBarShowingOption)messageToolBarShowingOption;
-(void)messageToolBarBecomeFirstResponder;
//IBOutlet
//IBAction
//models
//UI state record properties
//subviews
//child viewController

@end

