//
//  UserScroeRecord.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserScroeRecord : NSObject

//user
@property(nonatomic,strong) NSString * user_id;//UUID
@property(nonatomic,strong) NSString * user_name;//用户名字
@property(nonatomic,strong) NSString * user_class;//用户班级
@property(nonatomic,strong) NSString * user_type;//用户类型
@property(nonatomic,strong) NSString * user_school;//用户学校

//用户数据记录
@property(nonatomic,assign) NSInteger currentScroe;//当前分数
@property(nonatomic,strong) NSString * currentScroeDescription;//当前分数详情

@property (nonatomic,strong) NSString * for_expand1;//备用 题号（第几题）
@property (nonatomic,strong) NSString * for_expand2;//备用 题目名称
@property (nonatomic,strong) NSString * for_expand3;//备用

//三级界面相应信息
@property(nonatomic,strong) NSString * accordingVCName;//三级页面，相应视图名称
@property(nonatomic,strong) NSString * testType;//三级页面，类型
//@property(nonatomic,strong) NSString * currentLevelThreeVCName;//三级页面，相应视图名称
//@property(nonatomic,strong) NSString * currentLevelThreeVCDescription;//三级页面细信息

//二级界面相应信息
@property(nonatomic,assign) NSInteger menuButtonTag;//对应二级界面弹出菜单上哪个点击按钮Tag（弹出菜单）
@property(nonatomic,assign) NSString *menuButtonName;//对应二级界面弹出菜单上哪个点击按钮名称（弹出菜单）
@property(nonatomic,assign) NSInteger accordingButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
@property(nonatomic,assign) NSString *accordingButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
@property(nonatomic,strong) NSString * VCName;//对应二级界面名称
@property(nonatomic,strong) NSString * VCNameDescription;//对应二级界面名称
//@property(nonatomic,strong) NSString *currentLevelTwoVCName;//当前对应二级界面名称
//@property(nonatomic,strong) NSString * currentLevelTwoVCDescription;//对应二级界面详细信息


@property (nonatomic,strong) NSString * for_expand4;//备用
@property (nonatomic,strong) NSString * for_expand5;//备用
@property (nonatomic,strong) NSString * for_expand6;//备用
@property (nonatomic,strong) NSString * for_expand7;//备用
@property (nonatomic,strong) NSString * for_expand8;//备用
@property (nonatomic,strong) NSString * for_expand9;//备用
@property (nonatomic,strong) NSString * for_expand10;//备用



//createTable
+ (BOOL)createTable
;
//dropTable
+ (BOOL)dropTable
;
//selectAll
+ (NSArray<UserScroeRecord*> *)selectAll
;
//selectByCriteria
+ (NSArray<UserScroeRecord*> *)selectByCriteria:(NSString *)criteria
;

//selectTotalScoreByCriteria
+ (NSInteger)selectTotalScoreByCriteria:(NSString *)criteria;

//insertWithObject:
+ (BOOL)insertWithObject:(UserScroeRecord*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<UserScroeRecord*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(UserScroeRecord*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<UserScroeRecord*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
@end
