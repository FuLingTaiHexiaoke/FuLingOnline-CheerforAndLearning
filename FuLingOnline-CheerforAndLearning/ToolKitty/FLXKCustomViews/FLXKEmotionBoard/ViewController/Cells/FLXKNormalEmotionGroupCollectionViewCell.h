//
//  FLXKNormalEmotionGroupCollectionViewCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionGroup;
@interface FLXKNormalEmotionGroupCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)EmotionGroup* groupItem;
@property (weak, nonatomic) IBOutlet UIButton *groupEmotionButton;

@end
