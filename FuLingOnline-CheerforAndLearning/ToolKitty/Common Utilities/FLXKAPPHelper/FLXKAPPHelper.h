//
//  FLXKAPPHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/10.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKAPPHelper : NSObject

//得到当前显示的VC
- (UIViewController *)getCurrentVC;
//得到当前显示的NavigationViewControlle
- (UINavigationController*)currentNavigationViewController;
@end
