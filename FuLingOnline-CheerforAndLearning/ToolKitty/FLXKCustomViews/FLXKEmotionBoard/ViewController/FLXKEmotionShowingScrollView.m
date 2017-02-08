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

@interface FLXKEmotionShowingScrollView() <FLXKEmotionCollectionViewDelegate>

@end

@implementation FLXKEmotionShowingScrollView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [[EmotionGroup selectAll]enumerateObjectsUsingBlock:^(EmotionGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx==2) {
                NSArray<FLXKEmotionCollectionView*>* views=[FLXKEmotionCollectionView setupEmotionViewsWithGroupId:obj.id];
                self.contentSize=CGSizeMake( Screen_Width*views.count, self.height);
                for (int i=0; i<views.count; i++) {
                    views[i].left=Screen_Width*i;
                    NSLog(@"NSStringFromCGRect:%d %@", i,NSStringFromCGRect(views[i].frame));
                    [self addSubview:views[i]];

                    //get FLXKEmotionBoard
                        views[i].emotionSelectedDelegate= self;
//                    views[i].emotionSelectedDelegate= [FLXKEmotionBoard sharedEmotionBoard];
                }
            }
        }];
    }
    self.pagingEnabled=YES;
    
    return self;
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
@end
