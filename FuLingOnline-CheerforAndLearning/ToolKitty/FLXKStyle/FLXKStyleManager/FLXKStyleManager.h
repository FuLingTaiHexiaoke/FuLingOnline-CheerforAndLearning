//
//  FLXKFLXKStyleManager.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKStyleManager : NSObject

+ (void)setSharedStyleManager:(FLXKStyleManager*)styleManger;

- (void)applyStyleToWindow:(UIWindow*)window;

@end
