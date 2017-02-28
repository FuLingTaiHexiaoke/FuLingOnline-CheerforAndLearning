//
//  FLXKCollapsableTableModel.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionHeaderViewModel.h"

@interface FLXKCollapsableTableModel : NSObject
@property (nonatomic, strong) SectionHeaderViewModel *titleModel;
@property (nonatomic, strong) NSNumber *isVisible;
@property (nonatomic, strong) NSArray *items;
@end
