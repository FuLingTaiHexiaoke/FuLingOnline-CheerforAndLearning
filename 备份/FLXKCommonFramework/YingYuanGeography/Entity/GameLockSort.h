//
//  GameLockSort.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameLockSort : NSObject
@property(nonatomic,strong) NSString * id;//UUID
@property(nonatomic,strong) NSString * currentVCName;//当前需要解锁二级界面名称
@property(nonatomic,strong) NSString * currentVCNameDescription;//当前需要解锁二级界面名称详细信息
@property(nonatomic,strong) NSString * previousVCName;//当前需要解锁二级界面，对应的上一个二级界面名称
@property(nonatomic,strong) NSString * previousVCNameDescription;//当前需要解锁二级界面，对应的上一个二级界面名称详细信息
@property(nonatomic,strong) NSString * nextVCName;//当前需要解锁二级界面，对应的下一个二级界面名称
@property(nonatomic,strong) NSString * nextVCNameDescription;//当前需要解锁二级界面，对应的下一个二级界面名称详细信息
@property(nonatomic,assign) NSInteger unlock_sort;//解锁顺序
@property(nonatomic,assign) CGFloat currentVCTotalScroe;//当前游戏满分是多少
@property(nonatomic,strong) NSString * previousVC_minScroe;//解锁当前游戏，需要前面游戏的最小分数
@property(nonatomic,strong) NSString * previousVC_minScroePercent;//解锁当前游戏，需要前面游戏的最小分数百分比

@property (nonatomic,strong) NSString * for_expand1;//备用
@property (nonatomic,strong) NSString * for_expand2;//备用
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
+ (NSArray<GameLockSort*> *)selectAll
;
//selectByCriteria
+ (NSArray<GameLockSort*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(GameLockSort*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<GameLockSort*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(GameLockSort*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<GameLockSort*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
@end
