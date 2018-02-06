//
//  FLXKNavigationTitleSegmentsView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/28.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleSegmentSelectedBlock)(NSInteger selectedIndex);

@interface FLXKNavigationTitleSegmentsView : UIView


//DATA
@property(nonatomic,copy)NSArray<NSString*>* viewControllerTitles;
@property(nonatomic,assign)NSInteger currentTitleIndex;
@property(nonatomic,strong)TitleSegmentSelectedBlock titleSegmentSelectedBlock;

//UI
@property(nonatomic,copy)UIColor* titleColor;
@property(nonatomic,copy)UIColor* titleSelectedColor;
@property(nonatomic,copy)UIColor* bottomLineColor;

@property(nonatomic,assign)CGFloat bottomLineHeight;
@end
