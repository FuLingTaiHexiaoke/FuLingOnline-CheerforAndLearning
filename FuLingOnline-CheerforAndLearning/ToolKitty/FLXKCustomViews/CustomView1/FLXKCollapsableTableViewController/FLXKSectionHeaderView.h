//
//  FLXKSectionHeaderView.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionHeaderViewModel.h"
@class FLXKSectionHeaderView;
@protocol FLXKSectionHeaderViewTapDelegate <NSObject>

@optional
-(void)headerView:(FLXKSectionHeaderView*)headview didTapedAtIndex:(NSInteger)tapedSection;
@end

@interface FLXKSectionHeaderView : UITableViewHeaderFooterView
@property (strong, nonatomic)SectionHeaderViewModel* titleModel;
@property(weak,nonatomic)id<FLXKSectionHeaderViewTapDelegate> delegate;
@end

