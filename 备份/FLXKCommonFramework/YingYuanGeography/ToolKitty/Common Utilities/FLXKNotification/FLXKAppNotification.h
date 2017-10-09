//
//  FLXKAppNotification.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
@interface FLXKAppNotification : NSObject

//注册远程服务器消息推送
+(void)registerRemoteNotification:(UIApplication *)application;

//注册一个本地推送
+(void)registerLocalNotification:(NSInteger)alertTime;

//取消掉所有已经注册的本地通知
+(void)removeAllLocalNotification;

+(void)ShowRemoteNotificationWhenAppBecomeActiveWithLaunchOptions:(NSDictionary*)launchOptions;

#pragma mark - UNUserNotificationCenterDelegate

+(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;
+(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;

#pragma mark - RemoteNotification CallBack

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

#pragma mark - LocalNotification CallBack

+(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;


#pragma mark - Notification TEST AND WRAP

- (void)requestLocationNotification;
@end
