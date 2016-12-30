//
//  FLXKHttpRequestModelHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKHttpRequestModelHelper.h"
#import "FLXKHttpRequest.h"
#import "MJExtension.h"

@implementation FLXKHttpRequestModelHelper

+(FLXKHttpRequestModelHelper*)registerSuccessCallback:(successCallback)successCallback failureCallback:(failureCallback)failureCallback{
    FLXKHttpRequestModelHelper* strongSelf=[[FLXKHttpRequestModelHelper alloc]init];
    strongSelf.successCallback=successCallback;
    strongSelf.failureCallback=failureCallback;
    return strongSelf;
}

//新闻、状态发布
-(void)publishEditedNewsWithModel:(FLXKPublishNewsModel*)model pictures:(NSArray<UIImage*>*)pictures{
    NSDictionary *modelDict= model.mj_keyValues;
    [FLXKHttpRequest upload:Url_UploadPublishNews parameters:modelDict images:pictures success:^(NSURLSessionDataTask *task, id responseObject) {
        self.successCallback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];

}
@end
