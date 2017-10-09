//
//  AudioServices+Extensions.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/16.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioServices : NSObject

//播放定制音效文件
+(void)playSoundWithName:(NSString *)name;
//播放系统音效文件
+(void)playSystemSoundID:(UInt32 )soundID;
@end
