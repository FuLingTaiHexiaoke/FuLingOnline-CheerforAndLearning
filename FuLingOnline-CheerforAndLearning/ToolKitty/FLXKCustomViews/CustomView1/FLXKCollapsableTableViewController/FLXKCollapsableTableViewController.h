//
//  FLXKCollapsableTableViewController.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
//model
#import "FLXKCollapsableTableModel.h"

@interface FLXKCollapsableTableViewController : UITableViewController
@property(nonatomic,strong)NSArray<FLXKCollapsableTableModel*>* models;
@end
