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

//state property
@property(nonatomic,assign)NSInteger currentShowingPageIndex;

@property (nonatomic,weak) id<FLXKEmotionShowingScrollViewDelegate> emotionSelectedDelegate;

//-(void)setCurrentShowingPageIndextest:(NSInteger)currentShowingPageIndex;

+(NSArray<FLXKEmotionShowingScrollView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId;
@end
