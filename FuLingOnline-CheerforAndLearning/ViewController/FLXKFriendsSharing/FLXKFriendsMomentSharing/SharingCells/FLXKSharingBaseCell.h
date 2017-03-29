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

@interface FLXKSharingBaseCell : UITableViewCell
//IBOutlet
//IBAction
//child viewController
//subviews
//models
@property (strong, nonatomic)FLXKSharingCellModel* sharingCellModel;
//UI state record properties
@end

