//
//  NSObject+ModelHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/25.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelHelper)
//获取对象的所有属性
- (NSArray *)getAllProperties;

//Model 到字典
- (NSDictionary *)modelToDic;
@end
