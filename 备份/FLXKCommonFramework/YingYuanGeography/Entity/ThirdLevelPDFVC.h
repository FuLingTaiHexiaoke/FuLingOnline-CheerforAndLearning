//
//  ThirdLevelCommonImages.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdLevelPDFVC : NSObject
@property(nonatomic,strong) NSString * id;//UUID
@property (nonatomic,strong) NSString *title;//三级信息浏览页面，标题
@property(nonatomic,strong) NSString * PDFName;//三级信息浏览页面，PDF名称
@property(nonatomic,strong) NSString * imageName;//三级信息浏览页面，PDF改成相应图片名称
@property (nonatomic,strong) NSString *detail_description;//三级信息浏览页面，详细信息
@property(nonatomic,assign) NSInteger  orderTag;//三级信息浏览页面，资源顺序
@property(nonatomic,assign) NSInteger accordingButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
@property(nonatomic,assign) NSString *accordingButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
@property(nonatomic,strong) NSString * VCName;//对应二级界面名称
@property(nonatomic,strong) NSString * VCNameDescription;//对应二级界面名称

@property (nonatomic,strong) NSString * for_expand1;//备用
@property (nonatomic,strong) NSString * for_expand2;//备用
@property (nonatomic,strong) NSString * for_expand3;//备用

//createTable
+ (BOOL)createTable
;
//dropTable
+ (BOOL)dropTable
;
//selectAll
+ (NSArray<ThirdLevelPDFVC*> *)selectAll
;
//selectByCriteria
+ (NSArray<ThirdLevelPDFVC*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelPDFVC*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelPDFVC*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(ThirdLevelPDFVC*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<ThirdLevelPDFVC*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;



////selectTotalScoreByCriteria
//+ (NSString*)selectTotalScoreByCriteria:(NSString *)criteria
//{
//    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
//    //    NSMutableArray *entitiyResults = [NSMutableArray array];
//    __block  NSString* totalScore;
//    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT SUM(currentScroe) FROM UserScroeRecord %@",criteria];
//        FMResultSet *resultSet = [db executeQuery:sql];
//        while ([resultSet next]) {
//            totalScore=[resultSet stringForColumn:@"currentScroe"];
//        }
//    }];
//    return totalScore;
//};
@end
