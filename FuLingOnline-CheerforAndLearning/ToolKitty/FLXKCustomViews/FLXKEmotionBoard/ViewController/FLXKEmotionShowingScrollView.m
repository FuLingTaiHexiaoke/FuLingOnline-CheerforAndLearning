//
//  FLXKEmotionShowingScrollView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionShowingScrollView.h"

//config
#import "FLXKEmotionConfig.h"

//views
#import "FLXKEmotionBoard.h"
#import "FLXKEmotionCollectionView.h"

//Entity
#import "EmotionGroup.h"
#import "EmotionItem.h"

@interface FLXKEmotionShowingScrollView() <FLXKEmotionCollectionViewDelegate>

//懒加载控制
//state property
//@property(nonatomic,assign)NSInteger currentShowingPageIndex;
@property(nonatomic,strong)NSMutableArray<NSNumber*>* imageLoadedPageIndexArray;
@property(nonatomic,strong)NSMutableArray<FLXKEmotionCollectionView*>* totalShowingCollectionViews;
@property(nonatomic,strong)NSMutableArray<NSArray<EmotionItem*>*>* totalShowingEmotionItems;

@end

@implementation FLXKEmotionShowingScrollView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //init array
        self.imageLoadedPageIndexArray=[NSMutableArray array];
        self.totalShowingCollectionViews=[NSMutableArray array];
        self.totalShowingEmotionItems=[NSMutableArray array];
        
        //set kvo for currentShowingPageIndex
        
        __block NSInteger lastCollectionViewIndex=-1;
        [[EmotionGroup selectAll]enumerateObjectsUsingBlock:^(EmotionGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //save loaded image page
//            [self.imageLoadedPageIndexArray addObject:@(lastCollectionViewIndex+1)];
            
            //get viewsAndEntities
            NSArray* viewsAndEntities=[FLXKEmotionCollectionView setupEmotionViewsWithGroupId:obj.id emotionGroup:obj];
            
            //insert containers
            NSArray<FLXKEmotionCollectionView*>* views=viewsAndEntities[0];
            [self.totalShowingCollectionViews  addObjectsFromArray:views];
            [self.totalShowingEmotionItems  addObjectsFromArray:viewsAndEntities[1]];
            
            //add subviews
            for (int i=0; i<views.count; i++) {
                lastCollectionViewIndex++;
                views[i].left=Screen_Width*lastCollectionViewIndex;
                NSLog(@"NSStringFromCGRect:%d %@", i,NSStringFromCGRect(views[i].frame));
                [self addSubview:views[i]];
                views[i].emotionSelectedDelegate= self;
            }
        }];
        [self setCurrentShowingPageIndex:0];
        self.contentSize=CGSizeMake( Screen_Width*(lastCollectionViewIndex+1), CollectionViewHeight);
               NSLog(@"NSStringFromCGRect self.height: %@",NSStringFromCGRect(self.frame));
        self.pagingEnabled=YES;
    }
    
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setCurrentShowingPageIndex:0];
    self.contentSize=CGSizeMake( Screen_Width*self.totalShowingCollectionViews.count, CollectionViewHeight);
    NSLog(@"NSStringFromCGRect self.height: %@",NSStringFromCGRect(self.frame));
}

-(void)didSelectedEmotionItem:(EmotionItem*)emotionItem{
    if ([self.emotionSelectedDelegate respondsToSelector:@selector(didSelectedEmotionItem:)])
    {
        [self.emotionSelectedDelegate didSelectedEmotionItem: emotionItem];
    }
}

-(void)deleteElementInTextView{
    if ([self.emotionSelectedDelegate respondsToSelector:@selector(deleteElementInTextView)])
    {
        [self.emotionSelectedDelegate deleteElementInTextView];
    }
}

-(void)setCurrentShowingPageIndex:(NSInteger)currentShowingPageIndex{
    _currentShowingPageIndex=currentShowingPageIndex;
    //start to load views
    NSInteger frontPageIndex=currentShowingPageIndex>0?currentShowingPageIndex-1:currentShowingPageIndex;
    NSInteger nextPageIndex=currentShowingPageIndex<self.totalShowingCollectionViews.count-1?currentShowingPageIndex+1:currentShowingPageIndex;
    
    NSArray<NSNumber*> *shouldLoadImagePageIndexs=@[@(frontPageIndex),@(currentShowingPageIndex),@(nextPageIndex)];
    
    [shouldLoadImagePageIndexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.imageLoadedPageIndexArray containsObject:obj]) {
            return ;
        }
        else{
            [self.imageLoadedPageIndexArray addObject:obj];
            self.totalShowingCollectionViews[obj.integerValue].emotionItems= self.totalShowingEmotionItems[obj.integerValue];
            [self.totalShowingCollectionViews[obj.integerValue] reloadData];
        }
    }];
}
@end
