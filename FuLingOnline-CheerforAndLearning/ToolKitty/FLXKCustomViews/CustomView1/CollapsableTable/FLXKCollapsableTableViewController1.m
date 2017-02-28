//
//  FLXKCollapsableTable.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/5.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKCollapsableTableViewController1.h"

@implementation FLXKCollapsableTableViewController1
#pragma mark - RRNCollapsableTableView
//init set default values
-(NSString *)sectionHeaderNibName {
    return @"ArrowSectionHeaderView";
}

-(NSBundle *)sectionHeaderNibBundle {
    return [NSBundle bundleForClass:NSClassFromString([self sectionHeaderNibName])];
}

-(BOOL)singleOpenSelectionOnly {
    return YES;
}

//need to be override
-(UITableView *)collapsableTableView {
    return nil;
}

//need to be override
-(NSArray <RRNCollapsableTableViewSectionModelProtocol> *)model {
    return nil;
}


@end
