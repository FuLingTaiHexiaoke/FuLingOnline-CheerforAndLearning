//
//  FLXKHttpRequest.m
//  PSYLife-NewStructure
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//



#import "FLXKHttpRequest.h"

@implementation FLXKHttpRequest
///单例话AFHTTPSessionManager，其基类AFURLSessionManager会用数组帮我们保存每一个请求。关键的地方就在于返回类型的AFHTTPResponseSerializer的验证。虽然都可以返回json，但type不正确就报错。
+(AFHTTPSessionManager*)sharedAFManager{
    static  AFHTTPSessionManager* afHTTPSessionManager;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        afHTTPSessionManager=[[AFHTTPSessionManager alloc]init];
        //1)默认为AFJSONResponseSerializer，我们再次加上AFHTTPResponseSerializer，以保证验证通过。基本够用。
        NSSet <NSString *>*  acceptableContentTypes= afHTTPSessionManager.responseSerializer.acceptableContentTypes;
        NSSet <NSString *>*  appendContentTypes=  [AFHTTPResponseSerializer serializer].acceptableContentTypes;
        afHTTPSessionManager.responseSerializer.acceptableContentTypes=[acceptableContentTypes setByAddingObjectsFromSet:appendContentTypes];
    });
    return afHTTPSessionManager;
}

//检查网络
+(void)detectNetwork{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
}

//判断是否有网,
//不封装在下面的方法里。增大程序的灵活性。
+(BOOL)isReachable{
  return  [AFNetworkReachabilityManager sharedManager].isReachable;
}

//get请求
+(void)get:(NSString*)URLString success:(successBlock)success failure:(failureBlock)failure{
    [FLXKHttpRequest get:URLString parameters:nil success:success failure:failure];
}
+(void)get:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success failure:(failureBlock)failure{
    [[FLXKHttpRequest sharedAFManager] GET:URLString parameters:urlParameters progress:nil success:success failure:failure];
}


//post请求
+(void)post:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success failure:(failureBlock)failure{
    [[FLXKHttpRequest sharedAFManager] POST:URLString parameters:urlParameters progress:nil success:success failure:failure];
}
//文件\图片上传
+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathString:(NSString*)filePathString success:(successBlock)success failure:(failureBlock)failure{
    NSArray<NSString *> * filePathStringArray=[NSArray arrayWithObject:filePathString];
    
    [FLXKHttpRequest upload:URLString parameters:urlParameters filePathStringArray:filePathStringArray progress:nil success:success  failure:failure];
}

+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathStringArray:(NSArray<NSString*>*)filePathStringArray progress:(taskProgress)taskProgress success:(successBlock)success failure:(failureBlock)failure{
    [[FLXKHttpRequest sharedAFManager] POST:URLString parameters:urlParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [filePathStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL  *fileURL=[NSURL fileURLWithPath:obj];
            NSString* name = [fileURL.lastPathComponent stringByDeletingPathExtension];
            //AF会帮我们验证文件是否存在，可获取,并配置相关参数，所以直接调用。
            NSError* error=nil;
            [formData appendPartWithFileURL:fileURL name:name error:&error];
            if (error) {
                failure(nil,error);
                return ;
            }
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        taskProgress(uploadProgress);
    } success:success
                                    failure:failure];
}

//文件下载
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters progress:(taskProgress)taskProgress savePathString:(NSString*)savePathString success:(successBlock)success failure:(failureBlock)failure{
    //make the NSURLRequest
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [[FLXKHttpRequest sharedAFManager].requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:[FLXKHttpRequest sharedAFManager].baseURL] absoluteString] parameters:urlParameters constructingBodyWithBlock:nil error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async([FLXKHttpRequest sharedAFManager].completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return;
    }
    //start the request
    NSURLSessionDownloadTask * task=[[FLXKHttpRequest sharedAFManager] downloadTaskWithRequest:request progress:taskProgress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savePathString];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(nil, error);
            }
        } else {
            if (success) {
                //应该返回路径，但前面已经存在。故公用successBlock
                success(nil, response);
            }
        }
    }];
    [task resume];
}

//暂时用不到此方法
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters saveDocument:(NSString*)saveDocument success:(successBlock)success failure:(failureBlock)failure{
    
}
@end
