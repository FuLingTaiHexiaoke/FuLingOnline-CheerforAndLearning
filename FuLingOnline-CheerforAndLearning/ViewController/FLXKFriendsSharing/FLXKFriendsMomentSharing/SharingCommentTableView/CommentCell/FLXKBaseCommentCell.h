//
//  FLXKCommentCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharingCommentCellModel.h"
#import "UIView+Extension_IdentifierForReusable.h"

@interface FLXKBaseCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *testlabel;
@property (strong, nonatomic)  SharingCommentCellModel  *model;
@end
