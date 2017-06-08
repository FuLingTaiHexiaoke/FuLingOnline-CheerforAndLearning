//
//  FLXKBaseSharingCommentTableView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SharingCommentCellModel;

@interface FLXKBaseSharingCommentTableView : UITableView

//public method
@property (strong, nonatomic)void(^addCommentRequsetBlock)(SharingCommentCellModel* model);

//models
@property (strong, nonatomic)NSArray<SharingCommentCellModel *> *  models;

@end
