//
//  FLXKPathHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/24.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKPathHelper.h"

@interface  NSString (StandardPaths)

//检查文件类型。没有返回nil
- (NSString *)checkPathExtensionWithType:(NSString* )ext;

@end

@implementation FLXKPathHelper

+ (NSString *)DocumentDirectory
{
    static NSString *path;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //user documents folder
        path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
    });
    
    return path;
}

+(UIImage*)imageWithName:(NSString *)fileName
{
    NSString * stringPath = [FLXKPathHelper pathForResource:fileName ofType:@"png"];
    if(!stringPath){
        return [UIImage imageNamed:fileName];
    }
    else {
        return [UIImage imageWithContentsOfFile:stringPath];
    }
}

+(NSString*)imagePathWithName:(NSString *)fileName
{
    return [FLXKPathHelper pathForResource:fileName ofType:@"png"];
}

+(NSString*)pgetPDFPathWithName:(NSString *)fileName
{
       return [FLXKPathHelper pathForResource:fileName ofType:@"pdf"];
    
}

+(NSString *)audioPathWithName:(NSString*)fileName
{
  return [FLXKPathHelper pathForResource:fileName ofType:@"mp3"];
}

//获取沙盒图片文件(或文件夹)路径,如果没有则寻找Bundle，再没有返回testmv.m4v
+(NSString *)moviePathWithName:(NSString*)fileName
{
  return [FLXKPathHelper pathForResource:fileName ofType:@"mp4"];
}


+(nullable NSString *)pathForResource:(nullable NSString *)name ofType:(nullable NSString *)ext
{
    NSString* pathComponent= [name checkPathExtensionWithType:ext];
    NSParameterAssert(pathComponent);
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* rootPathOfDocument =[FLXKPathHelper DocumentDirectory];
    NSString* actualPath = [rootPathOfDocument stringByAppendingPathComponent:pathComponent];
    BOOL isExist = [fileManager fileExistsAtPath:actualPath];
    if(!isExist)
    {
        NSArray * componentArray = [pathComponent componentsSeparatedByString:@"/"];
        NSString*  bundlePath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[componentArray lastObject]];
        BOOL isFileExistWithBundlePath = [fileManager fileExistsAtPath:bundlePath];
        if(!isFileExistWithBundlePath)
        {
            NSString*   bundlePathOfDefaultFile = [[NSBundle mainBundle] pathForResource:name ofType:ext ];
            bundlePath=bundlePathOfDefaultFile;
            if(![fileManager fileExistsAtPath:bundlePath]){
                return nil;
            }
        }
        actualPath=bundlePath;
    }
    return actualPath;
    
}


//to check the path whether exist,if not create one
+(NSString*)checkOrCreatePath:(NSString*)filePath{
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    NSString* rootPathOfDocument = [FLXKPathHelper DocumentDirectory];
    NSString* checkedPath=@"";
    NSString* checkingPath=[rootPathOfDocument stringByAppendingPathComponent:filePath];
    BOOL isDirectory=NO;
    BOOL isExist = [fileManager fileExistsAtPath:checkingPath isDirectory:&isDirectory];
    //if it is a Directory
    if (isDirectory && isExist) {
        return nil;
    }
    if (!isExist) {
        // first to create the Directory
        NSArray<NSString*> *pathComponents=[filePath componentsSeparatedByString:@"/"];
        for (int i=0; i<pathComponents.count-1; i++) {
            if (i==0) {
                if ([pathComponents[0]isEqualToString: @""]) {
                    continue;
                }
                filePath = [rootPathOfDocument stringByAppendingPathComponent:pathComponents[0]];
            }
            else{
                filePath = [filePath stringByAppendingPathComponent:pathComponents[i]];
            }
            BOOL res=  [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            if (res) {
                
            }else{
                return nil;
            }
        }
        //then create file
        filePath = [filePath stringByAppendingPathComponent:[pathComponents lastObject]];
        BOOL res= [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (res) {
            checkedPath=filePath;
        }else{
            return nil;
        }
    }
    else{
        checkedPath=checkingPath;
    }
    return checkedPath;
}

//to check the directory whether exist,if not create one
+(NSString*)checkOrCreateDirectory:(NSString*)directoryPath{
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    NSString* rootPathOfDocument = [FLXKPathHelper DocumentDirectory];
    NSString* checkedDirectory=@"";
    NSString* checkingDirectory=[rootPathOfDocument stringByAppendingPathComponent:directoryPath];;
    //then check
    BOOL isDirectory=NO;
    BOOL isExist = [fileManager fileExistsAtPath:checkingDirectory isDirectory:&isDirectory];
    //if it is a Directory
    if (!isDirectory && isExist) {
        return nil;
    }
    if (!isExist) {
        // first to create the Directory
        NSArray<NSString*> *directoryComponents=[directoryPath componentsSeparatedByString:@"/"];
        for (int i=0; i<directoryComponents.count; i++) {
            if (i==0) {
                if ([directoryComponents[0]isEqualToString: @""]) {
                    continue;
                }
                checkingDirectory = [rootPathOfDocument stringByAppendingPathComponent:directoryComponents[0]];
            }
            else{
                checkingDirectory = [checkingDirectory stringByAppendingPathComponent:directoryComponents[i]];
            }
            BOOL res= [fileManager createDirectoryAtPath:checkingDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            if (res) {
                checkedDirectory=checkingDirectory;
            }else{
                return nil;
            }
        }
        
    }
    else{
        checkedDirectory=checkingDirectory;
    }
    //return the checked
    return checkedDirectory;
}

@end




@implementation NSString (StandardPaths)

//检查文件类型。没有返回nil
- (NSString *)checkPathExtensionWithType:(NSString* )ext
{
    NSString *extension = self.pathExtension;
    if (extension)
    {
        return self;
    }
    if(ext){
           return  [self stringByAppendingPathExtension:ext];
    }
    return nil;
}


@end
