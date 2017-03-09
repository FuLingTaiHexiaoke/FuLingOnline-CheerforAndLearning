//
//  FLXKAppNotification.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKAppNotification.h"
#import "UISGAlertView.h"
#import "AudioServices+Extensions.h"
//#import <UserNotifications/UserNotifications.h>

//注意，关于 iOS10 系统版本的判断，可以用下面这个宏来判断。不能再用截取字符的方法。


#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

@implementation FLXKAppNotification

//取消掉所有已经注册的本地通知
+(void)removeAllLocalNotification{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}
#pragma mark -#import <UserNotifications/UserNotifications.h>
#pragma mark - RemoteNotification

//注册远程服务器消息推送
+(void)registerRemoteNotification:(UIApplication *)application{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        center.delegate = appDelegate;
        //[center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                [application registerForRemoteNotifications];
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    }else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        //iOS8 - iOS10
        // [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
        
    }else if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        //iOS8系统以下
        //[application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
}


+(void)ShowRemoteNotificationWhenAppBecomeActiveWithLaunchOptions:(NSDictionary*)launchOptions{
    if (launchOptions) {
        UserDefaultsSetObjForKey(launchOptions,@"UIApplicationLaunchOptionsRemoteNotificationKey1");
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //判断是否由远程消息通知触发应用程序启动
    if (launchOptions && [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil && SYSTEM_VERSION_LESS_THAN(@"10.0")) {
        id pushInfo_temp = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushInfo_temp && [NSJSONSerialization isValidJSONObject:pushInfo_temp])
        {
            NSDictionary* pushInfo= [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
            UserDefaultsSetObjForKey(pushInfo,@"UIApplicationLaunchOptionsRemoteNotificationKey");
            NSDictionary *apsInfo = [pushInfo objectForKey:@"aps"];
            if(apsInfo)
            {
                id message_json = [apsInfo objectForKey:@"message_json"];
                if (!message_json) {
                    message_json=[pushInfo objectForKey:@"message_json"];
                }
                if (![NSJSONSerialization isValidJSONObject:message_json]) {
                    NSMutableString *message_json_string =message_json;
                    message_json = [NSJSONSerialization JSONObjectWithData:[message_json_string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                }
                
                id title_dic = [apsInfo objectForKey:@"alert"];// 推送消息的标题
                NSString *title =@"";
                if ([title_dic isKindOfClass:NSClassFromString(@"NSDictionary") ] ) {
                    title = [title_dic objectForKey:@"title"];
                }
                else{
                    title =title_dic;
                }
                
                NSString *content =@"";  //  收到推送的消息内容
                if ([message_json isKindOfClass:NSClassFromString(@"NSDictionary") ] ) {
                    NSDictionary * content_dic=  (NSDictionary *)[message_json objectForKey:@"content"];
                    if ([content_dic isKindOfClass:   NSClassFromString(@"NSDictionary") ] ) {
                        content = [content_dic objectForKey:@"message_content"];  //  收到推送的消息内容
                    }
                    else{
                        content = [message_json objectForKey:@"content"];  //  收到推送的消息内容
                    }
                }
                //        UISGAlertView *alert = [UISGAlertView alertViewWithTitle:title delegate:nil contentTitle:content alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
                //        [alert show];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                        [AudioServices playSystemSoundID:1002];
                    }
                    [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                    //                    if ([FLXKAppNotification getCurrentVC]) {
                    //                        [FLXKAppNotification  showAlertWithTitle:title message:content cancelButtonTitle:@"确定" withPresentingController:[FLXKAppNotification getCurrentVC]];
                    //                    }
                    //                    else{
                    //                        [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                    //
                    //                    }
                });
            }
        }
    }
    
}



#pragma mark - UNUserNotificationCenterDelegate


+(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo =notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
    }
    else {
        
    }
    // completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}


+(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
        id message_json = [apsInfo objectForKey:@"message_json"];
        if (![NSJSONSerialization isValidJSONObject:message_json]) {
            NSMutableString *message_json_string = [userInfo objectForKey:@"message_json"];
            message_json = [NSJSONSerialization JSONObjectWithData:[message_json_string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        }
        
        id title_dic = [apsInfo objectForKey:@"alert"];// 推送消息的标题
        NSString *title =@"";
        if ([title_dic isKindOfClass:   NSClassFromString(@"NSDictionary") ] ) {
            title = [title_dic objectForKey:@"title"];
        }
        else{
            title =title_dic;
        }
        
        NSDictionary * content_dic=  (NSDictionary *)[message_json objectForKey:@"content"];
        NSString *content =@"";  //  收到推送的消息内容
        if ([content_dic isKindOfClass:   NSClassFromString(@"NSDictionary") ] ) {
            content = [content_dic objectForKey:@"message_content"];  //  收到推送的消息内容
        }
        else{
            content = [message_json objectForKey:@"content"];  //  收到推送的消息内容
        }
        [AudioServices playSystemSoundID:1002];
        [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        //                    [FLXKAppNotification  showAlertWithTitle:title message:content cancelButtonTitle:@"确定" withPresentingController:[FLXKAppNotification getCurrentVC]];
        
        //        if ([FLXKAppNotification getCurrentVC]) {
        //            [FLXKAppNotification  showAlertWithTitle:title message:content cancelButtonTitle:@"确定" withPresentingController:[FLXKAppNotification getCurrentVC]];
        //        }
        //        else{
        //            [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        //        }
        //        UISGAlertView *alert = [UISGAlertView alertViewWithTitle:title delegate:nil contentTitle:content alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        //        [alert show];
    }
    else {
    }
    
    completionHandler();  // 系统要求执行这个方法
}


#pragma mark - RemoteNotification CallBack

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSString *dt = [token stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *dn = [dt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    dn=[dn stringByReplacingOccurrencesOfString:@" " withString:@""];
    UserDefaultsSetObjForKey(dn,apns_deviceToken);
    NSLog(@"获取令牌:  %@",dn);
    //    5ab38850ededae838e770e0fd004b9241566982e903d93bba00fa2130d550823
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"获取令牌失败:  %@",str);
    //如果device token获取失败则需要重新获取一次
    [FLXKAppNotification registerRemoteNotification:[UIApplication sharedApplication]];
}


//{
//    aps =     {
//        alert = "\U63d0\U793a\U6807\U9898";
//        badge = 1;
//        sound = default;
//    };
//    "message_json" = "{\"content\":\"\U5185\U7a7a\",\"up\":\"\U79c1\U6709\U5185\U5bb91\"}";
//}

//{"title":"有新的服务需求被发布","content":{"message_content":"#测推送#【测推送】测推送","lvcontent_id":10010},"up":""}

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    if (application.applicationState == UIApplicationStateActive) {
        [AudioServices playSystemSoundID:1002];
    }
    if(apsInfo)
    {
        id message_json = [apsInfo objectForKey:@"message_json"];
        if (![NSJSONSerialization isValidJSONObject:message_json]) {
            NSMutableString *message_json_string = [userInfo objectForKey:@"message_json"];
            message_json = [NSJSONSerialization JSONObjectWithData:[message_json_string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        }
        
        id title_dic = [apsInfo objectForKey:@"alert"];// 推送消息的标题
        NSString *title =@"";
        if ([title_dic isKindOfClass:   NSClassFromString(@"NSDictionary") ] ) {
            title = [title_dic objectForKey:@"title"];
        }
        else{
            title =title_dic;
        }
        
        NSDictionary * content_dic=  (NSDictionary *)[message_json objectForKey:@"content"];
        NSString *content =@"";  //  收到推送的消息内容
        
        if ([content_dic isKindOfClass:   NSClassFromString(@"NSDictionary") ] ) {
            content = [content_dic objectForKey:@"message_content"];  //  收到推送的消息内容
        }
        else{
            content = [message_json objectForKey:@"content"];  //  收到推送的消息内容
        }
        [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        //                UISGAlertView *alert = [UISGAlertView alertViewWithTitle:title delegate:nil contentTitle:content alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        //                [alert show];
        //                    [FLXKAppNotification  showAlertWithTitle:title message:content cancelButtonTitle:@"确定" withPresentingController:[FLXKAppNotification getCurrentVC]];
        
        //        if ([FLXKAppNotification getCurrentVC]) {
        //            [FLXKAppNotification  showAlertWithTitle:title message:content cancelButtonTitle:@"确定" withPresentingController:[FLXKAppNotification getCurrentVC]];
        //        }
        //        else{
        //            [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        //
        //        }
    }
}



#pragma mark -
#pragma mark - LocalNotification

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

#pragma mark - LocalNotification CallBack

+(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"notification:%@",notification);
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertController* alertController=[UIAlertController alertControllerWithTitle:@"正在查看本地通知" message:notMess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*  alertAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",notMess);
    }];
    [alertController addAction:alertAction];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
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
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (void)showAlertWithTitle:(NSString *)title  message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle withPresentingController:(UIViewController*)presentingController {
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
        [presentingController presentViewController:alertController animated:YES completion:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil] show];
#pragma clang diagnostic pop
    }
}

@end



