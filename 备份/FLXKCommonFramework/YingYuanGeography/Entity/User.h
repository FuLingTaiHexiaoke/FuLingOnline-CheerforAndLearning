//
//  User.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong) NSString * user_id;//UUID
@property(nonatomic,strong) NSString * user_name;//用户名字
@property(nonatomic,strong) NSString * user_class;//用户班级
@property(nonatomic,strong) NSString * user_type;//用户类型
@property(nonatomic,strong) NSString * user_school;//用户学校
@property(nonatomic,strong) NSString * user_sex;//用户性别
@property(nonatomic,strong) NSString * user_birthday;//用户出生年月
@property(nonatomic,strong) NSString * user_use_timestamp;//用户使用日期
@property(nonatomic,strong) NSString * user_total_time;//用户使用时长
@property(nonatomic,strong) NSString * user_total_times;//用户使用次数

@property (nonatomic,strong) NSString * for_expand1;//备用
@property (nonatomic,strong) NSString * for_expand2;//备用
@property (nonatomic,strong) NSString * for_expand3;//备用
@property (nonatomic,strong) NSString * for_expand4;//备用
@property (nonatomic,strong) NSString * for_expand5;//备用
@property (nonatomic,strong) NSString * for_expand6;//备用
//@property (nonatomic,strong) NSString * for_expand7;//备用
//@property (nonatomic,strong) NSString * for_expand8;//备用
//@property (nonatomic,strong) NSString * for_expand9;//备用
//@property (nonatomic,strong) NSString * for_expand10;//备用




//createTable
+ (BOOL)createTable
;
//dropTable
+ (BOOL)dropTable
;
//selectAll
+ (NSArray<User*> *)selectAll
;
//selectByCriteria
+ (NSArray<User*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(User*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<User*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(User*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<User*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;


@end
