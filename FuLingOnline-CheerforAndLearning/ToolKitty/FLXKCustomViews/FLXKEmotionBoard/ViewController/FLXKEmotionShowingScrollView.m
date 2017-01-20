//
//  FLXKEmotionShowingScrollView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionShowingScrollView.h"

//views
#import "FLXKEmotionCollectionView.h"

//Entity
#import "EmotionGroup.h"

@implementation FLXKEmotionShowingScrollView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [[EmotionGroup selectAll]enumerateObjectsUsingBlock:^(EmotionGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx==0) {
                NSArray<FLXKEmotionCollectionView*>* views=[FLXKEmotionCollectionView setupEmotionViewsWithGroupId:obj.id];
                self.contentSize=CGSizeMake( self.width*views.count, self.height);
                for (int i=0; i<views.count; i++) {
                    views[i].left=self.width*i;
                    NSLog(@"%@",NSStringFromCGRect(views[i].frame));
                    [self addSubview:views[i]];
                }
            }
        }];
    }
    return self;
}

@end
