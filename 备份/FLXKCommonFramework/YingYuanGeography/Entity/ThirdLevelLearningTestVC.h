//
//  ThirdLevelCommonImages.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdLevelLearningTestVC : NSObject
@property(nonatomic,strong) NSString * id;//UUID
@property(nonatomic,strong) NSString * txtFileName;//三级习题页面，配置文件名称
@property(nonatomic,strong) NSString * accordingVCName;//三级习题页面，相应视图名称
@property(nonatomic,strong) NSString * testType;//三级习题页面，相应视图对应的题型
@property(nonatomic,strong) NSString * ImageSelectWord;//三级习题页面，相应视图对应的选中状态图
@property(nonatomic,strong) NSString * ImageSelectPicture;//三级习题页面，相应视图对应的选中状态图
@property(nonatomic,assign) NSInteger  orderTag;//三级习题页面，视图顺序
@property(nonatomic,assign) NSInteger menuButtonTag;//对应二级界面弹出菜单上哪个点击按钮Tag（弹出菜单）
@property(nonatomic,assign) NSString *menuButtonName;//对应二级界面弹出菜单上哪个点击按钮名称（弹出菜单）
@property(nonatomic,assign) NSInteger accordingButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
@property(nonatomic,assign) NSString *accordingButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
@property(nonatomic,strong) NSString * VCName;//对应二级界面名称
@property(nonatomic,strong) NSString * VCNameDescription;//对应二级界面名称

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
+ (NSArray<ThirdLevelLearningTestVC*> *)selectAll
;
//selectByCriteria
+ (NSArray<ThirdLevelLearningTestVC*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelLearningTestVC*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelLearningTestVC*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(ThirdLevelLearningTestVC*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<ThirdLevelLearningTestVC*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
@end
