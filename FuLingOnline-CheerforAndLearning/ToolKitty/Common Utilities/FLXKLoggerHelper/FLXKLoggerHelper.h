//
//  FLXKLoggerHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 2017/9/15.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDTTYLogger.h>

// Log levels: off, error, warn, info, verbose
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif
//#define NSLogError(frmt, ...)    do{ if(DD_NSLOG_LEVEL >= 1) NSLog((frmt), ##__VA_ARGS__); } while(0)
//#define NSLogWarn(frmt, ...)     do{ if(DD_NSLOG_LEVEL >= 2) NSLog((frmt), ##__VA_ARGS__); } while(0)
//#define NSLogInfo(frmt, ...)     do{ if(DD_NSLOG_LEVEL >= 3) NSLog((frmt), ##__VA_ARGS__); } while(0)
//#define NSLogDebug(frmt, ...)    do{ if(DD_NSLOG_LEVEL >= 4) NSLog((frmt), ##__VA_ARGS__); } while(0)
//#define NSLogVerbose(frmt, ...)
#if DEBUG
#define NSLog(FORMAT, ...) DDLogVerbose(FORMAT, ##__VA_ARGS__);
#define NSLogError(FORMAT, ...) DDLogError(FORMAT, ##__VA_ARGS__);
#else
#define NSLog(FORMAT, ...) nil;
#define NSLogError(FORMAT, ...)  DDLogError(FORMAT, ##__VA_ARGS__);
#endif

@interface FLXKLoggerHelper : NSObject
/*
 @abstract 主要是想，添加日志记录到本地txt功能，方便debug
 */
+ (void)addDDLogger;
@end

////    DDLogVerbose(@"Verbose");
////    DDLogInfo(@"Info");
////    DDLogWarn(@"Warn");
////    DDLogError(@"Error");
