//
//  FLXKEmotionBoard.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLXKEmotionCollectionView.h"

@interface FLXKEmotionBoard : UIView<UIScrollViewDelegate,FLXKEmotionCollectionViewDelegate>

//便利方法，同事注册多个控件
+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButtonContainer:(UIView *)swithButtonContainer swithButton:(UIView *)swithButton;

//+(instancetype)sharedEmotionBoard;

//获取富文本的文字表达形式
+(NSString*)getPlainTextString;
@end
