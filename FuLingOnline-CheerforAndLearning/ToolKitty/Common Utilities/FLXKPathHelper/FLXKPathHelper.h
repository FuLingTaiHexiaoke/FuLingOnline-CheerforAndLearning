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

@end
