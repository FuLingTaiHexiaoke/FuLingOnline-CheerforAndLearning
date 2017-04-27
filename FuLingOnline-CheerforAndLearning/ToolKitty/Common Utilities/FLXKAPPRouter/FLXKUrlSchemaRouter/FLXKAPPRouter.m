//
//  FLXKURLSchemaRouter.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/10.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKAPPRouter.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//utilities
#import "NSURL+Extensions.h"

//config
//#import "RouterConfig.h"

@interface FLXKAPPRouter()

@property(nonatomic)NSArray<NSString*>* preDefinedKeys;

@end


@implementation FLXKAPPRouter


+(instancetype)sharedInstance{
    static FLXKAPPRouter* sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance= [[FLXKAPPRouter alloc]init];
        sharedInstance.preDefinedKeys=@[@"containerVCName",@"xibType",@"stName",@"stid"];
    });
    return sharedInstance;
}

+(BOOL)openURL:(NSURL *)url withScheme:(NSString *)scheme
{
    //    NSLog(@"%@",url);
    [[FLXKAPPRouter sharedInstance] handleSchemes:url];
    return [url.scheme isEqualToString:scheme];
}
-(void)handleSchemes:(NSURL *)url
{
    NSString *VCName = [url host];
    NSDictionary* queries= [url parseURLParamsToDic];
    [self jumpToVC:VCName withQueryDic:queries];
}
/**
 *  控制器的跳转
 *
 *  @param host   url的host
 *  @param querys 请求参数
 */
-(void)jumpToVC:(NSString *)VCName withQueryDic:(NSDictionary*)queries
{
    //get the Desired ViewController
    UIViewController* DesiredVC=  [self getDesiredVCWithName:VCName Queries:queries];
    if (DesiredVC) {
        //set ViewController properties
        [queries enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([self.preDefinedKeys containsObject:key]) {
                return ;
            }
            if ([self getVariableWithClass:[DesiredVC class] varName: key]) {
                [DesiredVC setValue:obj forKey:key];
            }else{
                UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"需要升级才能完成操作" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alv show];
            }
        }];
        
        //get current ViewController to show the Desired ViewController
        NSString* containerVCName=queries[@"containerVCName"];
        UIViewController *currentPresentingViewController = [self getDesiredPresentingViewController:[self getCurrentViewControllerContainer] withDesiredViewControllerContainerName:containerVCName];
        if (currentPresentingViewController.navigationController) {
            DesiredVC.hidesBottomBarWhenPushed = YES;
            [currentPresentingViewController.navigationController pushViewController:DesiredVC animated:YES];
        }else{
            [currentPresentingViewController presentViewController:DesiredVC animated:YES completion:nil];
        }
    }
}

-(UIViewController*)getDesiredVCWithName:(NSString *)VCName Queries:(NSDictionary*)queries{
    
    id DesiredVC = nil;
    NSString* xibType=queries[@"xibType"];
    if ([xibType isEqualToString:@"0"]) {
        DesiredVC = [[NSClassFromString(VCName) alloc] init];
    }
    else if ([xibType isEqualToString:@"1"]){
        DesiredVC =[(UIViewController*)[NSClassFromString(VCName) alloc] initWithNibName:VCName bundle:[NSBundle mainBundle]];
    }
    else if ([xibType isEqualToString:@"2"]){
        NSString* storyboardName=  queries[@"stName"];
        NSString* storyboardIdentifier=  queries[@"stid"];
        if (storyboardName &&storyboardIdentifier) {
            DesiredVC=[[UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:storyboardIdentifier];
        }
        else{
            
        }
    }
    if (!DesiredVC) {
        UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"需要升级才能完成操作" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alv show];
        return nil;
    }
    return   (UIViewController*)DesiredVC;
}

/**
 *  得到当前显示的ViewControllerContainer容器，比如UITabBarController，navigationController，或者简单的UIViewController
 *
 */
-(UIViewController *)getCurrentViewControllerContainer{
    
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
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
//        NSArray* a= [window subviews];
//        [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"nextResponder: %lu  : %@",(unsigned long)idx, [obj nextResponder]);
//        }];
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    return (UIViewController *)nextResponder;
}

- (UIViewController *)getDesiredPresentingViewController:(UIViewController*)currentViewControllerContainer withDesiredViewControllerContainerName:(NSString*)desiredViewControllerContainerName{
    
    __block UIViewController * desiredPresentingVC;
    //currentVCContainer 为 UITabBarController
    if ([currentViewControllerContainer isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)currentViewControllerContainer;
        //当前显示的tabbaritem上直接push
        if ([desiredViewControllerContainerName isEqualToString:@""]) {
            UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
            desiredPresentingVC=nav.childViewControllers.lastObject;
        }
          //先跳转到另外的tabbaritem再上push,containerVCName为目的tabbaritem基类
        else{
            __block  NSUInteger tabbarSelectedIndex=tabbar.selectedIndex;
            if (tabbar.childViewControllers) {
                [tabbar.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    //UINavigationController
                    if ([obj isKindOfClass:UINavigationController.class]) {
                        UINavigationController*  navigationController= (UINavigationController*)obj;
                        [navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull innerObj, NSUInteger innerIdx, BOOL * _Nonnull innerStop) {
                            if ([NSStringFromClass(innerObj.class) isEqualToString:desiredViewControllerContainerName]) {
                                desiredPresentingVC=innerObj;
                                tabbarSelectedIndex=idx;
                                [navigationController popToViewController:innerObj animated:NO];
                                *innerStop=YES;
                                *stop=YES;
                            }
                        }];
                    }
                    //Normal UIViewController
                    else if ([NSStringFromClass(obj.class) isEqualToString:desiredViewControllerContainerName]) {
                        desiredPresentingVC=obj;
                        tabbarSelectedIndex=idx;
                        *stop=YES;
                        
                    }
                }];
            }
            //找到了就让tabbar进行跳转
            tabbar.selectedIndex=tabbarSelectedIndex;
        }
        //        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        result=nav.childViewControllers.lastObject;
        //        [self getFinalCurrentVCFrom:finalCurrentVC withContainerVCName:containerVCName];
        
    }
    //currentVCContainer 为 UINavigationController
    else if ([currentViewControllerContainer isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)currentViewControllerContainer;
        desiredPresentingVC = nav.childViewControllers.lastObject;
//       finalCurrentVC= [self getFinalVCFromCurrentVC:finalCurrentVC withFinalVCContainerName:containerVCName];
//           [self getFinalVCFromCurrentVC:finalCurrentVC withFinalVCContainerName:containerVCName];
    }
     //currentVCContainer 为 UIViewController
    else{
        desiredPresentingVC = currentViewControllerContainer;
    }
    
    return desiredPresentingVC;
}
/**
 *  判断某个类是否有某个参数，防止 setvalue forkey 崩溃
 *
 */
- (BOOL)getVariableWithClass:(Class) myClass varName:(NSString *)name{
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
