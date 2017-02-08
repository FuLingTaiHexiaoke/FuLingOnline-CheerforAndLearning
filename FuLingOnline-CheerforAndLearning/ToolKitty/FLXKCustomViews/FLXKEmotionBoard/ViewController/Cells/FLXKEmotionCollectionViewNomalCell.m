//
//  FLXKEmotionCollectionViewNomalCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionCollectionViewNomalCell.h"

#import "UIImage+EmotionExtension.h"
#import "UIImage+GIF.h"

@interface FLXKEmotionCollectionViewNomalCell()


@end

@implementation FLXKEmotionCollectionViewNomalCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //add GestureRecognizer
    self.emotionImageView.hidden=YES;
    self.emotionImageView.userInteractionEnabled=YES;//must be set to yes for user Interaction Enable
    
    
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emotionTaped:)];
    
    [self.emotionImageView addGestureRecognizer:tapGesture];
    [self.emotionButton addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer* longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(emotionLongPressed:)];
    [self.emotionImageView addGestureRecognizer:longPressGesture];
    [self.emotionButton addGestureRecognizer:longPressGesture];
}

//0:basic_text_emotion_image
//1:emoji_text_emotion_image
//2:additonal_text_emotion_image
//3:recent_text_emotion_image
//4:big_static_image
//5:big_gif_image

-(void)setEmotionItem:(EmotionItem *)item{
    if (!item) {
//        self.emotionButton.hidden=YES;
//        self.emotionImageView.hidden=NO;
//        self.emotionImageView.userInteractionEnabled=YES;
//        self.emotionImageView.image=[UIImage ImageWithName:@"del_emoji_normal"];
             [self.emotionButton setImage:[UIImage ImageWithName:@"del_emoji_normal"] forState:UIControlStateNormal];
        return;
    }
        self.item=item;
        if ( item.emotionItemImageType==0) {
//            [self sendSubviewToBack:self.emotionButton];
//            self.emotionButton.hidden=YES;
//            self.emotionImageView.hidden=NO;
            [self.emotionButton setImage:[UIImage ImageWithName:item.emotionItemSmallImageUrl] forState:UIControlStateNormal];
//            self.emotionImageView.image=[UIImage imageNamed:item.emotionItemSmallImageUrl];
        }
        else  if (item.emotionItemImageType==1) {
//            self.emotionButton.hidden=NO;
//            self.emotionImageView.hidden=YES;
            [self.emotionButton setTitle:item.emotionItemName forState:UIControlStateNormal];
        }
        else  if (item.emotionItemImageType==5) {
   [self.emotionButton setImage:[UIImage sd_animatedGIFNamed:item.emotionItemSmallImageUrl] forState:UIControlStateNormal];
        }
}

-(void)emotionTaped:(UITapGestureRecognizer*)gestureRecognizer{
    if (self.emotionCellTapGestureBlock) {
        self.emotionCellTapGestureBlock(self.item);
    }
}

-(void)emotionLongPressed:(UILongPressGestureRecognizer*)gestureRecognizer{
    if (self.emotionCellLongPressedGestureBlock) {
        self.emotionCellLongPressedGestureBlock(self.item);
    }
}
@end
