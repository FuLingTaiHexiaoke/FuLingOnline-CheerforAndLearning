////
////  PsyHttpRequest.h
////  PSYLife-NewStructure
////
////  Created by apple on 16/5/27.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//#import "AFNetworking.h"
//#import "config.h"
//
//
//typedef NS_ENUM(NSInteger, PsyImageMimeType) {
//    PNG = 0,//image/png
//    JPEG= 1,//image/jpeg
//    BMP = 2,//image/bmp
//    GIF = 3,//image/gif
//};
//
///*!
// *
// *  下载进度
// *
// *  @param bytesRead                 已下载的大小
// *  @param totalBytesRead            文件总大小
// *  @param totalBytesExpectedToRead 还有多少需要下载
// */
//typedef void (^PsyDownloadProgress)(int64_t bytesRead,
//                                    int64_t totalBytesRead);
//
//typedef PsyDownloadProgress PsyGetProgress;
//typedef PsyDownloadProgress PsyPostProgress;
//
//
///*!
// *
// *  上传进度
// *
// *  @param bytesWritten              已上传的大小
// *  @param totalBytesWritten         总上传大小
// */
//typedef void (^PsyUploadProgress)(int64_t bytesWritten,
//                                  int64_t totalBytesWritten);
//
//
//typedef NS_ENUM(NSInteger, PsyNetworkStatus) {
//    PsyNetworkStatusUnknown          = -1,//未知网络
//    PsyNetworkStatusNotReachable     = 0,//网络无连接
//    PsyNetworkStatusReachableViaWWAN = 1,//2，3，4G网络
//    PsyNetworkStatusReachableViaWiFi = 2,//WIFI网络
//};
//
//typedef NS_ENUM(NSInteger , PsyRequestMethod) {
//    PsyRequestMethodGet = 0,
//    PsyRequestMethodPost,
//    PsyRequestMethodHead,
//    PsyRequestMethodPut,
//    PsyRequestMethodDelete,
//    PsyRequestMethodPatch,
//};
//
//typedef NS_ENUM(NSUInteger, PsyResponseType) {
//    PsyResponseTypeJSON = 1, // 默认
//    PsyResponseTypeXML  = 2, // XML
//                             // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
//    PsyResponseTypeData = 3
//};
//
//typedef NS_ENUM(NSUInteger, PsyRequestType) {
//    PsyRequestTypeJSON = 1, // 默认
//    PsyRequestTypePlainText  = 2 // 普通text/html
//};
//
//
//
//
///**
// *  common setting
// */
//
//typedef void(^PsySuccessResponseBlock)(id response);
//typedef void(^PsySuccessJsonResponseBlock)(NSDictionary* dic);
//typedef void(^PsyFailedResponseBlock)(NSError *error);
//typedef void (^PsyDownloadProgress)(int64_t bytesRead,
//                                    int64_t totalBytesRead);
//typedef PsyDownloadProgress PsyGetProgress;
//typedef PsyDownloadProgress PsyPostProgress;
//
//
//
//@interface FLXKHttpRequest : NSObject
//#pragma mark - properties for  entity methods
//@property(nonatomic) NSString *baseUrl;
//@property(nonatomic) BOOL shouldAutoEncode;
//@property(nonatomic) NSDictionary *httpHeaders;
//@property(nonatomic) PsyResponseType responseType;
//@property(nonatomic) PsyRequestType  requestType;
////@property(nonatomic) PsyNetworkStatus networkStatus;
//@property(nonatomic) NSMutableArray *requestTasks;
//@property(nonatomic) NSTimeInterval timeout;
//@property(nonatomic) BOOL shouldGetCachedData;//是否获取已经缓存的数据
//@property(nonatomic) BOOL shouldCacheData;//是否缓存的获得的数据
//
//#pragma mark - static methods
////监测网络状况，由于存在延时，所以应该很早的时候进行调用。
//+(void)detectNetwork;
//
///** 静态方法说明
// *1.serialise默认设定responseSerialise为AFJSONResponseSerializer，requestSerialise为AFHttpRequestSerializer.如果需要特别指定，请使用PsyHttpRequest实体方法。
// *2.params暂定为NSDictionary。有待深入理解和运用。
// *3.PsySuccessJsonResponseBlock直接以json格式的数据返回。见PsySuccessJsonResponseBlock得定义。
// *4.Url为简单方便。在此省略去baseUrl，shouldAutoEncode的判断和配置。请自行处理。（可以建立一个model中间层）。
// */
//
//+ (NSURLSessionTask *)getWithUrl:(NSString *)url
//                          params:(NSDictionary *)params
//                        progress:(PsyGetProgress)progress
//                         success:(PsySuccessJsonResponseBlock)success
//                            failure:(PsyFailedResponseBlock)failure;
//
//+ (NSURLSessionTask *)postWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                         progress:(PsyPostProgress)progress
//                          success:(PsySuccessJsonResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure;
//
//+ (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
//                      uploadingFilePath:(NSString *)uploadingFilePath
//                               progress:(PsyUploadProgress)progress
//                                success:(PsySuccessJsonResponseBlock)success
//                                   failure:(PsyFailedResponseBlock)failure;
//
//+ (NSURLSessionTask *)uploadWithImage:(UIImage *)image
//                                  url:(NSString *)url
//                             filename:(NSString *)filename
//                                 name:(NSString *)name
//                             mimeType:(PsyImageMimeType)imageMimeType
//                           parameters:(NSDictionary *)parameters
//                             progress:(PsyUploadProgress)progress
//                              success:(PsySuccessResponseBlock)success
//                                 failure:(PsyFailedResponseBlock)failure;
//
//+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
//                           saveToPath:(NSString *)saveToPath
//                             progress:(PsyDownloadProgress)progressBlock
//                              success:(PsySuccessJsonResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure;
//
//#pragma mark - entity methods
///**
// *
// *	取消所有请求
// */
////-(void)cancelAllRequest;
///**
// *
// *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的NSURLSessionTask对象，
// *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
// *
// *	@param url				URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
// */
////- (void)cancelRequestWithURL:(NSString *)url;
//
///*!
// *
// *  GET请求接口，若不指定baseurl，可传完整的url
// *
// *  @param url     接口路径，如/path/getArticleList
// *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
// *  @param params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
// *  @param success 接口成功请求到数据的回调
// *  @param fail    接口请求数据失败的回调
// *
// *  @return 返回的对象中有可取消请求的API
// */
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                          success:(PsySuccessResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure;
//// 多一个params参数
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                          success:(PsySuccessResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure;
//// 多一个带进度回调
//- (NSURLSessionTask *)getWithUrl:(NSString *)url
//                           params:(NSDictionary *)params
//                         progress:(PsyGetProgress)progress
//                          success:(PsySuccessResponseBlock)success
//                             failure:(PsyFailedResponseBlock)failure;
//
///*!
// *
// *  POST请求接口，若不指定baseurl，可传完整的url
// *
// *  @param url     接口路径，如/path/getArticleList
// *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
// *  @param success 接口成功请求到数据的回调
// *  @param fail    接口请求数据失败的回调
// *
// *  @return 返回的对象中有可取消请求的API
// */
//- (NSURLSessionTask *)postWithUrl:(NSString *)url
//                            params:(NSDictionary *)params
//                           success:(PsySuccessResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure;
//
//
//- (NSURLSessionTask *)postWithUrl:(NSString *)url
//                            params:(NSDictionary *)params
//                          progress:(PsyPostProgress)progress
//                           success:(PsySuccessResponseBlock)success
//                              failure:(PsyFailedResponseBlock)failure;
///**
// *
// *	图片上传接口，若不指定baseurl，可传完整的url
// *
// *	@param image			图片对象
// *	@param url				上传图片的接口路径，如/path/images/
// *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
// *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
// *	@param mimeType		默认为image/jpeg
// *	@param parameters	参数
// *	@param progress		上传进度
// *	@param success		上传成功回调
// *	@param fail				上传失败回调
// *
// *	@return
// */
//- (NSURLSessionTask *)uploadWithImage:(UIImage *)image
//                                   url:(NSString *)url
//                              filename:(NSString *)filename
//                                  name:(NSString *)name
//                              mimeType:(PsyImageMimeType)imageMimeType
//                            parameters:(NSDictionary *)parameters
//                              progress:(PsyUploadProgress)progress
//                               success:(PsySuccessResponseBlock)success
//                                  failure:(PsyFailedResponseBlock)failure;
//
///**
// *
// *	上传文件操作
// *
// *	@param url						上传路径
// *	@param uploadingFile	待上传文件的路径
// *	@param progress			上传进度
// *	@param success				上传成功回调
// *	@param fail					上传失败回调
// *
// *	@return
// */
//- (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
//                       uploadingFilePath:(NSString *)uploadingFilePath
//                                progress:(PsyUploadProgress)progress
//                                 success:(PsySuccessResponseBlock)success
//                                    failure:(PsyFailedResponseBlock)failure;
///*!
// *
// *  下载文件
// *
// *  @param url           下载URL
// *  @param saveToPath    下载到哪个路径下
// *  @param progressBlock 下载进度
// *  @param success       下载成功后的回调
// *  @param failure       下载失败后的回调
// */
//- (NSURLSessionTask *)downloadWithUrl:(NSString *)url
//                            saveToPath:(NSString *)saveToPath
//                              progress:(PsyDownloadProgress)progressBlock
//                               success:(PsySuccessResponseBlock)success
//                               failure:(PsyFailedResponseBlock)failure;
//
//
//
//@end
//
//
