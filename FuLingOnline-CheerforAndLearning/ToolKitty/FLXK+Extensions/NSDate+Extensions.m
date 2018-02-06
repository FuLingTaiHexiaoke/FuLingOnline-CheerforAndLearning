//
//  NSDate+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/28.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)
+(NSString*)DateWithNormalFormat{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return  [dateFormatter stringFromDate:currentDate];
    
}

/**
 @abstract 根据时间间隔的秒数，转换成时间格式 例如：6000=1：20：30
 @param timeInterval 间间隔的秒数
 */
+(NSString*)DateStringWithTimeInterval:(NSTimeInterval)timeInterval{
    int days = timeInterval/(60*60*24);
    int hours = (int)(timeInterval / (60*60))% 24;
    int minutes = timeInterval / 60;
    int seconds = (int)timeInterval % 60;
    NSString *strTime = [NSString stringWithFormat:@"%d天%d:%d:%.2d",days,hours,minutes, seconds];
    return strTime;
    
    ////    int days = timeInterval/(60*60*24);
    //    int hours = (int)(timeInterval / (60*60))% 24;
    //    int minutes = timeInterval / 60;
    //    int seconds = (int)timeInterval % 60;
    //    NSString *strTime = [NSString stringWithFormat:@"%d:%d:%.2d",hours,minutes, seconds];
    //    return strTime;
}

@end
