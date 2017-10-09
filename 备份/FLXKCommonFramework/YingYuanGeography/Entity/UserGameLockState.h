//
//  GameLockSort.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGameLockState : NSObject
@property(nonatomic,strong) NSString * user_id;//UUID
@property(nonatomic,strong) NSString * user_name;//用户名字
@property(nonatomic,strong) NSString * user_class;//用户班级
@property(nonatomic,strong) NSString * user_type;//用户类型
@property(nonatomic,strong) NSString * user_school;//用户学校

@property(nonatomic,strong) NSString * currentVCName;//当前需要解锁二级界面名称
@property(nonatomic,strong) NSString * currentVCNameDescription;//当前需要解锁二级界面名称详细信息
@property(nonatomic,assign) NSInteger currentVCIsUnlocked;//当前游戏是否解锁

@property (nonatomic,strong) NSString * currentVCScore;//备用  当前游戏分数
@property (nonatomic,strong) NSString * for_expand2;//备用 unlock_sort 排列序号 NSInteger
@property (nonatomic,strong) NSString * for_expand3;//备用 currentVCTotalScore 当前游戏总分数 CGFloat
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
+ (NSArray<UserGameLockState*> *)selectAll
;
//selectByCriteria
+ (NSArray<UserGameLockState*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(UserGameLockState*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<UserGameLockState*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(UserGameLockState*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<UserGameLockState*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;

@end
