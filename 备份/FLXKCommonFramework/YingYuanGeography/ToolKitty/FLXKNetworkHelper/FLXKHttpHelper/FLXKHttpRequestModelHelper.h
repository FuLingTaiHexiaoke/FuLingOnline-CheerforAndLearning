//
//  FLXKHttpRequestModelHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

//models

////model//新闻、状态发布
//#import "FLXKPublishNewsModel.h"

typedef void (^successCallback)(id  obj);
typedef void (^failureCallback)(NSError *err);
typedef void (^taskProgress)(NSProgress * progress);

//运用MVVM模式
@interface FLXKHttpRequestModelHelper : NSObject
@property(nonatomic,strong)successCallback successCallback;
@property(nonatomic,strong)failureCallback failureCallback;

//便捷方式
+(FLXKHttpRequestModelHelper*)registerSuccessCallback:(successCallback)successCallback failureCallback:(failureCallback)failureCallback;

/**
 上传本地记录的数据文件
 */
- (void)uploadLocalFile;
@end
