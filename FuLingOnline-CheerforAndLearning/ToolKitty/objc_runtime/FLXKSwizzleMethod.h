//
//  FLXKSwizzleMethod.h
//  PCDPYSXY
//
//  Created by 肖科 on 17/4/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void FKXKSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

extern void FKXKSwizzleClassMethod(Class cls, SEL originalSelector, SEL swizzledSelector);
