//
//  FLXKTabBarBaseNavigationController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKTabBarBaseNavigationController.h"

@interface FLXKTabBarBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation FLXKTabBarBaseNavigationController

#pragma mark -
#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - UINavigationControllerDelegate

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.childViewControllers.count==1) {
//        [self.navigationBar setBarTintColor:[UIColor orangeColor]];
//    }
//    else{
//        [self.navigationBar setBarTintColor:[UIColor lightGrayColor]];
//    }
//}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.childViewControllers.count==1) {
//        [self.navigationBar setBarTintColor:[UIColor orangeColor]];
//    }
//    else{
//        [self.navigationBar setBarTintColor:[UIColor lightGrayColor]];
//    }
//
//}

#pragma mark -
#pragma mark - Public Methods

//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    viewController.hidesBottomBarWhenPushed=YES;
//    [super pushViewController:viewController animated:animated];
//}

#pragma mark -
#pragma mark - Private Methods

@end
