//
//  PsyHttpRequest.h
//  PSYLife-NewStructure
//
//  Created by xiaoke on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^successBlock)(NSURLSessionDataTask *task, id  responseObject);
typedef void (^failureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface FLXKHttpRequest : NSObject

//get请求
+(void)get:(NSString*)URLString success:(successBlock)success success:(failureBlock)failure;
+(void)get:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success success:(failureBlock)failure;
//post请求
+(void)post:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success success:(failureBlock)failure;
//文件\图片上传
+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathString:(NSString*)filePathString success:(successBlock)success success:(failureBlock)failure;
+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathStringArray:(NSArray<NSString*>*)filePathStringArray success:(successBlock)success success:(failureBlock)failure;
//文件下载
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters savePathString:(NSString*)savePathString success:(successBlock)success success:(failureBlock)failure;
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters saveDocument:(NSString*)saveDocument success:(successBlock)success success:(failureBlock)failure;
@end


