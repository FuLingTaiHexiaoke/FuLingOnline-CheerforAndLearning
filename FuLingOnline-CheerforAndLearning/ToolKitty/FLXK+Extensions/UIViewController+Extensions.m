//
//  UIViewController+Extensions.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/3.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "UIViewController+Extensions.h"
#import <objc/runtime.h>

#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

@implementation UIViewController (Extensions)
//提示框
- (void)showAlertWithMessage:(NSString*)message  comfirmAction:(dispatch_block_t)comfirmAction {
    [self showAlertWithTitle:@"系统提示" message:message comfirmAction:comfirmAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString*)message comfirmAction:(dispatch_block_t)comfirmAction {
    if (iOS8Later) {
        UIAlertController*   alertControllerVersionCheck = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [ alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
        }]];
        [alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            if (comfirmAction) {
                comfirmAction();
            }
        }]];
        [self presentViewController:alertControllerVersionCheck animated:YES completion:nil];
    } else {
        __weak __typeof(self) weakSelf=self;
        UIAlertView*  alerViewVersionCheck= [[UIAlertView alloc] initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerViewVersionCheck show];
    }
}
//手势
-(void)registerGestureForResignViewEditing{
    UITapGestureRecognizer* tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignViewEditing)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)resignViewEditing{
    [self.view endEditing:YES];
}

/**
 得到当前显示的VC
 */
- (UIViewController *)getTopMostVC{
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
    UIViewController *appRootVC =window.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
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

/**
 *  判断某个类是否有某个参数，防止 setvalue forkey 崩溃
 *
 */
- (BOOL)hasVariableWithClass:(Class) myClass varName:(NSString *)name{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

@end
