//
//  FLXKAppNotification.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKAppNotification.h"


@implementation FLXKAppNotification

//取消掉所有已经注册的本地通知
+(void)removeAllLocalNotification{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}

//注册远程服务器消息推送
+(void)registerRemoteNotification:(UIApplication *)application{
    //http://blog.csdn.net/zhuming3834/article/details/49001809 细致
    //http://blog.csdn.net/apple_app/article/details/39228221  全面
    //http://blog.csdn.net/yujianxiang666/article/details/35260135 细致
    //注册消息推送
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        // for iOS 8
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    //不再考虑  iOS 7 or iOS 6
    //    else {
    //        // for iOS 7 or iOS 6
    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    //    }
}


/**
 *  注册一个本地推送
 *
 *  @param alertTime 推送间隔时间
 */
+(void)registerLocalNotification:(NSInteger)alertTime {
    //http://blog.csdn.net/wzq9706/article/details/39002491 包含对重复时间的和注意点的解释
    NSLog(@"发送通知");
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    notification.fireDate = fireDate;
    // 时区  时区跟随时区变化
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitMinute;
    // 通知内容
    notification.alertBody   = @"Wake up, man";
    notification.alertAction = NSLocalizedString(@"起床了", nil);
    // 设置icon右上角的显示数
    notification.applicationIconBadgeNumber ++;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"iOS本地推送Demo" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知多长时间重复提示
        notification.repeatInterval = kCFCalendarUnitMinute;
    }
    else {
        // 通知多长时间重复提示
        notification.repeatInterval = kCFCalendarUnitMinute;
    }
    // 执行注册的通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - RemoteNotification CallBack

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSString *dt = [token stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *dn = [dt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"获取令牌:  %@",dn);
    //    TheRuntime.pushToken= [dn stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"获取令牌失败:  %@",error_str);
}

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}

+(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"notification:%@",notification);
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertController* alertController=[UIAlertController alertControllerWithTitle:@"正在查看本地通知" message:notMess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*  alertAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",notMess);
    }];
    [alertController addAction:alertAction];
    
    //    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    //    UIAlertController *alert = [[UIAlertView alloc] initWithTitle:@"正在查看本地通知"
    //                                                    message:notMess
    //                                                   delegate:nil
    //                                          cancelButtonTitle:@"确定"
    //                                          otherButtonTitles:nil];
    //    [alert show];
    // 更新applicationIconBadgeNumber
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}

@end
