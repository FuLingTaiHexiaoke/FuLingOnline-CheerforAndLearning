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
@end
