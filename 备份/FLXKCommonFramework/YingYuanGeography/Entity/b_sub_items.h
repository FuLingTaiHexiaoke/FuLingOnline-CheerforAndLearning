//
//  b_sub_items.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/3/30.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface ThirdLevelImages : NSObject
@interface b_sub_items : NSObject
@property(nonatomic,assign) NSUInteger  id;
@property(nonatomic,strong)  NSString *name;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *detail_description;
@property (nonatomic,strong) NSString * image_name;
@property (nonatomic,assign) NSUInteger  item_id;
@property (nonatomic,strong) NSString * for_expand1;
@property (nonatomic,strong) NSString * for_expand2;
@property (nonatomic,strong) NSString * for_expand3;

//@property(nonatomic,strong) NSString * id;
//@property(nonatomic,strong) NSString * imageName;
//@property(nonatomic,strong) NSString * pageControllerColor;
//@property(nonatomic,assign) NSInteger  orderTag;//顺序编号
//@property(nonatomic,strong) NSString * imageFrame;
//@property(nonatomic,assign) NSInteger accordingButtonTag;//顺序编号
//@property(nonatomic,strong) NSString * VCName;


//createTable
+ (BOOL)createTable
;
//dropTable
+ (BOOL)dropTable
;
//selectAll
+ (NSArray<b_sub_items*> *)selectAll
;
//selectByCriteria
+ (NSArray<b_sub_items*> *)selectByCriteria:(NSString *)criteria
;
//insertWithObject:
+ (BOOL)insertWithObject:(b_sub_items*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<b_sub_items*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObject:(b_sub_items*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<b_sub_items*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
;



@end
