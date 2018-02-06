//
//  EmotionGroupDetailModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionGroupDetailModel : NSObject
@property(nonatomic,assign)NSInteger groupId;
@property(nonatomic,strong)NSString* groupName;
@property(nonatomic,assign)NSRange groupRange;//包含view开始的位置和views的数量
@property(nonatomic,assign)NSInteger groupStartIndex;
@property(nonatomic,assign)NSInteger groupEndIndex;
@property(nonatomic,strong)NSString* groupImageUrl;
@property(nonatomic,strong)NSArray<UICollectionView*>* groupCollectionView;
@end
