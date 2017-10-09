//
//  ThirdLevelCommonImages.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdLevelMovieVC : NSObject
@property(nonatomic,strong) NSString * id;//UUID
@property (nonatomic,strong) NSString *title;//三级页面，标题
@property(nonatomic,strong) NSString * coverName;//三级视频浏览页面，视频cover图名称
@property(nonatomic,strong) NSString * MovieName;//三级视频浏览页面，视频名称
@property (nonatomic,strong) NSString *detail_description;//三级页面，详细信息
@property(nonatomic,assign) NSInteger  orderTag;//三级视频浏览页面，资源顺序
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
+ (NSArray<ThirdLevelMovieVC*> *)selectAll
;
//selectByCriteria
+ (NSArray<ThirdLevelMovieVC*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelMovieVC*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelMovieVC*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(ThirdLevelMovieVC*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<ThirdLevelMovieVC*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
@end
