//
//  SharingBaseCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
//utilites
//child viewController
//subviews
#import "FLXKBaseSharingPictureLayoutView.h"
//subclass
//#import "FLXKSharingFuLingOnlineStyleCell.h"
//models
#import "FLXKSharingCellModel.h"
#import "SharingCommentCellModel.h"

@interface FLXKSharingBaseCell : UITableViewCell
//IBOutlet
//IBAction
//头像点击事件
//名称
//分享的文本内容
//分享的图片
//分享时间戳
//删除分享

//点赞
//评论
//分享


//child viewController
//subviews
//models
@property (strong, nonatomic)FLXKSharingCellModel* sharingCellModel;
//UI state record properties
@end

