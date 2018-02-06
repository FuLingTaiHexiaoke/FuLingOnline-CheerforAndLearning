//
//  FLXKNomalEmotionCollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionItem,EmotionGroup;

@protocol FLXKEmotionCollectionViewDelegate <NSObject>

@optional
-(void)didSelectedEmotionItem:(EmotionItem*)emotionItem;
-(void)deleteElementInTextView;
@end

@interface FLXKEmotionCollectionView : UICollectionView

@property(nonatomic,strong)NSArray<EmotionItem*>* emotionItems;

@property (nonatomic,weak) id<FLXKEmotionCollectionViewDelegate> emotionSelectedDelegate;

//+(NSArray<FLXKEmotionCollectionView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId emotionGroup:(EmotionGroup*)emotionGroup;
//+(NSArray*)setupEmotionViewsWithGroupId:(NSInteger)groupId emotionGroup:(EmotionGroup*)emotionGroup;
+(NSArray*) setupEmotionViewsWithGroupId:(NSInteger)groupId emotionGroup:(EmotionGroup*)emotionGroup withFrame:(CGRect)frame;
@end
