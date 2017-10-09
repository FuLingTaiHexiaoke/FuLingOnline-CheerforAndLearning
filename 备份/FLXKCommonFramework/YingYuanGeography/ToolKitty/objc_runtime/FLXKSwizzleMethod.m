//
//  FLXKSwizzleMethod.m
//  PCDPYSXY
//
//  Created by 肖科 on 17/4/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FLXKSwizzleMethod.h"

#import <objc/runtime.h>

void FKXKSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL success =class_addMethod(cls,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    
    if (success) {
        class_replaceMethod(cls,swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


void FKXKSwizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    if (originalMethod&&swizzledMethod) {
          method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    else{
        class_replaceMethod(class,originalSelector, method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
        class_replaceMethod(class,swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
}

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        FKXKSwizzleClassMethod([self class],
//                        @selector(viewWillLayoutSubviews),
//                        @selector(km_viewWillLayoutSubviews));
//        
//        FKXKSwizzleClassMethod([self class],
//                        @selector(viewDidAppear:),
//                        @selector(km_viewDidAppear:));
//    });
//}
