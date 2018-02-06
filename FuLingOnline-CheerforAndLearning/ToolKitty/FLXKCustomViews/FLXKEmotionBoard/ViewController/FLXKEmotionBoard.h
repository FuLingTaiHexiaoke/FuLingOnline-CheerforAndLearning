//
//  FLXKEmotionBoard.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLXKEmotionCollectionView.h"

//0:basic_text_emotion_image
//1:emoji_text_emotion_image
//2:additonal_text_emotion_image
//3:recent_text_emotion_image
//4:big_static_image
//5:big_gif_image
typedef NS_OPTIONS(NSUInteger, EmotionGroupShowingOption) {
    EmotionGroup_basic_text_emotion_image                 = 0,
    EmotionGroup_emoji_text_emotion_image   = 1 << 0,
    EmotionGroup_additonal_text_emotion_image        = 1 << 1,
    EmotionGroup_recent_text_emotion_image  = 1 << 2,
    EmotionGroup_big_static_image    = 1 << 3,
    EmotionGroup_big_gif_image       = 1 << 4,
};

@protocol MessageSendDelegate <NSObject>

@optional
-(void)sendMessageFiredByEmotionBoard;

@end

@interface FLXKEmotionBoard : UIView<UIScrollViewDelegate,FLXKEmotionCollectionViewDelegate>

@property(nonatomic,weak)id<MessageSendDelegate>  delegate;
//自动调整SVO(scrollview.offset)的值，使scrollview中点击的view和ToolBar动态贴紧

@property(nonatomic,weak)UIView* SVO_TapedView;
@property(nonatomic,weak)UIScrollView* SVO_ScrollView;


+(instancetype)sharedEmotionBoard;
//便利方法，同事注册多个控件


//+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption delegate:(id<MessageSendDelegate>)delegate editingTextViewAttributes:(NSDictionary*)editingTextViewAttributes;

//朋友圈对应的带输入框的表情键盘。是否自动调整tableview的offset，使其具有对齐功能
+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption delegate:(id<MessageSendDelegate>)delegate editingTextViewAttributes:(NSDictionary*)editingTextViewAttributes shouldAutoHideToolBar:(BOOL)shouldAutoHideToolBar SVO_ShouldAutoOffset:(BOOL)SVO_ShouldAutoOffset;

-(void)removeNotifications;

+(void)reloadPages;

//获取富文本的文字表达形式
+(NSString*)getPlainTextString;
@end
