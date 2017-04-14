//
//  FLXKHttpRequestModelHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

//models
#import "FLXKModelsBrigde.h"

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

//新闻、状态发布
-(void)publishEditedNewsWithModel:(FLXKPublishNewsModel*)model pictures:(NSArray<UIImage*>*)pictures;

//添加用户
-(void)addUserModel:(UserModel*)model pictures:(NSArray<UIImage*>*)pictures;
//获取用户
-(void)getUserModel;


//获取朋友圈cell model
-(void)getFriendSharingModel;

//点赞
-(void)addFriendsharingThumbup:(NSDictionary*)parameters;
@end
