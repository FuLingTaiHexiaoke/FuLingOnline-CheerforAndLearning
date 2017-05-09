//
//  FLXKBaseSharingLikeCollectionView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UserModel.h"
//utilites
#import "UIImageView+WebCache.h"
//models
//subviews
//child viewController
@interface FLXKBaseSharingLikeCollectionView : UICollectionView
//IBOutlet
//IBAction
//models
@property(nonatomic)NSArray<UserModel*>* likeTheSharingUserRecords;
//UI state record properties
@property(nonatomic,assign)CGFloat rowHeight;
//subviews
//child viewController
//public actions
@end

