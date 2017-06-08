//
//  FLXKBaseSharingLikeCollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "FriendsMomentSharingConfig.h"

@interface FLXKBaseSharingLikeCollectionView : UICollectionView

@property(nonatomic)NSArray<UserModel*>* likeTheSharingUserRecords;
@property(nonatomic,assign)CGFloat rowHeight;

@end

