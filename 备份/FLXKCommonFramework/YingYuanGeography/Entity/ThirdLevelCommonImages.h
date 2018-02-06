//
//  ThirdLevelCommonImages.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

//三级界面基本图片替换
@interface ThirdLevelCommonImages : NSObject
@property(nonatomic,strong) NSString * backgroundImageName;//背景图
@property(nonatomic,strong) NSString * previousImageName;//上一页图
@property(nonatomic,strong) NSString * nextImageName;//下一页图
@property(nonatomic,strong) NSString * previousVCName;//二级界面名称
@property(nonatomic,strong) NSString * VCNameDescription;//对应二级界面名称

@property (nonatomic,strong) NSString * for_expand1;//备用 feedBackView_centerImageName, FeedBackView里面对应的centerImageName
@property (nonatomic,strong) NSString * for_expand2;//备用 bgTransparentImageName 背景图中间为透明底图的图片名称。
@property (nonatomic,strong) NSString * for_expand3;//备用
@property (nonatomic,strong) NSString * for_expand4;//备用
@property (nonatomic,strong) NSString * for_expand5;//备用
@property (nonatomic,strong) NSString * for_expand6;//备用

//createTable
+ (BOOL)createTable
;
//dropTable
+ (BOOL)dropTable
;
//selectAll
+ (NSArray<ThirdLevelCommonImages*> *)selectAll
;
//selectByCriteria
+ (NSArray<ThirdLevelCommonImages*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelCommonImages*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelCommonImages*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(ThirdLevelCommonImages*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<ThirdLevelCommonImages*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;

@end
