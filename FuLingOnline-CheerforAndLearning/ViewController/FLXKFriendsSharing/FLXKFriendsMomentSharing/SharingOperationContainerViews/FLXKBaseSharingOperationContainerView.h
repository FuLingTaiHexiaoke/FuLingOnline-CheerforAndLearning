//
//  FLXKBaseSharingPictureLayoutView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

//utilites

#import "FLXKSharingCellModel.h"




@interface FLXKBaseSharingOperationContainerView : UIView

@property (strong, nonatomic)FLXKSharingCellModel* model;

@property (strong, nonatomic)NSIndexPath* indexPath;

-(void)setModel:(FLXKSharingCellModel *)model WithIndexPath:(NSIndexPath*)indexPath;

//点赞
//-(void)addFriendsharingThumbup;
@property (strong, nonatomic)void(^addThumbupBlock)(UIButton* sender);

//评论
//触发评论
@property (strong, nonatomic)void(^addCommentRequestBlock)();

@end
