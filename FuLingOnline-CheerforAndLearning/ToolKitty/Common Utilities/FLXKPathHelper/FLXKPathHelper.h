//
//  FLXKPathHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/24.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKPathHelper : NSObject

+(NSString *)DocumentDirectory;

+(UIImage *)imageWithName:(NSString *)fileName;

+(NSString *)imagePathWithName:(NSString *)fileName;

+(NSString *)pgetPDFPathWithName:(NSString *)fileName;

+(NSString *)audioPathWithName:(NSString*)fileName;

+(NSString *)moviePathWithName:(NSString*)fileName;

+(NSString *)pathForResource:( NSString *)name ofType:( NSString *)ext;

//to check the path whether exist,if not create one
+(NSString*)checkOrCreatePath:(NSString*)filePath;

//to check the directory whether exist,if not create one
+(NSString*)checkOrCreateDirectory:(NSString*)directoryPath;

@end
