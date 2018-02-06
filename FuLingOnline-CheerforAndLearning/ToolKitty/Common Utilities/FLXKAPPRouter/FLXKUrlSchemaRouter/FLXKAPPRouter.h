//
//  FLXKAPPRouter.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/10.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//


/* inspired by XYWdispatcher*/

#import <Foundation/Foundation.h>

@interface FLXKAPPRouter : NSObject
+(BOOL)openURL:(NSURL *)url withScheme:(NSString *)scheme;
@end
