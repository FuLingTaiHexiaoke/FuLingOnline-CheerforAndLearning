//
//  FLXKSharedAppSingleton.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/13.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
//utilites
//models
#import "UserModel.h"
//subviews
//child viewController
@interface FLXKSharedAppSingleton : NSObject
//IBOutlet
//IBAction

+ (instancetype)sharedSingleton;

+(void)getSharedAPPUser;
+(void)downloadTest;
//models
@property(nonatomic,strong) UserModel* sharedUser;
//UI state record properties
//subviews
//child viewController
//public actions
@end

/**
 分数记录
 
 @param score The location manager that sends the update
 @param soreDescription The updated locations
 @param testSortNum The updated addresses
 @param testName Used if there was an error during update
 */
