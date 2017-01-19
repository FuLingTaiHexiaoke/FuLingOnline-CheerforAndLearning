//
//  FLXKEmotionCollectionViewNomalCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionCollectionViewNomalCell.h"
#import "EmotionItem.h"

@interface FLXKEmotionCollectionViewNomalCell()


@end

@implementation FLXKEmotionCollectionViewNomalCell

-(void)setItem:(EmotionItem *)item{
    self.item=item;
    UIImage* image=[UIImage imageNamed:item.emotionItemSmallImageUrl];
    self.imageView.image=image;
}

@end
