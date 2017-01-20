//
//  FLXKEmotionGroupIndexCollectionView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionGroupIndexCollectionView.h"

//utilities
#import "UIImage+EmotionExtension.h"

//config
#import "FLXKEmotionConfig.h"

//entity
#import "EmotionGroup.h"

//subviews
#import "FLXKNormalEmotionGroupCollectionViewCell.h"

@interface FLXKEmotionGroupIndexCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSArray<EmotionGroup*>* emotionGroups;

@end

@implementation FLXKEmotionGroupIndexCollectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        _emotionGroups=[EmotionGroup selectAll];
        
        //init self properties
        self.dataSource=self;
        self.delegate=self;
                [self registerNib:[UINib nibWithNibName:Cell_FLXKNormalEmotionGroupCollectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Cell_FLXKNormalEmotionGroupCollectionViewCell];
    }
    return self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return   self.emotionGroups.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKNormalEmotionGroupCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKNormalEmotionGroupCollectionViewCell forIndexPath:indexPath];
    //    cell.item= self.emotionItems[indexPath.item];
    [cell.groupEmotionButton setImage:[UIImage ImageWithName:self.emotionGroups[indexPath.item].emotionGroupImageUrl] forState:UIControlStateNormal];
    //    cell.imageView.image=[UIImage imageNamed:self.emotionItems[indexPath.item].emotionItemSmallImageUrl];
    return cell;
}


@end
