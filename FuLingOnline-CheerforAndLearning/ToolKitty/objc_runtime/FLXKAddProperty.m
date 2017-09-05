//
//  FLXKAddProperty.m
//  PCDPYSXY
//
//  Created by 肖科 on 17/4/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FLXKAddProperty.h"

#import <objc/runtime.h>

@implementation FLXKAddProperty

- (UINavigationBar *)km_transitionNavigationBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKm_transitionNavigationBar:(UINavigationBar *)navigationBar {
    objc_setAssociatedObject(self, @selector(km_transitionNavigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
