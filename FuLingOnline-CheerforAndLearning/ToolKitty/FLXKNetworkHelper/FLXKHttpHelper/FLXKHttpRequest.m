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
 static  dispatch_once_t* onceToken;
    dispatch_once(onceToken, ^{
        afHTTPSessionManager=[[AFHTTPSessionManager alloc]init];
        //1)默认为AFJSONResponseSerializer，我们再次加上AFHTTPResponseSerializer，以保证验证通过。基本够用。
        NSSet <NSString *>*  acceptableContentTypes= afHTTPSessionManager.responseSerializer.acceptableContentTypes;
        NSSet <NSString *>*  appendContentTypes=  [AFHTTPResponseSerializer serializer].acceptableContentTypes;
        afHTTPSessionManager.responseSerializer.acceptableContentTypes=[acceptableContentTypes setByAddingObjectsFromSet:appendContentTypes];
    });
    return afHTTPSessionManager;
}

//get请求
+(void)get:(NSString*)URLString success:(successBlock)success failure:(failureBlock)failure{
    [FLXKHttpRequest get:URLString parameters:nil success:success failure:failure];
}
+(void)get:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success failure:(failureBlock)failure{
    [[FLXKHttpRequest sharedAFManager] GET:URLString parameters:urlParameters progress:nil success:success failure:failure];
}
//post请求
+(void)post:(NSString*)URLString parameters:(NSDictionary*)urlParameters success:(successBlock)success success:(failureBlock)failure{
    [[FLXKHttpRequest sharedAFManager] POST:URLString parameters:urlParameters progress:nil success:success failure:failure];
}
//文件\图片上传
+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathString:(NSString*)filePathString success:(successBlock)success success:(failureBlock)failure{

}
+(void)upload:(NSString*)URLString parameters:(NSDictionary*)urlParameters filePathStringArray:(NSArray<NSString*>*)filePathStringArray success:(successBlock)success success:(failureBlock)failure{

}
//文件下载
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters savePathString:(NSString*)savePathString success:(successBlock)success success:(failureBlock)failure{

}
+(void)download:(NSString*)URLString parameters:(NSDictionary*)urlParameters saveDocument:(NSString*)saveDocument success:(successBlock)success success:(failureBlock)failure{

}
@end
