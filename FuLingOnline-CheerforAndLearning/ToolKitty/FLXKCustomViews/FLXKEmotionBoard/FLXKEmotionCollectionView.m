//
//  FLXKNomalEmotionCollectionView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionCollectionView.h"

//views
#import "FLXKEmotionCollectionViewNomalCell.h"

//models
#import "EmotionItem.h"



#define CollectionViewFrame CGRectMake(0, 0, FULL_WIDTH, 197)
#define Cell_FLXKEmotionCollectionViewNomalCell @"FLXKEmotionCollectionViewNomalCell"

@interface FLXKEmotionCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,assign)NSInteger groupId;
@property(nonatomic,strong)NSArray<EmotionItem*>* emotionItems;
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
    flowLayout.itemSize=CGSizeMake(50, 50);
//    self.collectionViewLayout=flowLayout;
    
//    self=[super initWithFrame:frame];
   self= [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
//        UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
//        flowLayout.itemSize=CGSizeMake(50, 50);
//        self.collectionViewLayout=flowLayout;
        self.emotionItems=emotionItems;
        self.dataSource=self;
        self.delegate=self;
        
        [self registerNib:[UINib nibWithNibName:@"FLXKEmotionCollectionViewNomalCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Cell_FLXKEmotionCollectionViewNomalCell];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return   self.emotionItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKEmotionCollectionViewNomalCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKEmotionCollectionViewNomalCell forIndexPath:indexPath];
//    cell.item= self.emotionItems[indexPath.item];
    cell.imageView.image=[UIImage imageNamed:self.emotionItems[indexPath.item].emotionItemSmallImageUrl];
    return cell;
}

#pragma mark - Private Methods
//-(NSArray<EmotionItem*>*)emotionItems{
//    if (!_emotionItems) {
//   self.emotionItems= [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)self.groupId]];
//    }
//    return self.emotionItems;
//}

@end
