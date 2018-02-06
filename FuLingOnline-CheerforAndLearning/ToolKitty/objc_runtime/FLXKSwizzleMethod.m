//
//  FLXKSwizzleMethod.m
//  PCDPYSXY
//
//  Created by 肖科 on 17/4/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FLXKSwizzleMethod.h"

#import <objc/runtime.h>


//+ (void)load {
//    // All methods that trigger height cache's invalidation
//    SEL selectors[] = {
//        @selector(reloadData),
//        @selector(insertSections:withRowAnimation:),
//        @selector(deleteSections:withRowAnimation:),
//        @selector(reloadSections:withRowAnimation:),
//        @selector(moveSection:toSection:),
//        @selector(insertRowsAtIndexPaths:withRowAnimation:),
//        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
//        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
//        @selector(moveRowAtIndexPath:toIndexPath:)
//    };
//
//    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
//        SEL originalSelector = selectors[index];
//        SEL swizzledSelector = NSSelectorFromString([@"fd_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
//        Method originalMethod = class_getInstanceMethod(self, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        __swipeback_swizzle(self, @selector(viewDidAppear:));
//        //        [self swizzle:@selector(viewDidAppear:)];
//    });
//}
//
//+ (void)swizzle:(SEL)selector
//{
//    NSString *name = [NSString stringWithFormat:@"swizzled_%@", NSStringFromSelector(selector)];
//    Method m1 = class_getInstanceMethod(self, selector);
//    Method m2 = class_getInstanceMethod(self, NSSelectorFromString(name));
//    method_exchangeImplementations(m1, m2);
//}
//
//- (void)swizzled_viewDidAppear:(BOOL)animated
//{
//    [self swizzled_viewDidAppear:animated];
//
//    // fix swipe back function when 3D-touch is enabled.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    });
//}

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
