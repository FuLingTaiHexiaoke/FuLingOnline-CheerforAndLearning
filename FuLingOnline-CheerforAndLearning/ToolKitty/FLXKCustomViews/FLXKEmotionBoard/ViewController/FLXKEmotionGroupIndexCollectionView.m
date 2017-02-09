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

-(void)awakeFromNib{
    [super awakeFromNib];
    self.dataSource=self;
    self.delegate=self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return   self.emotionGroups.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKNormalEmotionGroupCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKNormalEmotionGroupCollectionViewCell forIndexPath:indexPath];
    cell.emotionGroup= self.emotionGroups[indexPath.item];
    //    cell.groupEmotionCellTapGestureBlock=^(NSRange range){
    //        if ([self.emotionSelectedDelegate respondsToSelector:@selector(didSelectedEmotionItem:)])
    //        {
    //            [self.emotionSelectedDelegate didSelectedEmotionItem:emotionItem];
    //        }
    //    };
    //    [cell.groupEmotionButton setImage:[UIImage ImageWithName:self.emotionGroups[indexPath.item].emotionGroupImageUrl] forState:UIControlStateNormal];
    //    cell.imageView.image=[UIImage imageNamed:self.emotionItems[indexPath.item].emotionItemSmallImageUrl];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //reset selected state
    NSArray<__kindof FLXKNormalEmotionGroupCollectionViewCell *>*  cells=(NSArray<__kindof FLXKNormalEmotionGroupCollectionViewCell *>*)[collectionView visibleCells];
    [cells enumerateObjectsUsingBlock:^(__kindof FLXKNormalEmotionGroupCollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.groupEmotionBackgroundView.backgroundColor=[UIColor whiteColor];
        obj.groupEmotionButton.backgroundColor=[UIColor whiteColor];
    }];
    
    FLXKNormalEmotionGroupCollectionViewCell* cell= ( FLXKNormalEmotionGroupCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.emotionGroupSelectedDelegate respondsToSelector:@selector(didSelectedEmotionGroupItem:)])
    {
        [self.emotionGroupSelectedDelegate didSelectedEmotionGroupItem:cell.groupPagesRange];
    }
    
    //set selected state
    cell.groupEmotionBackgroundView.backgroundColor=RGBA(243,244,246,1.0);
    cell.groupEmotionButton.backgroundColor=RGBA(243,244,246,1.0);
}

@end
