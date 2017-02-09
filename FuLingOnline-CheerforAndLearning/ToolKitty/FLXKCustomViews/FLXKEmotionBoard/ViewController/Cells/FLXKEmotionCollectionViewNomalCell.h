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

typedef void(^EmotionCellTapGestureBlock)(EmotionItem*);
typedef void(^EmotionCellLongPressedGestureBlock)(EmotionItem*);

@interface FLXKEmotionCollectionViewNomalCell : UICollectionViewCell
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@property (weak, nonatomic) IBOutlet UIImageView *emotionImageView;

//model
@property(nonatomic,strong)EmotionItem* item;

//public methods
//-(void)setEmotionItem:(EmotionItem *)item;
@property(nonatomic,strong)EmotionCellTapGestureBlock emotionCellTapGestureBlock;
@property(nonatomic,strong)EmotionCellLongPressedGestureBlock emotionCellLongPressedGestureBlock;
@end
