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

//添加用户
-(void)addUserModel:(UserModel*)model pictures:(NSArray<UIImage*>*)pictures{
    NSDictionary *modelDict= model.mj_keyValues;
    [FLXKHttpRequest upload:Url_AddUser parameters:modelDict images:pictures success:^(NSURLSessionDataTask *task, id responseObject) {
        self.successCallback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}

//获取用户
-(void)getUserModel{
    [FLXKHttpRequest  get:[NSString stringWithFormat:@"%@%@",Url_GetUser,UserDefaultsObjForKey(@"login_user_name")] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray<FLXKPublishNewsModel*>   *models = [UserModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (models.count>0) {
            self.successCallback(models[0]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}

////获取朋友圈cell model
//-(void)getFriendSharingModel{
//    [FLXKHttpRequest  post:Url_GetFriendSharingModel parameters:<#(NSDictionary *)#> success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSArray<FLXKPublishNewsModel*> *newsModels = [FLXKPublishNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
//        NSMutableArray<FLXKSharingCellModel*>* models=[NSMutableArray array];
//        [newsModels enumerateObjectsUsingBlock:^(FLXKPublishNewsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            FLXKSharingCellModel* model=[FLXKSharingCellModel new];
//            model.newsID=obj.uid;
//            model.isThumberuped=obj.isThumberuped;
//            model.avatarImageUrl=obj.head_url?obj.head_url: @"Spark";
//            model.nickName=obj.editor?obj.editor: @"Spark";
//            model.timestamp=obj.ptime?obj.ptime.description: @"Spark";
//            model.mainSharingContent=obj.doc_content?obj.doc_content: @"Spark";
//            model.sharingImages= [FLXKSharingImagesModel mj_objectArrayWithKeyValuesArray: [FLXKHttpRequestModelHelper getArrayFromString:obj.image_urls]];
//            model.locationRecord=obj.doc_url?obj.doc_url: @"Spark";//reset model
//            model.likeTheSharingUserRecords= [UserModel mj_objectArrayWithKeyValuesArray: [FLXKHttpRequestModelHelper getArrayFromString:obj.detail_url]] ;
//            
//            [models addObject:model];
//        }];
//        self.successCallback(models);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        self.failureCallback(error);
//    }];
//}

//2017-4-17
//获取朋友圈cell model
-(void)getFriendSharingModelWithCondition:(NSDictionary*)parameters{
    [FLXKHttpRequest  post:Url_GetFriendSharingModel parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray<FLXKPublishNewsModel*> *newsModels = [FLXKPublishNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSMutableArray<FLXKSharingCellModel*>* models=[NSMutableArray array];
        [newsModels enumerateObjectsUsingBlock:^(FLXKPublishNewsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FLXKSharingCellModel* model=[FLXKSharingCellModel new];
            model.newsID=obj.uid;
            model.isThumberuped=obj.isThumberuped;
            model.avatarImageUrl=obj.head_url?obj.head_url: @"Spark";
            model.nickName=obj.editor?obj.editor: @"Spark";
            model.timestamp=obj.ptime?obj.ptime.description: @"Spark";
            model.mainSharingContent=obj.doc_content?obj.doc_content: @"Spark";
            model.sharingImages= [FLXKSharingImagesModel mj_objectArrayWithKeyValuesArray: [FLXKHttpRequestModelHelper getArrayFromString:obj.image_urls]];
            model.locationRecord=obj.doc_url?obj.doc_url: @"Spark";//reset model
            model.likeTheSharingUserRecords= [UserModel mj_objectArrayWithKeyValuesArray: [FLXKHttpRequestModelHelper getArrayFromString:obj.detail_url]] ;
            model.sharingComments=[SharingCommentCellModel mj_objectArrayWithKeyValuesArray:obj.subtitle];
            [models addObject:model];
        }];
        self.successCallback(models);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}

//点赞
-(void)addFriendsharingThumbup:(NSDictionary*)parameters{
    [FLXKHttpRequest post:Url_AddFriendsharingThumbup parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
       NSNumber* state= [responseObject objectForKey:@"state"];
        if (state.integerValue==0) {
            self.successCallback(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         self.failureCallback(error);
    }];
}

//评论
-(void)addFriendsharingComment:(NSDictionary*)parameters{
    [FLXKHttpRequest post:Url_AddFriendsharingComment parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber* state= [responseObject objectForKey:@"state"];
        if (state.integerValue==0) {
            self.successCallback(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}

#pragma mark - models helper

+(NSArray*)getArrayFromString:(NSString*)stringArray{
    NSError* err;
    NSArray* array=   [NSJSONSerialization JSONObjectWithData:[stringArray dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        return nil;
    }
    return array;
}

//-(NSArray<FLXKSharingImagesModel*>*)getArrayFromString:(NSString*)stringArray{
//    NSArray<FLXKSharingImagesModel*>*  models;
//    NSError* err;
//    NSArray* temp_models=   [NSJSONSerialization JSONObjectWithData:[stringArray dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&err];
//    if (err) {
//    }
//    else{
//        models= [FLXKSharingImagesModel mj_objectArrayWithKeyValuesArray:temp_models];
//    }
//    return models;
//}



@end
