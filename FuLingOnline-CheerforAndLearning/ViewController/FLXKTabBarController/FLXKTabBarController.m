//
//  FLXKTabBarController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKTabBarController.h"

@interface FLXKTabBarController ()

@end

@implementation FLXKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置TabBar tintColor
    // 方式一
//    self.tabBar.tintColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTabBarItemsApperance{
    NSArray<__kindof UIViewController *> *viewControllers =  self.viewControllers;

}
@end
