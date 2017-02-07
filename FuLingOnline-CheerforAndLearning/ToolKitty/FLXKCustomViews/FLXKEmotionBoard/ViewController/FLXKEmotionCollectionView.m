//
//  FLXKNomalEmotionCollectionView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionCollectionView.h"

//utilities
#import "UIImage+EmotionExtension.h"

//configv
#import "FLXKEmotionConfig.h"

//views

#import "FLXKEmotionCollectionViewNomalCell.h"

//models
#import "EmotionItem.h"






@interface FLXKEmotionCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,assign)NSInteger groupId;
@property(nonatomic,strong)NSArray<EmotionItem*>* emotionItems;

//layout property
@property (nonatomic) CGFloat miniInteritemSpacing;
@property (nonatomic) CGFloat miniLineSpacing;
@end

@implementation FLXKEmotionCollectionView
//将这些model动态生成CollectionView

+(NSArray<FLXKEmotionCollectionView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId{
    NSMutableArray<FLXKEmotionCollectionView*>* collectionViews=[NSMutableArray array];
    NSArray<EmotionItem*>* totalEmotionItems=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)groupId]];
    for (NSInteger i=0; i<60; i+=20) {
        NSArray<EmotionItem*>*  subEmotionItems=  [totalEmotionItems objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, 20)]];
        FLXKEmotionCollectionView*  collectionView= [[FLXKEmotionCollectionView alloc]initWithFrame:CollectionViewFrame withEmotionItems:subEmotionItems];
        [collectionViews addObject:collectionView];
    }
    return collectionViews;
}

-(instancetype)initWithFrame:(CGRect)frame withEmotionItems:(NSArray<EmotionItem*>*)emotionItems{
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.itemSize=CGSizeMake(30, 30);
    NSInteger  itemWidth=FBTweakValue(@"Emotion", @"FLXKEmotionCollectionView",  @"itemWidth", 30);
    self.miniInteritemSpacing=(Screen_Width-7*itemWidth)/8;
    self.miniLineSpacing=(CollectionViewHeight-3*itemWidth)/4;
    flowLayout.minimumInteritemSpacing= self.miniInteritemSpacing;
    flowLayout.minimumLineSpacing=self.miniLineSpacing;
    flowLayout.itemSize=CGSizeMake(itemWidth, itemWidth);

    self= [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //        UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
        //        flowLayout.itemSize=CGSizeMake(Screen_Width/7, CollectionViewHeight/3);
        //        self.collectionViewLayout=flowLayout;

        self.pagingEnabled=YES;
        //        self.contentInset=UIEdgeInsetsMake(FBTweakValue(@"Emotion", @"FLXKEmotionCollectionView",  @"Inset-top", 20), 10, 10, 10);
        //        self.contentInset=UIEdgeInsetsMake(self.miniLineSpacing, self.miniInteritemSpacing,self.miniLineSpacing , self.miniInteritemSpacing);
        self.contentInset=UIEdgeInsetsMake(self.miniLineSpacing, self.miniInteritemSpacing,self.miniLineSpacing , self.miniInteritemSpacing);
        self.backgroundColor=RGBA(243,244,246,1.0);
        self.emotionItems=emotionItems;
        self.dataSource=self;
        self.delegate=self;

        [self registerNib:[UINib nibWithNibName:@"FLXKEmotionCollectionViewNomalCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Cell_FLXKEmotionCollectionViewNomalCell];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return   self.emotionItems.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKEmotionCollectionViewNomalCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKEmotionCollectionViewNomalCell forIndexPath:indexPath];
    if (indexPath.item<20) {
        cell.item= self.emotionItems[indexPath.item];
        NSLog(@"indexPath.item %ld", (long)indexPath.item);
        //    [cell setItem:self.emotionItems[indexPath.item]];
        //    [cell.emotionButton setImage:[UIImage ImageWithName:self.emotionItems[indexPath.item].emotionItemSmallImageUrl] forState:UIControlStateNormal];
        cell.emotionImageView.image=[UIImage imageNamed:self.emotionItems[indexPath.item].emotionItemSmallImageUrl];
        cell.emotionCellTapGestureBlock=^(EmotionItem* emotionItem){
            if ([self.emotionSelectedDelegate respondsToSelector:@selector(didSelectedEmotionItem:)])
            {
                [self.emotionSelectedDelegate didSelectedEmotionItem:emotionItem];
            }
        };
    }
    else{
        cell.emotionImageView.image=[UIImage imageNamed:@"del_emoji_normal@2x.png"];
        cell.emotionCellTapGestureBlock=^(EmotionItem* emotionItem){
            if ([self.emotionSelectedDelegate respondsToSelector:@selector(deleteElementInTextView)])
            {
                [self.emotionSelectedDelegate deleteElementInTextView];
            }
        };
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"indexPath.item %ld", (long)indexPath.item);
//    if ([self.emotionSelectedDelegate respondsToSelector:@selector(didSelectedEmotionItem:)])
//    {
//        [self.emotionSelectedDelegate didSelectedEmotionItem: self.emotionItems[indexPath.item]];
//    }
//
//}

#pragma mark - Private Methods
//-(NSArray<EmotionItem*>*)emotionItems{
//    if (!_emotionItems) {
//   self.emotionItems= [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)self.groupId]];
//    }
//    return self.emotionItems;
//}

@end
