//
//  FLXKAppNotification.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface FLXKAppNotification : NSObject

//注册远程服务器消息推送
+(void)registerRemoteNotification:(UIApplication *)application;

/**
 *  注册一个本地推送
 *
 *  @param alertTime 推送间隔时间
 */
+(void)registerLocalNotification:(NSInteger)alertTime;

//取消掉所有已经注册的本地通知
+(void)removeAllLocalNotification;
#pragma mark - RemoteNotification CallBack

//remote
+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

//local
+(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
@end
