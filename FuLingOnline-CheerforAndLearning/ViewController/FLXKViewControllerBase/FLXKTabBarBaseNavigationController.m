//
//  FLXKTabBarBaseNavigationController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/18.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKTabBarBaseNavigationController.h"

//#import "UINavigationBar+Awesome.h"

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

#pragma mark - <UINavigationControllerDelegate>

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = navigationController.topViewController.transitionCoordinator;
    
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if (context.isInteractive) {
            if (self.childViewControllers.count==1) {
                [self.navigationBar setBarTintColor:NAVIGATION_BAR_BARTINTCOLOR];
                [self.navigationBar setTintColor:NAVIGATION_BAR_TINTCOLOR];
                  [[[self.navigationBar subviews] objectAtIndex:0] setBackgroundColor:NAVIGATION_BAR_BARTINTCOLOR];
            }
            else{
                [self.navigationBar setBarTintColor:NAVIGATION_BAR_DETAIL_BARTINTCOLOR];
                [self.navigationBar setTintColor:NAVIGATION_BAR_DETAIL_TINTCOLOR];
            }
        }
        else{
            if (self.childViewControllers.count==1) {
                [self.navigationBar setBarTintColor:[UIColor orangeColor]];
//                [[self.navigationBar subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    NSLog(@"idx:%lu,obj:%@",(unsigned long)idx,obj);
//                }];
                [[[self.navigationBar subviews] objectAtIndex:0] setBackgroundColor:NAVIGATION_BAR_BARTINTCOLOR];
                [self.navigationBar setTintColor: NAVIGATION_BAR_TINTCOLOR];
            }
            else{
                [self.navigationBar setBarTintColor:NAVIGATION_BAR_DETAIL_BARTINTCOLOR];
                [self.navigationBar setTintColor:NAVIGATION_BAR_DETAIL_TINTCOLOR];

            }
        }
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
    // This code is responsible for adjusting the correct navigation bar style when the user starts a side swipe gesture, but does not finish it.
    [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled]) {
            UIViewController *sourceViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            [self.navigationBar setBarTintColor:NAVIGATION_BAR_DETAIL_BARTINTCOLOR];
            [self.navigationBar setTintColor:NAVIGATION_BAR_DETAIL_TINTCOLOR];

        }
    }];
    
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

}

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

