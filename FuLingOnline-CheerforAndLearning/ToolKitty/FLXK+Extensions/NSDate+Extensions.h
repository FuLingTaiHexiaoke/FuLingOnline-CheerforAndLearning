//
//  NSDate+Extensions.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/28.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)
+(NSString*)DateWithNormalFormat;

/**
 @abstract 根据时间间隔的秒数，转换成时间格式 例如：6000=1：20：30
 @param timeInterval 间间隔的秒数
 */
+(NSString*)DateStringWithTimeInterval:(NSTimeInterval)timeInterval;
@end
