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

//config
#import "FLXKEmotionConfig.h"

//views
#import "FLXKEmotionBoard.h"
#import "FLXKEmotionCollectionViewNomalCell.h"

//models
#import "EmotionItem.h"
#import "EmotionGroup.h"


@interface FLXKEmotionCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)EmotionGroup* emotionGroup;
//@property(nonatomic,strong)NSMutableDictionary<UIImage*,NSString*>* reuseImagesDictionary;

@end

@implementation FLXKEmotionCollectionView
//将这些model动态生成CollectionView

//+(NSArray<FLXKEmotionCollectionView*>*) setupEmotionViewsWithGroupId:(NSInteger)groupId emotionGroup:(EmotionGroup*)emotionGroup{
//    NSMutableArray<FLXKEmotionCollectionView*>* collectionViews=[NSMutableArray array];
//    NSArray<EmotionItem*>* totalEmotionItems=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)groupId]];
//    NSInteger leftItems=0;
//    NSInteger PerPageItemsCount=emotionGroup.emotionGroupPerPageCount;
//    for (NSInteger i=0; i<totalEmotionItems.count; i+=PerPageItemsCount) {
//        leftItems=i+PerPageItemsCount<totalEmotionItems.count?PerPageItemsCount:totalEmotionItems.count-i;
//        NSArray<EmotionItem*>*  subEmotionItems=  [totalEmotionItems objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, leftItems)]];
//        FLXKEmotionCollectionView*  collectionView= [[FLXKEmotionCollectionView alloc]initWithFrame:CollectionViewFrame withEmotionItems:subEmotionItems emotionGroup:emotionGroup];
//        [collectionViews addObject:collectionView];
//    }
//    return collectionViews;
//}
+(NSArray*) setupEmotionViewsWithGroupId:(NSInteger)groupId emotionGroup:(EmotionGroup*)emotionGroup withFrame:(CGRect)frame {
    NSMutableArray<FLXKEmotionCollectionView*>* collectionViews=[NSMutableArray array];
    NSMutableArray< NSArray<EmotionItem*>*>* subEmotionItemsPerView=[NSMutableArray array];
    NSArray<EmotionItem*>* totalEmotionItems=  [EmotionItem selectByCriteria:[NSString stringWithFormat:@"where groupId=%ld",(long)groupId]];
    NSInteger leftItems=0;
    NSInteger PerPageItemsCount=emotionGroup.emotionGroupPerPageCount;
    for (NSInteger i=0; i<totalEmotionItems.count; i+=PerPageItemsCount) {
        leftItems=i+PerPageItemsCount<totalEmotionItems.count?PerPageItemsCount:totalEmotionItems.count-i;
        NSArray<EmotionItem*>*  subEmotionItems=  [totalEmotionItems objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, leftItems)]];
        FLXKEmotionCollectionView*  collectionView=nil;
        collectionView= [[FLXKEmotionCollectionView alloc]initWithFrame:frame withEmotionItems:nil emotionGroup:emotionGroup];
//             NSLog(@"FLXKEmotionCollectionView.frame:%@",NSStringFromCGRect(frame) );
        //        if (i==0) {
        //        collectionView= [[FLXKEmotionCollectionView alloc]initWithFrame:CollectionViewFrame withEmotionItems:subEmotionItems emotionGroup:emotionGroup];
        //        }
        //        else{
        //        collectionView= [[FLXKEmotionCollectionView alloc]initWithFrame:CollectionViewFrame withEmotionItems:nil emotionGroup:emotionGroup];
        //        }
        [subEmotionItemsPerView addObject:subEmotionItems];
        [collectionViews addObject:collectionView];
    }
    return @[collectionViews,subEmotionItemsPerView];
    //    return collectionViews;
}

-(instancetype)initWithFrame:(CGRect)frame withEmotionItems:(NSArray<EmotionItem*>*)emotionItems  emotionGroup:(EmotionGroup*)emotionGroup{
    
    self.emotionGroup=emotionGroup;
    //    self.reuseImagesDictionary=reuseImagesDictionary;
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //    NSInteger  itemWidth=FBTweakValue(@"Emotion", @"FLXKEmotionCollectionView",  @"itemWidth", 30);
    NSInteger  itemWidth=self.emotionGroup.emotionGroupPerPageItemWidth;
    NSInteger  colunms=self.emotionGroup.emotionGroupPerPageColunms;
    NSInteger  rows=self.emotionGroup.emotionGroupPerPageLines;
    flowLayout.minimumInteritemSpacing= (Screen_Width-colunms*itemWidth)/(colunms+1);
    flowLayout.minimumLineSpacing=(frame.size.height-rows*itemWidth)/(rows+1);
    flowLayout.itemSize=CGSizeMake(itemWidth, itemWidth);
    self= [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if (self) {
        self.pagingEnabled=YES;
        self.contentInset=UIEdgeInsetsMake( flowLayout.minimumLineSpacing, flowLayout.minimumInteritemSpacing, flowLayout.minimumLineSpacing ,flowLayout.minimumInteritemSpacing);
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
    if (self.emotionItems) {
        return   self.emotionGroup.emotionGroupIsShowingDeleteButton?self.emotionItems.count+1:self.emotionItems.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKEmotionCollectionViewNomalCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:Cell_FLXKEmotionCollectionViewNomalCell forIndexPath:indexPath];
    if (indexPath.item<self.emotionItems.count) {
        //        [cell setEmotionItem: self.emotionItems[indexPath.item]];
        [cell setItem: self.emotionItems[indexPath.item]];
        cell.emotionCellTapGestureBlock=^(EmotionItem* emotionItem){
            if ([self.emotionSelectedDelegate respondsToSelector:@selector(didSelectedEmotionItem:)])
            {
                [self recordRecentSelectedEmotionItem:emotionItem];
                [self.emotionSelectedDelegate didSelectedEmotionItem:emotionItem];
            }
        };
    }
    else{
        [cell setItem:nil];
        cell.emotionCellTapGestureBlock=^(EmotionItem* emotionItem){
            if ([self.emotionSelectedDelegate respondsToSelector:@selector(deleteElementInTextView)])
            {
                [self.emotionSelectedDelegate deleteElementInTextView];
            }
        };
    }
    return cell;
}

//0:basic_text_emotion_image
//1:emoji_text_emotion_image
//2:additonal_text_emotion_image
//3:recent_text_emotion_image
//4:big_static_image
//5:big_gif_image

-(void)recordRecentSelectedEmotionItem:(EmotionItem* )emotionItem{
    EmotionItem* item=[emotionItem copy];
    
    item.id=[[NSDate date]timeIntervalSince1970];
    item.groupId=5;
    
    [EmotionItem insertWithObject:item success:^{    } failure:nil];
    
    NSArray<EmotionItem*> * tempItems=[EmotionItem selectByCriteria:@" where groupId=5 order by id asc "];
    if (tempItems.count>21) {
        [EmotionItem deleteWithWhereString:[NSString stringWithFormat:@" where id=%ld ",(long)tempItems[0].id] success:nil failure:nil];
    }
    
//    [FLXKEmotionBoard reloadPages];
}


@end
