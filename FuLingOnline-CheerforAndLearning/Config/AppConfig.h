//
//  config.h
//  Psy-TeachersTerminal
//
//  Created by apple on 2016/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "BaseConfig.h"


#ifndef config_h
#define config_h
//Http Request Part
//#define BaseURL @"http://127.0.0.1:3000"
#define BaseURL(relativeString) [NSString stringWithFormat:@"https://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]
//#define BaseURL(relativeString) [NSString stringWithFormat:@"http://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]

#define Url_GetAdvertisementImageInfo BaseURL(@"launch/getAdvertisementImage")

//https://127.0.0.1:3000/publishNewsController/PublishNewsModel
#define Url_UploadPublishNews BaseURL(@"publishNewsController/PublishNewsModel")

#endif
