//
//  config.h
//  Psy-TeachersTerminal
//
//  Created by apple on 2016/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "baseConfig.h"

#ifndef config_h
#define config_h
//Http Request Part
//#define BaseURL @"http://127.0.0.1:3000"
#define BaseURL(relativeString) [NSString stringWithFormat:@"%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]


#endif
