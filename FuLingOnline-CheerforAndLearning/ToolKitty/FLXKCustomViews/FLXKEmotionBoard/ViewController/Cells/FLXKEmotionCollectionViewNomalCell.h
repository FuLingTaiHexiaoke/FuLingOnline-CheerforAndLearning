//
//  FLXKEmotionCollectionViewNomalCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EmotionItem.h"
//@class EmotionItem;

typedef void(^emotionCellTapGestureBlock)(EmotionItem*);
typedef void(^emotionCellLongPressedGestureBlock)(EmotionItem*);

@interface FLXKEmotionCollectionViewNomalCell : UICollectionViewCell
@property(nonatomic,strong)EmotionItem* item;
//@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (weak, nonatomic) IBOutlet UIImageView *emotionImageView;
//-(void)setItem:(EmotionItem *)item;

@property(nonatomic,strong)emotionCellTapGestureBlock emotionCellTapGestureBlock;
@property(nonatomic,strong)emotionCellLongPressedGestureBlock emotionCellLongPressedGestureBlock;
@end
