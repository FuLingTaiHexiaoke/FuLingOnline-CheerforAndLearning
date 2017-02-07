//
//  FLXKEmotionCollectionViewNomalCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionCollectionViewNomalCell.h"

#import "UIImage+EmotionExtension.h"

@interface FLXKEmotionCollectionViewNomalCell()


@end

@implementation FLXKEmotionCollectionViewNomalCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //add GestureRecognizer
    self.emotionImageView.userInteractionEnabled=YES;//must be set to yes for user Interaction Enable
    
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emotionTaped:)];
    
    [self.emotionImageView addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer* longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(emotionLongPressed:)];
    [self.emotionImageView addGestureRecognizer:longPressGesture];
}

//-(void)setItem:(EmotionItem *)item{
//    self.item=item;
//    UIImage* image=[UIImage ImageWithName:item.emotionItemSmallImageUrl];
//    [self.emotionButton setImage:image forState:UIControlStateNormal];
//
//}

-(void)emotionTaped:(UITapGestureRecognizer*)gestureRecognizer{
    self.emotionCellTapGestureBlock(self.item);
}

-(void)emotionLongPressed:(UILongPressGestureRecognizer*)gestureRecognizer{
    self.emotionCellLongPressedGestureBlock(self.item);
}
@end
