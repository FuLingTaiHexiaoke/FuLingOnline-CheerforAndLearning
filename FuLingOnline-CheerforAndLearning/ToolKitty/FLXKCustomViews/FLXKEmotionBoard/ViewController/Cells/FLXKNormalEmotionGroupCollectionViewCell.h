//
//  FLXKNormalEmotionGroupCollectionViewCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionGroup;

typedef void(^GroupEmotionCellTapGestureBlock)(NSRange);

@interface FLXKNormalEmotionGroupCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)EmotionGroup* emotionGroup;
@property (weak, nonatomic) IBOutlet UIView *groupEmotionBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *groupEmotionButton;
//@property(nonatomic,assign)NSInteger groupStartPageIndex;
//@property(nonatomic,assign)NSInteger groupPagesCount;
@property(nonatomic,assign)NSRange groupPagesRange;

@property(nonatomic,strong)GroupEmotionCellTapGestureBlock groupEmotionCellTapGestureBlock;

-(void)setEmotionGroup:(EmotionGroup *)emotionGroup itemIndex:(NSInteger)itemIndex;
@end
