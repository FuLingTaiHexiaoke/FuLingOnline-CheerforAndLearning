//
//  FLXKTabBarController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKTabBarController.h"

@interface FLXKTabBarController ()<UIGestureRecognizerDelegate>

@end

@implementation FLXKTabBarController

#pragma mark -
#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置TabBar tintColor
    // 方式一
//    self.tabBar.tintColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //setup navigationController
//    self.navigationController.navigationBarHidden=YES;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden=NO;
}

-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UICollectionViewDataSource

#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods
@end
