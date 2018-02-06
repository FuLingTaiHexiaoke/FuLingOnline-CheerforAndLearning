//
//  FLXKSharedAppSingleton.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/13.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKSharedAppSingleton.h"
//utilites
#import "FLXKHttpRequestModelHelper.h"
//child viewController
//models
//subviews
@interface FLXKSharedAppSingleton ()
//IBOutlet
//IBAction
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXKSharedAppSingleton

#pragma mark -  LifeCircle

+(void)load{
//    [FLXKSharedAppSingleton  getSharedAPPUser];
}



//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}


#pragma mark - Delegate
#pragma mark - Public methods

+ (instancetype)sharedSingleton {
    static FLXKSharedAppSingleton *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager =[[FLXKSharedAppSingleton alloc]init];
    });
    
    return _sharedManager;
}

#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
//get user
//    [self getSharedAPPUser];
+(void)getSharedAPPUser{
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        [FLXKSharedAppSingleton sharedSingleton].sharedUser=(UserModel*)obj;
    } failureCallback:^(NSError *err) {
        //        NSLog(@"failure");
    }] getUserModel];
    
}

+(void)downloadTest{
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
       
    } failureCallback:^(NSError *err) {
        //        NSLog(@"failure");
    }] downloadTest];
    
}
#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
