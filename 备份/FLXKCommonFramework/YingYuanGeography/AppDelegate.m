//
//  AppDelegate.m
//  YingYuanGeography
//
//  Created by 肖科 on 17/7/21.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "AppDelegate.h"


//FBTweak
#import <Tweaks/FBTweakShakeWindow.h>

#if DEBUG
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "CacheCleanerPlugin.h"
#import "RetainCycleLoggerPlugin.h"
#import "FBStandardGraphEdgeFilters.h"
#endif


@interface AppDelegate ()
#if DEBUG
@property (strong, nonatomic) FBMemoryProfiler* memoryProfiler;
#endif
@end

@implementation AppDelegate

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
    
    //    UIViewController* vc=InstantiateVCWithName(@"LoginVC");
    UIViewController* vc=InstantiateVCWithName(@"ViewController");
    self.window.rootViewController=vc;
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
#if DEBUG
//    [self setupDiagnostics];
#endif
    [self  getSetting];
    
    [self  setupComponentsConfig];
    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#if DEBUG
- (void)setupDiagnostics{
    //添加Facebook内存监测控件
    NSArray *filters = @[FBFilterBlockWithObjectIvarRelation([UIView class], @"_subviewCache"),FBFilterBlockWithObjectIvarRelation([UIPanGestureRecognizer class], @"_internalActiveTouches")];
    FBObjectGraphConfiguration *configuration = [[FBObjectGraphConfiguration alloc] initWithFilterBlocks:filters shouldInspectTimers:YES];
    
    FBMemoryProfiler *memoryProfiler =[[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
                                                                                  [RetainCycleLoggerPlugin new]]
                                               retainCycleDetectorConfiguration:configuration];
    [memoryProfiler enable];
    // Store memory profiler somewhere to extend it's lifetime
    _memoryProfiler = memoryProfiler;
    
    //
    //    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    //    //            [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    //
    //    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    //    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    //    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    //    [DDLog addLogger:fileLogger];
    //
    //    DDLogVerbose(@"Verbose");
    //    DDLogInfo(@"Info");
    //    DDLogWarn(@"Warn");
    //    DDLogError(@"Error");
    //
    //    //    DDLog *aDDLogInstance = [DDLog new];
    //    //    [aDDLogInstance addLogger:[DDTTYLogger sharedInstance]];
    //
    //    //    DDLogVerboseToDDLog(aDDLogInstance, @"Verbose from aDDLogInstance");
    //    //    DDLogInfoToDDLog(aDDLogInstance, @"Info from aDDLogInstance");
    //    //    DDLogWarnToDDLog(aDDLogInstance, @"Warn from aDDLogInstance");
    //    //    DDLogErrorToDDLog(aDDLogInstance, @"Error from aDDLogInstance");
}
#endif

/**
 初始化系统中组件基本配置参数
 */
- (void)setupComponentsConfig{
    //SVProgressHUD
    //    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}

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
    NSString *name = [UIDevice currentDevice].name ;
    [udef setObject:paduuid forKey:@"iPad_uuid"];
    [udef setObject:name forKey:@"iPad_Name"];
    [udef synchronize];
    
    return udef;
}
@end
