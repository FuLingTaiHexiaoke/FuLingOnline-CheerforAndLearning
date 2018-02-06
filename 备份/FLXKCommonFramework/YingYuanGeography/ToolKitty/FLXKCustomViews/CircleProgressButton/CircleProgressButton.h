//
//  CircleProgressButton.h
//  test
//
//  Created by 肖科 on 17/7/19.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

#define default_frontColor [UIColor orangeColor]
#define default_backColor [UIColor redColor]

#define default_progressAnimationRepeatCount 200
#define default_progressAnimationDuration 3

@class CircleProgressButton;
typedef void (^InitBuilderBlock)(CircleProgressButton* builder);

@interface CircleProgressButton : UIButton
@property(nonatomic,strong) InitBuilderBlock initBuilderBlock;

//基本状态参数
@property(nonatomic,strong) UIColor *frontColor;
@property(nonatomic,strong) UIColor *backColor;
@property(nonatomic,strong) UIColor *frontLabelColor;
@property(nonatomic,strong) UIColor *backLableColor;
@property(nonatomic,strong) NSString *imageName;
@property(nonatomic,strong) NSString *coverImageName;
//taskPercent<=1.0f
@property(nonatomic,assign) CGFloat taskPercent;
@property(nonatomic,assign) NSInteger taskScore;
@property(nonatomic,assign) BOOL isUnLock;

//自定义动画参数
@property(nonatomic,assign) CGFloat progressAnimationRepeatCount;
@property(nonatomic,assign) CGFloat progressAnimationDuration;

//推荐初始化方法
- (instancetype)initWithFrame:(CGRect)frame withBuilder:(InitBuilderBlock)initBuilderBlock;

//给shaper layer 添加动画效果
- (void)addCircleProgressAnimationToShaperLayer;
@end
