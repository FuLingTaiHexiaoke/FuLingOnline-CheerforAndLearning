//
//  FLXKEmotionShowingScrollView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionItem;
@protocol FLXKEmotionShowingScrollViewDelegate <NSObject>

@optional
-(void)didSelectedEmotionItem:(EmotionItem*)emotionItem;
-(void)deleteElementInTextView;
@end

@interface FLXKEmotionShowingScrollView : UIScrollView

@property (nonatomic,weak) id<FLXKEmotionShowingScrollViewDelegate> emotionSelectedDelegate;

+(NSArray<FLXKEmotionShowingScrollView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId;
@end
