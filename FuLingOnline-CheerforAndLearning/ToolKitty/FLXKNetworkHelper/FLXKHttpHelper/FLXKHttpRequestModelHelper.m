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

//models
#import "FLXKModelsBrigde.h"

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

//获取朋友圈cell model
-(void)getFriendSharingModel{
    [FLXKHttpRequest  get:Url_GetFriendSharingModel success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray<FLXKPublishNewsModel*> *newsModels = [FLXKPublishNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSMutableArray<FLXKSharingCellModel*>* models=[NSMutableArray array];
        [newsModels enumerateObjectsUsingBlock:^(FLXKPublishNewsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FLXKSharingCellModel* model=[FLXKSharingCellModel new];
            model.avatarImageUrl=obj.head_url?obj.head_url: @"Spark";
            model.nickName=obj.editor?obj.editor: @"Spark";
            model.timestamp=obj.ptime?obj.ptime.description: @"Spark";
            model.mainSharingContent=obj.doc_content?obj.doc_content: @"Spark";
            model.sharingImages=obj.image_urls? [self getArrayFromString: obj.image_urls]: @[ @"Spark"];
            model.locationRecord=obj.video_url?obj.video_url: @"Spark";//reset model
            //            model.likeTheSharingRecords=obj.thumbsupCount?@"Spark": @"Spark";
            //            model.sharingComments=obj.thumbsupCount?@"Spark": @"Spark";
            [models addObject:model];
        }];
        self.successCallback(models);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}

#pragma mark - models helper

-(NSArray<FLXKSharingImagesModel*>*)getArrayFromString:(NSString*)stringArray{
    NSArray<FLXKSharingImagesModel*>*  models;
    NSError* err;
    NSArray* temp_models=   [NSJSONSerialization JSONObjectWithData:[stringArray dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&err];
    if (err) {
    }
    else{
        models= [FLXKSharingImagesModel mj_objectArrayWithKeyValuesArray:temp_models];
    }
    return models;
}

@end
