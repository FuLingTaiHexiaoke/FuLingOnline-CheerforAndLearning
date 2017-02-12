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
@property(nonatomic,assign)NSRange currentEmotionGroupsRange;
@property(nonatomic,strong)NSMutableArray<NSValue*>*  emotionGroupsRanges;
@end

@implementation FLXKEmotionGroupIndexCollectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        _emotionGroups=[EmotionGroup selectAll];
        self.emotionGroupsRanges =[NSMutableArray array];
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

-(void)selecteItemAtContentOffset:(CGFloat)contentOffset{
    //set init selected emotion group
//    if (!(self.currentEmotionGroupsRange.length>0)) {
//        NSIndexPath* initIndexPath= [NSIndexPath indexPathForItem:0 inSection:0];
//        [self  collectionView:self didSelectItemAtIndexPath:initIndexPath ];
//    }
//    else{
        [self.emotionGroupsRanges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange tempRange=obj.rangeValue;
            CGFloat tempStartLength=tempRange.location*Screen_Width;
            CGFloat tempContentLength=(tempRange.length-1)*Screen_Width;
            if (tempStartLength<=contentOffset&& contentOffset<=tempContentLength+tempStartLength) {
                NSIndexPath* currentIndexPath= [NSIndexPath indexPathForItem:idx inSection:0];
                [self  collectionView:self didSelectItemAtIndexPath:currentIndexPath ];
                *stop=YES;
            }
        }];

//    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return   self.emotionGroups.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKNormalEmotionGroupCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKNormalEmotionGroupCollectionViewCell forIndexPath:indexPath];
    cell.emotionGroup= self.emotionGroups[indexPath.item];
    [self.emotionGroupsRanges addObject:[NSValue valueWithRange:cell.groupPagesRange]];
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
        self.currentEmotionGroupsRange=cell.groupPagesRange;
    }

    //set selected state
    cell.groupEmotionBackgroundView.backgroundColor=RGBA(243,244,246,1.0);
    cell.groupEmotionButton.backgroundColor=RGBA(243,244,246,1.0);
}



//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//       //set init selected emotion group
//    if (indexPath.section==0&&indexPath.item==0) {
////        [self selectItemAtIndexPath:indexPath];
//             [self  collectionView:self didSelectItemAtIndexPath:indexPath ];
////        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//    }
////    //set init selected emotion group
////    if (!(self.currentEmotionGroupsRange.length>0)) {
////        NSIndexPath* initIndexPath= [NSIndexPath indexPathForItem:0 inSection:0];
////        [self  collectionView:self didSelectItemAtIndexPath:initIndexPath ];
////        //        selectItemAtIndexPath:initIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
////    }
//}

@end
