//
//  FLXKNormalEmotionGroupCollectionViewCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKNormalEmotionGroupCollectionViewCell.h"

//entity
#import "EmotionGroup.h"


@implementation FLXKNormalEmotionGroupCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setGroupItem:(EmotionGroup *)groupItem{
    self.groupItem=groupItem;
    UIImage* image=[UIImage imageNamed:groupItem.emotionGroupImageUrl];
    [self.groupEmotionButton setImage:image forState:UIControlStateNormal];
}

@end
