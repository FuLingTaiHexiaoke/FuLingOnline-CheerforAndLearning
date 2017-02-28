//
//  FLXKSegmentContainerViewController.h
//  Psy-CommonFramework
//
//  Created by xiaoke on 17/1/7.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLXKSegmentContainerViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, copy) NSArray *titles;

/** 指示视图的颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** segment的背景颜色 */
@property (nonatomic, strong) UIColor *segmentBgColor;
/**
 *  segment每一项的文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** segment每一项的宽 */
@property (nonatomic, assign) CGFloat itemWidth;
/** segment每一项的高 */
@property (nonatomic, assign) CGFloat itemHeight;
@end
