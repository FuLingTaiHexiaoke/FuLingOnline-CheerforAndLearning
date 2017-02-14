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

@interface FLXKEmotionBoard : UIView<UIScrollViewDelegate,FLXKEmotionCollectionViewDelegate>

//便利方法，同事注册多个控件
+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButtonContainer:(UIView *)swithButtonContainer swithButton:(UIView *)swithButton;

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption;

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView emotionSwithBarButtonItem:(UIBarButtonItem *)emotionSwithBarButtonItem swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView;

//获取富文本的文字表达形式
+(NSString*)getPlainTextString;
@end
