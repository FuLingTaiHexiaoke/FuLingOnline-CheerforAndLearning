//
//  FLXKtestUICollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/5/6.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

//utilites
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "FLXKSharingImagesModel.h"


@interface FLXKtestUICollectionView : UICollectionView
@property(nonatomic,assign)CGFloat viewHeight;
@property(nonatomic,assign)CGFloat viewWidth;

@property(nonatomic)NSArray<FLXKSharingImagesModel*>* imageArray;

@end
