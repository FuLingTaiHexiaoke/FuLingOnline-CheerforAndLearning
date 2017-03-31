//
//  FLXKBaseSharingCommentTableView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
//utilites

//models
//#import "SharingCommentCellModel.h"
@class SharingCommentCellModel;
//subviews
//child viewController
@interface FLXKBaseSharingCommentTableView : UITableView
//IBOutlet
//IBAction
-(CGFloat)setCellModels:(NSArray<SharingCommentCellModel *> *)models;
//models
@property (strong, nonatomic)NSArray<SharingCommentCellModel *> *  models;
//UI state record properties
//subviews
//child viewController
@end
