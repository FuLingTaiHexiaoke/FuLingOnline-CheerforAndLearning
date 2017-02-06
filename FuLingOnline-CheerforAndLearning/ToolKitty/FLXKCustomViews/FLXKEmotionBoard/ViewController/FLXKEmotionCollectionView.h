//
//  FLXKNomalEmotionCollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionItem;

@protocol FLXKEmotionCollectionViewDelegate <NSObject>

@optional
-(void)didSelectedEmotionItem:(EmotionItem*)emotionItem;

@end

@interface FLXKEmotionCollectionView : UICollectionView

@property (nonatomic,weak) id<FLXKEmotionCollectionViewDelegate> emotionSelectedDelegate;

+(NSArray<FLXKEmotionCollectionView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId;
@end
