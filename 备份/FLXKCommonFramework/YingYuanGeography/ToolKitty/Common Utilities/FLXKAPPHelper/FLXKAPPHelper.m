//
//  FLXKAPPHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/10.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKAPPHelper.h"

@implementation FLXKAPPHelper

//得到当前显示的NavigationViewControlle
- (UINavigationController*)currentNavigationViewController {
    UIViewController* currentViewController = [self getCurrentVC];
    return currentViewController.navigationController;
}

//得到当前显示的VC
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController*  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder =(UIViewController*) [frontView nextResponder];
    }
    //    if ([nextResponder isKindOfClass:[UITabBarController class]]){
    //        UITabBarController * tabbar = (UITabBarController *)nextResponder;
    //        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
    //        result=nav.childViewControllers.lastObject;
    //
    //    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
    //        UIViewController * nav = (UIViewController *)nextResponder;
    //        result = nav.childViewControllers.lastObject;
    //    }else{
    //        result = nextResponder;
    //    }
    result=[self currentViewControllerFrom:nextResponder];
    return result;
}

// 通过递归拿到当前控制器
- (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } // 如果传入的控制器是导航控制器,则返回最后一个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } // 如果传入的控制器是tabBar控制器,则返回选中的那个
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    else {
        return viewController;
    }
}


@end
