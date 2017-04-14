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
//models
@property(nonatomic,strong) UserModel* sharedUser;
//UI state record properties
//subviews
//child viewController
//public actions
@end

