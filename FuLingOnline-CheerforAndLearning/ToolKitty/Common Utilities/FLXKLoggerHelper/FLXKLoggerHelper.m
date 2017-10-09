//
//  FLXKLoggerHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 2017/9/15.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKLoggerHelper.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <CocoaLumberjack/DDTTYLogger.h>

@implementation FLXKLoggerHelper

/*
 @abstract 主要是想，添加日志记录到本地txt功能，方便debug
 */
+ (void)addDDLogger{
    // TTY = Xcode console
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // ASL = Apple System Logs
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    // File Logger
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;//告诉应用程序要在系统上保持一周的日志文件。
    [DDLog addLogger:fileLogger];
    
    //添加数据库输出
//    DDAbstractDatabaseLogger *dbLogger = [[DDAbstractDatabaseLogger alloc] init];
//    [fileLogger setLogFormatter:formatter];
//    [DDLog addLogger:dbLogger];
    
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
//    DDLogVerbose(@"Verbose");
//    DDLogInfo(@"Info");
//    DDLogWarn(@"Warn");
//    DDLogError(@"Error");
}
@end
