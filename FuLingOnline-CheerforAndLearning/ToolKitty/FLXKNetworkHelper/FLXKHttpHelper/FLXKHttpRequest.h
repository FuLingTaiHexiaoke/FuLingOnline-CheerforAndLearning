//
//  PsyHttpRequest.h
//  PSYLife-NewStructure
//
//  Created by xiaoke on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 *为了实现自主便捷的网络访问，不采用继承于AFHTTPSessionManager。尽管官方建议。
 *在应用实践中发现我们请求网络时越简单越好。
 *如有特殊需求再另外生成。
 *
 *
 */
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^successBlock)(NSURLSessionDataTask *task, id  responseObject);
typedef void (^failureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^taskProgress)(NSProgress *);
@interface FLXKHttpRequest : NSObject

//检查网络
+(void)detectNetwork;

//判断是否有网,
//不封装在下面的方法里。增大程序的灵活性。
+(BOOL)isReachable;

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

//暂时用不到此方法
//+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters saveDocument:(NSString*)saveDocument success:(successBlock)success success:(failureBlock)failure;
@end


