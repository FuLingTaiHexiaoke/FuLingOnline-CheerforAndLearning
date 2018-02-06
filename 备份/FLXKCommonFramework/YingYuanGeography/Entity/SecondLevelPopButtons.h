//
//  ThirdLevelCommonImages.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

//二级界面弹出菜单
@interface SecondLevelPopButtons : NSObject
@property(nonatomic,strong) NSString * id;//UUID
@property(nonatomic,strong) NSString * imageName;//二级界面弹出菜单button背景图名称
@property(nonatomic,strong) NSString * centerColorName;//二级界面弹出菜单中间图动画颜色
@property(nonatomic,strong) NSString * destinationVCName;//二级界面弹出菜单中选中按钮目标视图
@property(nonatomic,assign) NSInteger  orderTag;//二级界面弹出菜单button顺序编号
@property(nonatomic,assign) CGFloat radialRadius;//二级界面弹出菜单圆圈半径
@property(nonatomic,strong) NSString * buttonFrame;//二级界面弹出菜单button大小
@property(nonatomic,assign) NSInteger accordingButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
@property(nonatomic,strong) NSString *accordingButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
@property(nonatomic,strong) NSString * VCName;//对应二级界面名称
@property(nonatomic,strong) NSString * VCNameDescription;//对应二级界面名称

@property (nonatomic,strong) NSString * for_expand1;//centerImageName 对应弹出菜单中间部分指示图片的名称，没有名称的话，就不显示。
@property (nonatomic,strong) NSString * for_expand2;//shouldShow 控制弹出菜单中是否显示此button，1：显示 0：不显示
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
+ (NSArray<SecondLevelPopButtons*> *)selectAll
;
//selectByCriteria
+ (NSArray<SecondLevelPopButtons*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(SecondLevelPopButtons*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<SecondLevelPopButtons*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(SecondLevelPopButtons*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//updateObjects:
+ (BOOL)updateObjects:(NSArray<SecondLevelPopButtons*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//deleteWithWhereString:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//clearTableSuccess:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
@end
