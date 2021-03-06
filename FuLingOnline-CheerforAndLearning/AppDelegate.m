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

//Diagnostics
#import <Bugly/Bugly.h>
#import "BaiduMobStat.h"

#if DEBUG
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "CacheCleanerPlugin.h"
#import "RetainCycleLoggerPlugin.h"
#import "FBStandardGraphEdgeFilters.h"
#endif

//utilities
#import "FLXKAPPRouter.h"

@interface AppDelegate ()
#if DEBUG
@property (strong, nonatomic) FBMemoryProfiler* memoryProfiler;
#endif

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
    //iOS开源项目之日志框架CocoaLumberjack
    [FLXKLoggerHelper addDDLogger];

    //系统奔溃检查（腾讯）
    //    [Bugly startWithAppId:@"900059996"];
    //系统奔溃检查（百度）
    //    [[BaiduMobStat defaultStat] startWithAppId:@"91c2c7b088"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey

    //输出路径
#if DEBUG
    NSLog(@"\n\nSimulator documents directory:\n\t%@\n\n",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
#endif
    
    //注册消息推送
    
    [FLXKAppNotification ShowRemoteNotificationWhenAppBecomeActiveWithLaunchOptions:[launchOptions copy]];
    [FLXKAppNotification registerRemoteNotification:application];
    //我们可以通过本地通知开发日志事件功能
    //[FLXKAppNotification registerLocalNotification:5];
    //取消掉所有已经注册的本地通知
    //        [[FLXKAppNotification new]  requestLocationNotification];
    //    [FLXKAppNotification removeAllLocalNotification];
    
    
    
    
    //收集AppLaunchDate，AppInstallDateIfNil，logAppNumberOfDaysSinceInstall
    //初始化RootView（广告，动画引导页面等）
    UINavigationController* navigationVC=[FLXKLaunchViewController initialAppViewControllerFromDefaultStoryBoard];
    [(FLXKLaunchViewController*)navigationVC.topViewController launchAppInWindow:self.window];
    //初始化基本控件Appearance
    //
    //
#if DEBUG
    [self setupDiagnostics];
#endif
    
    
    
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




#pragma mark - LocalNotification CallBack

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [FLXKAppNotification application:application didReceiveLocalNotification:notification];
}

#pragma mark - RemoteNotification CallBack

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [FLXKAppNotification application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [FLXKAppNotification application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [FLXKAppNotification application:application didReceiveRemoteNotification:userInfo];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    [FLXKAppNotification userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [FLXKAppNotification userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}


#pragma mark -
#pragma mark - URL scheme

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([FLXKAPPRouter openURL:url withScheme:@"FuLingOnLineScheme"]) {
        return YES;
    }else{//其他sdk代码
        return NO;
    }
    //    return [XYWdispatcher HandleOpenURL:url withScheme:@"roter"];
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//        return YES;
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
//    NSLog(@"URL scheme:%@", [url scheme]);
//    NSLog(@"URL query: %@", [url query]);
//
//    return YES;
//}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    //        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    //        NSLog(@"URL scheme:%@", [url scheme]);
    //        NSLog(@"URL query: %@", [url query]);
    
    return YES;
}

- (void)setupDiagnostics{
    //添加Facebook内存监测控件
    //    FBMemoryProfiler *memoryProfiler = [FBMemoryProfiler new];
    NSArray *filters = @[FBFilterBlockWithObjectIvarRelation([UIView class], @"_subviewCache"),FBFilterBlockWithObjectIvarRelation([UIPanGestureRecognizer class], @"_internalActiveTouches")];
    FBObjectGraphConfiguration *configuration = [[FBObjectGraphConfiguration alloc] initWithFilterBlocks:filters shouldInspectTimers:YES];
    
    FBMemoryProfiler *memoryProfiler =[[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
                                                                                  [RetainCycleLoggerPlugin new]]
                                               retainCycleDetectorConfiguration:configuration];
    [memoryProfiler enable];
    // Store memory profiler somewhere to extend it's lifetime
    _memoryProfiler = memoryProfiler;
}

///*
// @abstract 主要是想，添加日志记录到本地txt功能，方便debug
// */
//- (void)setupDDTTYLogger{
//    
//    // TTY = Xcode console
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    // ASL = Apple System Logs
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
//    
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
//    fileLogger.rollingFrequency = 60 * 60 * 24*7; // 24*7 hour rolling
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    [DDLog addLogger:fileLogger];
//    
//    //添加数据库输出
//    DDAbstractDatabaseLogger *dbLogger = [[DDAbstractDatabaseLogger alloc] init];
//    [fileLogger setLogFormatter:formatter];
//    [DDLog addLogger:dbLogger];
//    
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
//    DDLogVerbose(@"Verbose");
//    DDLogInfo(@"Info");
//    DDLogWarn(@"Warn");
//    DDLogError(@"Error");
//    
//    
//    //    DDLog *aDDLogInstance = [DDLog new];
//    //    [aDDLogInstance addLogger:[DDTTYLogger sharedInstance]];
//    
//    //    DDLogVerboseToDDLog(aDDLogInstance, @"Verbose from aDDLogInstance");
//    //    DDLogInfoToDDLog(aDDLogInstance, @"Info from aDDLogInstance");
//    //    DDLogWarnToDDLog(aDDLogInstance, @"Warn from aDDLogInstance");
//    //    DDLogErrorToDDLog(aDDLogInstance, @"Error from aDDLogInstance");
//}
/**
 系统偏好设置，根据setting.bundle配置文件注册NSUserDefaults数据。
 */
-(NSUserDefaults *)getSetting
{
    NSString* settingBundlePath=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    NSString* rootPlistPath=nil;
    if (DEBUG) {
        rootPlistPath=[settingBundlePath stringByAppendingPathComponent:@"Root.plist"];
    }
    else{
        rootPlistPath=[settingBundlePath stringByAppendingPathComponent:@"Root.plist"];
    }
    if ([[NSFileManager defaultManager]fileExistsAtPath:rootPlistPath]) {
        NSDictionary* settingDic=[NSDictionary dictionaryWithContentsOfFile:rootPlistPath];
        NSArray* settingArray=[settingDic objectForKey:@"PreferenceSpecifiers"];
        NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[settingArray count]];
        for(NSDictionary *prefSpecification in settingArray){
            NSString *key = [prefSpecification objectForKey:@"Key"];
            if(key){
                [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            }
        }
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSUserDefaults *udef =[NSUserDefaults standardUserDefaults];
    
    NSString *paduuid = [UIDevice currentDevice].identifierForVendor.UUIDString ;
    [udef setObject:paduuid forKey:@"paduuid"];
    [udef synchronize];
    
    return udef;
}

@end
