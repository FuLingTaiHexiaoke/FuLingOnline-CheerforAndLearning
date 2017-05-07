//
//  FLXKtestTableViewCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/5/6.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLXKSharingCellModel;

@interface FLXKtestTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic)  UITextView *textview;
@property(strong,nonatomic)FLXKSharingCellModel* model;
@end
