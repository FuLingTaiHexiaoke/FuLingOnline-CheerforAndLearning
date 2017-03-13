//
//  PsyDBHelper.m
//  PSYLife-NewStructure
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <objc/runtime.h>
#import "FLXKEmotionDBHelper.h"
//#import "PsyBaseModelForPersistence.h"

@interface FLXKEmotionDBHelper ()

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

@end
@implementation FLXKEmotionDBHelper

static FLXKEmotionDBHelper *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init];
    }) ;
    return _instance;
}

+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName
{
    
    
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (directoryName == nil || directoryName.length == 0) {
        docsdir = [docsdir stringByAppendingPathComponent:@"FLXKEmotionDB"];
    } else {
        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
    }
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"FLXKEmotionDB.sqlite"];
//    NSLog(@"FLXKEmotionDB Directory:\n%@",dbpath);
    
    //check if already sqlite exist
        BOOL dbExit =[filemanage fileExistsAtPath:dbpath];
    if (DEBUG) {
        if (dbExit) {
            [filemanage removeItemAtPath:dbpath error:nil];
            NSString* bundleDBPath=[[NSBundle mainBundle]pathForResource:@"FLXKEmotionDB" ofType:@"sqlite"];
            [filemanage copyItemAtPath:bundleDBPath toPath:dbpath error:nil];
        }
    }
    else{
        if (!dbExit) {
            NSString* bundleDBPath=[[NSBundle mainBundle]pathForResource:@"FLXKEmotionDB" ofType:@"sqlite"];
            [filemanage copyItemAtPath:bundleDBPath toPath:dbpath error:nil];
        }
    }
    return dbpath;
}

+ (NSString *)dbPathInBundleWithDirectoryName:(NSString *)directoryName
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString*  bundlePath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directoryName];
    BOOL isFileExistWithBundlePath = [fileManager fileExistsAtPath:bundlePath];
    if(!isFileExistWithBundlePath)
    {
        return nil;
    }
    return bundlePath;
}

+ (NSString *)dbPath
{
        return [self dbPathWithDirectoryName:nil];
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}

//- (BOOL)changeDBWithDirectoryName:(NSString *)directoryName
//{
//    if (_instance.dbQueue) {
//        _instance.dbQueue = nil;
//    }
//    _instance.dbQueue = [[FMDatabaseQueue alloc] initWithPath:[PsyDBHelper dbPathWithDirectoryName:directoryName]];
//
//    int numClasses;
//    Class *classes = NULL;
//    numClasses = objc_getClassList(NULL,0);
//
//    if (numClasses >0 )
//    {
//        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
//        numClasses = objc_getClassList(classes, numClasses);
//        for (int i = 0; i < numClasses; i++) {
//            if (class_getSuperclass(classes[i]) == [PsyBaseModelForPersistence class]){
//                id class = classes[i];
//                [class performSelector:@selector(createTable) withObject:nil];
//            }
//        }
//        free(classes);
//    }
//
//    return YES;
//}


@end
