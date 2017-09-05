//
//  ViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/11.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//



//修改时间:2017-4-24
//修改人:肖科
//修改内容:--注销下面的布局代码。
//修改原因: reset the self.frame.height by autolayout outside,not it self
//修改内容:注销下面的布局代码--。

//修改人:肖科    修改时间:2017-4-25  修改原因:placeholder重绘差这个条件
//修改内容:--修改如下。

//修改内容:修改如下--。


//修改人:肖科    修改时间:2017-7-31  修改原因:判断title是否包含内容，包含则titleLabel显示，不包含则titleLabel不显示。
//修改前源码:--源码如下。

//修改前源码:源码如下--。

//修改内容:--修改如下。

//修改内容:修改如下--。

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageview.image=[UIImage imageNamed:@"Spark"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//utilites


//child viewController


//subviews



//UI State Record Properties


//IBOutlet


//IBAction

#if DEBUG

#endif

#pragma mark -
#pragma mark - ViewController LifeCircle

-(void)dealloc{
  NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

#pragma mark -
#pragma mark - Memory Warning

#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UICollectionViewDataSource

#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods

//#define NSAssert1(condition, desc, arg1) NSAssert((condition), (desc), (arg1))
//#define NSAssert2(condition, desc, arg1, arg2) NSAssert((condition), (desc), (arg1), (arg2))
//#define NSAssert3(condition, desc, arg1, arg2, arg3) NSAssert((condition), (desc), (arg1), (arg2), (arg3))
//#define NSAssert4(condition, desc, arg1, arg2, arg3, arg4) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4))
//#define NSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4), (arg5))
//#define NSParameterAssert(condition) NSAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)
@end
