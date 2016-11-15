//
//  AppDelegate.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/11.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "AppDelegate.h"
#import "FLXKAppNotification.h"
#import "FLXKLaunchViewController.h"//广告，动画引导页面等

//FBTweak
#import <Tweaks/FBTweakShakeWindow.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -UIApplication Lifecircle

- (UIWindow*)window {
    if (!_window) {
        if (DEBUG) {
            _window = [[FBTweakShakeWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        } else {
            _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        }
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //输出路径
#if DEBUG
    NSLog(@"\n\nSimulator documents directory:\n\t%@\n\n",
          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
#endif
    //注册消息推送
    //[FLXKAppNotification registerRemoteNotification:application];
    //我们可以通过本地通知开发日志事件功能
    //[FLXKAppNotification registerLocalNotification:5];
    //取消掉所有已经注册的本地通知
    [FLXKAppNotification removeAllLocalNotification];
    
    
    //收集AppLaunchDate，AppInstallDateIfNil，logAppNumberOfDaysSinceInstall
    //初始化RootView（广告，动画引导页面等）
    FLXKLaunchViewController* vc=[FLXKLaunchViewController initialAppViewControllerFromDefaultStoryBoard];
     [vc launchAppInWindow:self.window];
    //初始化基本控件Appearance
    //
    //
    //
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods



#pragma mark - RemoteNotification CallBack

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [FLXKAppNotification application:application didReceiveLocalNotification:notification];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [FLXKAppNotification application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [FLXKAppNotification application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [FLXKAppNotification application:application didReceiveRemoteNotification:userInfo];
}

@end
