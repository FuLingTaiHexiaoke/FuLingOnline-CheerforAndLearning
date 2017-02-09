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
#import "EmotionItem.h"

static NSInteger lastViewIndex;

@implementation FLXKNormalEmotionGroupCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //add GestureRecognizer
    
    //    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(groupEmotionButtonTaped:)];
    //    [self.groupEmotionButton addGestureRecognizer:tapGesture];
}

-(void)setEmotionGroup:(EmotionGroup *)emotionGroup{
    emotionGroup=emotionGroup;
    //set image
    
    self.groupEmotionButton.userInteractionEnabled=NO;
    if (emotionGroup.emotionGroupImageType==1) {
        [self.groupEmotionButton setTitle:emotionGroup.emotionGroupImageUrl forState:UIControlStateNormal];
    }
    else{
        if (emotionGroup.emotionGroupImageType==5){
            if (![emotionGroup.emotionGroupImageUrl containsString:@".gif"]) {
                emotionGroup.emotionGroupImageUrl=[NSString stringWithFormat:@"%@.gif",emotionGroup.emotionGroupImageUrl ];
            }
        }
        UIImage* image=[UIImage imageNamed:emotionGroup.emotionGroupImageUrl];
        [self.groupEmotionButton setImage:image forState:UIControlStateNormal];
    }
    
    //get group showing range
    NSArray<EmotionItem*>* totalEmotionItems=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)emotionGroup.id]];
    NSInteger pageCount= totalEmotionItems.count/emotionGroup.emotionGroupPerPageCount;
    pageCount=(totalEmotionItems.count%emotionGroup.emotionGroupPerPageCount)>0?pageCount+1:pageCount;
    self.groupPagesRange=NSMakeRange(lastViewIndex, pageCount);
    
    lastViewIndex+=pageCount;
}

@end
