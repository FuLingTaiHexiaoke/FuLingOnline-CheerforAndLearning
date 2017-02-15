//
//  FLXKEmotionGroupIndexCollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLXKEmotionGroupIndexCollectionViewDelegate <NSObject>

@optional
-(void)didSelectedEmotionGroupItem:(NSRange)range;

@end

@interface FLXKEmotionGroupIndexCollectionView : UICollectionView

@property (nonatomic,weak) id<FLXKEmotionGroupIndexCollectionViewDelegate> emotionGroupSelectedDelegate;
//-(void)selectedItemAtIndexPath:(NSIndexPath*)indexPath;
-(void)selecteItemAtContentOffset:(CGFloat)contentOffset;

-(void)loadGroupsAccordingEmotionGroupOptions;
@end
