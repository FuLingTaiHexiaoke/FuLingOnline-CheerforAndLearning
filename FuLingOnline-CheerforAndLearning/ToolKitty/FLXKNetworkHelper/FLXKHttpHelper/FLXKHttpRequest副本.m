////
////  FLXKHttpRequest.m
////  PSYLife-NewStructure
////
////  Created by apple on 16/5/27.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//
//
//#import "FLXKHttpRequest.h"
//#import "AFNetworkActivityIndicatorManager.h"
//
////====================== * 网络请求模块 * ======================
////#define BASEURL @"http://c.3g.163.com/nc/article"
//#define BASEURL @""
//
//static PsyNetworkStatus networkStatus=PsyNetworkStatusUnknown;
//@implementation FLXKHttpRequest
//
//#pragma mark - init
//- (id)init{
//    self = [super init];
//    if (self){
//        self.baseUrl=BASEURL;
//        self.shouldAutoEncode=YES;
//        //        self.shouldAutoEncode=NO;
//        self.httpHeaders=nil;
//        self.responseType=PsyResponseTypeJSON;
//        self.requestType=PsyRequestTypePlainText;
//        //self.networkStatus=PsyNetworkStatusUnknown;
//        self.requestTasks=nil;
//        self.timeout=600.f;
//        self.shouldGetCachedData=NO;//是否获取已经缓存的数据
//        self.shouldCacheData=NO;//是否缓存的获得的数据
//    }
//    else{
//        self=nil;
//    }
//    return self;
//}
//
//#pragma mark - static methods
///** 静态方法说明
// *1.serialise默认设定responseSerialise为AFJSONResponseSerializer，requestSerialise为AFHttpRequestSerializer.如果需要特别指定，请使用FLXKHttpRequest实体方法。
// *2.params暂定为NSDictionary。有待深入理解和运用。
// *3.PsySuccessJsonResponseBlock直接以json格式的数据返回。见PsySuccessJsonResponseBlock得定义。
// *4.Url为简单方便。在此省略去baseUrl，shouldAutoEncode的判断和配置。请自行处理。（可以建立一个model中间层）。
// */
//
//+ (NSURLSessionTask *)getWithUrl:(NSString *)url
//                          params:(NSDictionary *)params
//                        progress:(PsyGetProgress)progress
//                         success:(PsySuccessJsonResponseBlock)success
//                            failure:(PsyFailedResponseBlock)failure{
//    //开始数据请求
//    NSURLSessionTask *dataTask = nil;
//    if(networkStatus != PsyNetworkStatusNotReachable &&  networkStatus != PsyNetworkStatusUnknown ){
//        AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
//        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        dataTask = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//                if (progress) {
//                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
//                }
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//                [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//
//            }];
//        }
//    //for having resumed the task in manager
//    return nil;
//}
//
//+ (NSURLSessionTask *)postWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                         progress:(PsyPostProgress)progress
//                          success:(PsySuccessJsonResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure{
//    //开始数据请求
//    NSURLSessionTask *dataTask = nil;
//    if(networkStatus != PsyNetworkStatusNotReachable &&  networkStatus != PsyNetworkStatusUnknown ){
//        AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
//        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//            if (progress) {
//                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
//            }
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//            [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//
//        }];
//    }
//    //for having resumed the task in manager
//    return nil;
//}
//
//+ (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
//                      uploadingFilePath:(NSString *)uploadingFilePath
//                               progress:(PsyUploadProgress)progress
//                                success:(PsySuccessJsonResponseBlock)success
//                                   failure:(PsyFailedResponseBlock)failure{
//    FLXKHttpRequest* fLXKHttpRequest=[[FLXKHttpRequest alloc] init];
//    [fLXKHttpRequest uploadFileWithUrl:url uploadingFilePath:uploadingFilePath progress:progress success:success failure:failure];
//    //for having resumed the task in manager
//    return nil;
//}
//
//+ (NSURLSessionTask *)uploadWithImage:(UIImage *)image
//                                  url:(NSString *)url
//                             filename:(NSString *)filename
//                                 name:(NSString *)name
//                             mimeType:(PsyImageMimeType)imageMimeType
//                           parameters:(NSDictionary *)parameters
//                             progress:(PsyUploadProgress)progress
//                              success:(PsySuccessResponseBlock)success
//                                 failure:(PsyFailedResponseBlock)failure{
//    FLXKHttpRequest* fLXKHttpRequest=[[FLXKHttpRequest alloc] init];
//    [fLXKHttpRequest uploadWithImage:image url:url filename:filename name:name mimeType:PNG parameters:parameters progress:progress success:success failure:failure];
//    //for having resumed the task in manager
//    return nil;
//
//}
//
//+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
//                           saveToPath:(NSString *)saveToPath
//                             progress:(PsyDownloadProgress)progressBlock
//                              success:(PsySuccessJsonResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure{
//    FLXKHttpRequest* fLXKHttpRequest=[[FLXKHttpRequest alloc] init];
//    [fLXKHttpRequest downloadWithUrl:url saveToPath:saveToPath progress:progressBlock success:success failure:failure];
//    //for having resumed the task in manager
//    return nil;
//}
//
//#pragma mark - entity methods
//
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                          success:(PsySuccessResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure{
//    return [self getWithUrl:url
//                     params:nil
//                    success:success
//                       failure:failure];
//}
//
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                          success:(PsySuccessResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure{
//    return [self getWithUrl:url
//                     params:params
//                   progress:nil
//                    success:success
//                       failure:failure];
//}
//
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                         progress:(PsyGetProgress)progress
//                          success:(PsySuccessResponseBlock)success
//                         failure:(PsyFailedResponseBlock)failure{
//    
//    return [self _requestWithUrl:url
//                    refreshCache:nil
//                       httpMedth:PsyRequestMethodGet
//                          params:params
//                        progress:progress
//                         success:success
//                            failure:failure];
//}
//
//- (NSURLSessionTask *)postWithUrl:(NSString *)url
//                            params:(NSDictionary *)params
//                           success:(PsySuccessResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure{
//    return [self postWithUrl:url
//                      params:params
//                    progress:nil
//                     success:success
//                        failure:failure];
//}
//
//- (NSURLSessionTask *)postWithUrl:(NSString *)url
//                            params:(NSDictionary *)params
//                          progress:(PsyPostProgress)progress
//                           success:(PsySuccessResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure{
//    return [self _requestWithUrl:url
//                    refreshCache:nil
//                       httpMedth:PsyRequestMethodPost
//                          params:params
//                        progress:progress
//                         success:success
//                            failure:failure];
//}
//
//
//
//
//
//- (NSURLSessionTask *)_requestWithUrl:(NSString *)url
//                          refreshCache:(BOOL)refreshCache
//                             httpMedth:(NSUInteger)httpMethod
//                                params:(NSDictionary *)params
//                              progress:(PsyDownloadProgress)progress
//                               success:(PsySuccessResponseBlock)success
//                                  failure:(PsyFailedResponseBlock)failure{
//    AFHTTPSessionManager *manager = [self getAFHTTPSessionManager];
//    NSString *actualURLString = [self getActualUrlWithSubURLString:url];
//    //编码url
//    if ([self shouldAutoEncode]) {
//        actualURLString = [self encodeURLString:actualURLString];
//    }
//    //检验actualURLString是否真是NSURL
//    NSURL *trueURL = [NSURL URLWithString:actualURLString];
//    if (trueURL == nil) {
//        NSLog(@"url:%@无效，无法生成URL。可能是URL中有中文，请检查URL的正确性",actualURLString);
//        
//        NSError *error = [NSError errorWithDomain:@"NSURLChecking" code:10000 userInfo:@{@"url无效，无法生成URL。请检查URL的正确性。":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    //是否获取缓存的数据
//    if (self.shouldGetCachedData) {
//        id responseData = [FLXKHttpRequest getCahcedResponseWithURL:actualURLString
//                                                        parameters:params];
//        if (responseData) {
//            if (success) {
//                [FLXKHttpRequest sendSuccessResponseData:(id)responseData withCallbackBlock:success];
//            }
//            return nil;
//        }
//    }
//    //开始数据请求
//    NSURLSessionTask *dataTask = nil;
//    if(networkStatus != PsyNetworkStatusNotReachable &&  networkStatus != PsyNetworkStatusUnknown ){
//        
//        if (httpMethod == PsyRequestMethodGet) {
//            
//            dataTask = [manager GET:actualURLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//                if (progress) {
//                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
//                }
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//                
//                if (self.shouldCacheData) {
//                    [FLXKHttpRequest cacheResponseObject:responseObject request:task.currentRequest parameters:params];
//                }
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//                [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//                
//            }];
//        }
//        
//        else if (httpMethod == PsyRequestMethodPost) {
//            
//            dataTask = [manager POST:actualURLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//                if (progress) {
//                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
//                }
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//                
//                if (self.shouldCacheData) {
//                    [FLXKHttpRequest cacheResponseObject:responseObject request:task.currentRequest parameters:params];
//                }
//                
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//                [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//            }];
//        }
//    }
//    return dataTask;
//}
//
//
//- (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
//                       uploadingFilePath:(NSString *)uploadingFilePath
//                                progress:(PsyUploadProgress)progress
//                                 success:(PsySuccessResponseBlock)success
//                                    failure:(PsyFailedResponseBlock)failure{
//    
//    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:uploadingFilePath]) {
//        NSLog(@"uploadingFilePath无效。请检查待上传文件是否存在");
//        NSError *error = [NSError errorWithDomain:@"uploadFileWithUrl" code:10000 userInfo:@{@"uploadingFilePath无效。请检查待上传文件是否存在":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    NSString *actualURLString = [self getActualUrlWithSubURLString:url];
//    //编码url
//    if ([self shouldAutoEncode]) {
//        actualURLString = [self encodeURLString:actualURLString];
//    }
//    //检验actualURLString是否真是NSURL
//    NSURL *trueURL = [NSURL URLWithString:actualURLString];
//    if (trueURL == nil) {
//        NSLog(@"url:%@无效，无法生成URL。可能是URL中有中文，请检查URL的正确性",actualURLString);
//        
//        NSError *error = [NSError errorWithDomain:@"NSURLChecking" code:10000 userInfo:@{@"url无效，无法生成URL。请检查URL的正确性。":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    
//    AFHTTPSessionManager *manager = [self getAFHTTPSessionManager];
//    NSURLRequest *request = [NSURLRequest requestWithURL:trueURL];
//    NSURLSessionTask *dataTask = nil;
//    dataTask= [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFilePath] progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (progress) {
//            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//        }
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//        
//        if (error) {
//            [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//            
//        }}];
//    
//    return dataTask;
//}
//
//- (NSURLSessionTask *)uploadWithImage:(UIImage *)image
//                                   url:(NSString *)url
//                              filename:(nullable NSString *)filename
//                                  name:(nullable NSString *)name
//                              mimeType:(PsyImageMimeType)imageMimeType
//                            parameters:(NSDictionary *)parameters
//                              progress:(PsyUploadProgress)progress
//                               success:(PsySuccessResponseBlock)success
//                                  failure:(PsyFailedResponseBlock)failure{
//    if (!image) {
//        NSLog(@"image无效。请检查待上传图片是否存在");
//        NSError *error = [NSError errorWithDomain:@"uploadImageWithUrl" code:10000 userInfo:@{@"uploadImageWithUrl无效。请检查待上传图片是否存在":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    NSString *actualURLString = [self getActualUrlWithSubURLString:url];
//    //编码url
//    if ([self shouldAutoEncode]) {
//        actualURLString = [self encodeURLString:actualURLString];
//    }
//    //检验actualURLString是否真是NSURL
//    NSURL *trueURL = [NSURL URLWithString:actualURLString];
//    if (trueURL == nil) {
//        NSLog(@"url:%@无效，无法生成URL。可能是URL中有中文，请检查URL的正确性",actualURLString);
//        
//        NSError *error = [NSError errorWithDomain:@"NSURLChecking" code:10000 userInfo:@{@"url无效，无法生成URL。请检查URL的正确性。":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    
//    AFHTTPSessionManager *manager = [self getAFHTTPSessionManager];
//    NSURLSessionTask *dataTask = [manager POST:actualURLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        
//        NSString *imageFileName = filename;
//        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *str = [formatter stringFromDate:[NSDate date]];
//            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
//        }
//        NSString *mimeType =@"";
//        switch (imageMimeType) {
//            case PNG:
//                mimeType=@"image/png";
//                break;
//            case JPEG:
//                mimeType=@"image/jpeg";
//                break;
//            case BMP:
//                mimeType=@"image/bmp";
//                break;
//            case GIF:
//                mimeType=@"image/gif";
//                break;
//            default:
//                mimeType=@"image/*";
//                break;
//        }
//        
//        // 上传图片，以文件流的格式
//        [formData appendPartWithFileData:imageData name:imageFileName fileName:imageFileName mimeType:mimeType];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (progress) {
//            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [FLXKHttpRequest sendSuccessResponseData:(id)responseObject withCallbackBlock:success];
//    }
//                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                            [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//                                        }];
//    return dataTask;
//}
//
//- (NSURLSessionTask *)downloadWithUrl:(NSString *)url
//                            saveToPath:(NSString *)saveToPath
//                              progress:(PsyDownloadProgress)progressBlock
//                               success:(PsySuccessResponseBlock)success
//                               failure:(PsyFailedResponseBlock)failure {
//    if ([self baseUrl] == nil && ![self.baseUrl isEqualToString:@""]) {
//        if ([NSURL URLWithString:url] == nil) {
//            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
//            return nil;
//        }
//    } else {
//        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
//            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
//            return nil;
//        }
//    }
//    
//    NSString *actualURLString = [self getActualUrlWithSubURLString:url];
//    //编码url
//    if ([self shouldAutoEncode]) {
//        actualURLString = [self encodeURLString:actualURLString];
//    }
//    //检验actualURLString是否真是NSURL
//    NSURL *trueURL = [NSURL URLWithString:actualURLString];
//
//    if (trueURL == nil) {
//        NSLog(@"url:%@无效，无法生成URL。可能是URL中有中文，请检查URL的正确性",actualURLString);
//        NSError *error = [NSError errorWithDomain:@"NSURLChecking" code:10000 userInfo:@{@"url无效，无法生成URL。请检查URL的正确性。":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//
//    //检查saveToPath是否存在。
//    BOOL *isDirectory=0;
//    if(![[NSFileManager defaultManager]fileExistsAtPath:saveToPath isDirectory:isDirectory]&&!isDirectory){
//        NSLog(@"saveToPath:%@路径不存在。请先建立路径",saveToPath);
//        NSError *error = [NSError errorWithDomain:@"NSURLChecking" code:10000 userInfo:@{@"saveToPath无效,没有此路径。请检查saveToPath的正确性。":NSLocalizedDescriptionKey}];
//        [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        return nil;
//    }
//    
//    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:trueURL];
//    AFHTTPSessionManager *manager = [self getAFHTTPSessionManager];
//    
//    NSURLSessionTask *dataTask = nil;
//    
//    dataTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
//        if (progressBlock) {
//            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
//        }
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        return [NSURL URLWithString:saveToPath];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if (error == nil) {
//            if (success) {
//                success(filePath.absoluteString);
//            }
//            
//        } else {
//            [FLXKHttpRequest handleCallbackWithError:error failure:failure];
//        }
//    }
//                
//                ];
//    return dataTask;
//}
//
//
//
//
//
//#pragma mark - Private Methods
//
//+(void)detectNetwork{
//    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    [reachabilityManager startMonitoring];
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable){
//            networkStatus = PsyNetworkStatusNotReachable;
//        }else if (status == AFNetworkReachabilityStatusUnknown){
//            networkStatus = PsyNetworkStatusUnknown;
//        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            networkStatus = PsyNetworkStatusReachableViaWWAN;
//        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//            networkStatus = PsyNetworkStatusReachableViaWiFi;
//        }
//    }];
//}
//
//- (AFHTTPSessionManager *)getAFHTTPSessionManager {
//    // 开启转圈圈
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
//    
//    AFHTTPSessionManager *manager = nil;;
//    if ([self baseUrl] != nil&&![[self baseUrl]  isEqual: @""]) {
//        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
//    } else {
//        manager = [AFHTTPSessionManager manager];
//    }
//    
//    switch (self.requestType) {
//        case PsyRequestTypeJSON: {
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            break;
//        }
//        case PsyRequestTypePlainText: {
//            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//            break;
//        }
//        default: {
//            break;
//        }
//    }
//    
//    switch (self.responseType) {
//        case PsyResponseTypeJSON: {
//            manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            break;
//        }
//        case PsyResponseTypeXML: {
//            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//            break;
//        }
//        case PsyResponseTypeData: {
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            break;
//        }
//        default: {
//            break;
//        }
//    }
//    
//    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    
//    
//    for (NSString *key in self.httpHeaders.allKeys) {
//        if (self.httpHeaders[key] != nil) {
//            [manager.requestSerializer setValue:self.httpHeaders[key] forHTTPHeaderField:key];
//        }
//    }
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                              @"text/html",
//                                                                              @"text/json",
//                                                                              @"text/plain",
//                                                                              @"text/javascript",
//                                                                              @"text/xml",
//                                                                              @"image/*"]];
//    
//    manager.requestSerializer.timeoutInterval = self.timeout;
//    
//    // 设置允许同时最大并发数量，过大容易出问题
//    manager.operationQueue.maxConcurrentOperationCount = 3;
//    //    [self detectNetwork];
//    return manager;
//}
//
//- (NSString *)getActualUrlWithSubURLString:(NSString *)subURLString {
//    if (subURLString == nil || subURLString.length == 0) {
//        return @"";
//    }
//    
//    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
//        return subURLString;
//    }
//    
//    NSString *absoluteUrl = subURLString;
//    
//    if (![subURLString hasPrefix:@"http://"] && ![subURLString hasPrefix:@"https://"]) {
//        if ([[self baseUrl] hasSuffix:@"/"]) {
//            if ([subURLString hasPrefix:@"/"]) {
//                NSMutableString * mutablePath = [NSMutableString stringWithString:subURLString];
//                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
//                absoluteUrl = [NSString stringWithFormat:@"%@%@",
//                               [self baseUrl], mutablePath];
//            }else {
//                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], subURLString];
//            }
//        }else {
//            if ([subURLString hasPrefix:@"/"]) {
//                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], subURLString];
//            }else {
//                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
//                               [self baseUrl], subURLString];
//            }
//        }
//    }
//    return absoluteUrl;
//}
//
//- (NSString *)encodeURLString:(NSString *)urlString {
//    
//    NSString *newString =[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    //    NSString *newString =
//    //    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//    //                                                              (CFStringRef)url,
//    //                                                              NULL,
//    //                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
//    if (newString) {
//        return newString;
//    }
//    
//    return urlString;
//}
//
//
//+ (id)getCahcedResponseWithURL:(NSString *)url parameters:params {
//    id cacheData = nil;
//    
//    if (url) {
//        // Try to get datas from disk
//        NSString *directoryPath = cachePath();
//        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
//        //            NSString *key = [NSString Psynetworking_md5:absoluteURL];
//        //            NSString *path = [directoryPath stringByAppendingPathComponent:key];
//        NSString *path = [directoryPath stringByAppendingPathComponent:absoluteURL];
//        
//        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
//        if (data) {
//            cacheData = data;
//            NSLog(@"Read data from cache for url: %@\n", url);
//        }
//    }
//    return cacheData;
//}
//
//+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params {
//    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
//        NSString *directoryPath = cachePath();
//        
//        NSError *error = nil;
//        
//        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
//            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
//                                      withIntermediateDirectories:YES
//                                                       attributes:nil
//                                                            error:&error];
//            if (error) {
//                NSLog(@"create cache dir error: %@\n", error);
//                return;
//            }
//        }
//        
//        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
//        //            NSString *key = [NSString Psynetworking_md5:absoluteURL];
//        //            NSString *path = [directoryPath stringByAppendingPathComponent:key];
//        NSString *path = [directoryPath stringByAppendingPathComponent:absoluteURL];
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        
//        NSData *data = nil;
//        if ([dict isKindOfClass:[NSData class]]) {
//            data = responseObject;
//        } else {
//            data = [NSJSONSerialization dataWithJSONObject:dict
//                                                   options:NSJSONWritingPrettyPrinted
//                                                     error:&error];
//        }
//        
//        if (data && error == nil) {
//            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
//            if (isOk) {
//                NSLog(@"cache file ok for request: %@\n", absoluteURL);
//            } else {
//                NSLog(@"cache file error for request: %@\n", absoluteURL);
//            }
//        }
//    }
//}
//+ (void)sendSuccessResponseData:(id)responseData withCallbackBlock:(PsySuccessResponseBlock)success {
//    if (success) {
//        success([FLXKHttpRequest tryToParseResponseDataToJson:responseData]);
//    }
//}
//+ (id)tryToParseResponseDataToJson:(id)responseData {
//    if ([responseData isKindOfClass:[NSData class]]) {
//        // 尝试解析成JSON
//        if (responseData == nil) {
//            return responseData;
//        } else {
//            NSError *error = nil;
//            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
//                                                                     options:NSJSONReadingMutableContainers
//                                                                       error:&error];
//            
//            if (error != nil) {
//                return responseData;
//            } else {
//                return response;
//            }
//        }
//    } else {
//        return responseData;
//    }
//}
//static inline NSString *cachePath() {
//    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/PsyNetworkingCaches"];
//}
//
//
//+ (void)handleCallbackWithError:(NSError *)error failure:(PsyFailedResponseBlock)failure{
//    
//    if (failure) {
//        failure(error);
//    }
//    
//}
//
//// 仅对一级字典结构起作用
//+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
//    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
//        return url;
//    }
//    
//    NSString *queries = @"";
//    for (NSString *key in params) {
//        id value = [params objectForKey:key];
//        
//        if ([value isKindOfClass:[NSDictionary class]]) {
//            continue;
//        } else if ([value isKindOfClass:[NSArray class]]) {
//            continue;
//        } else if ([value isKindOfClass:[NSSet class]]) {
//            continue;
//        } else {
//            queries = [NSString stringWithFormat:@"%@%@=%@&",
//                       (queries.length == 0 ? @"&" : queries),
//                       key,
//                       value];
//        }
//    }
//    
//    if (queries.length > 1) {
//        queries = [queries substringToIndex:queries.length - 1];
//    }
//    
//    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
//        if ([url rangeOfString:@"?"].location != NSNotFound
//            || [url rangeOfString:@"#"].location != NSNotFound) {
//            url = [NSString stringWithFormat:@"%@%@", url, queries];
//        } else {
//            queries = [queries substringFromIndex:1];
//            url = [NSString stringWithFormat:@"%@?%@", url, queries];
//        }
//    }
//    
//    return url.length == 0 ? queries : url;
//}
//
//
//@end
