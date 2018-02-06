//
//  NSArray+Extension.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/14.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

//筛选
//pred=[NSPredicate predicateWithFormat:@"%K = %d",key,value];
//NSArray<PsyMeetingModel*>* finishedModel= [allMeetingData filteredArrayUsingPredicate:pred];
////            NSLog(@"%@",unFinishedModel);
//[self.myfinishedMeetingModels removeAllObjects];
//[self.myfinishedMeetingModels addObjectsFromArray:finishedModel];


//排序
//NSArray *arrnumber= [[NSArray alloc]initWithObjects:@"nihao",@"wo",@"helloword",@"zhonggu", nil];
//NSArray *te = [arrnumber sortedArrayUsingComparator: ^(NSString *s,NSString *s2){
//    if(s.length < s2.length){
//        return NSOrderedDescending;
//    }
//    if(s.length > s2.length){
//        return NSOrderedAscending;
//    }
//    // NSLog(@"...........................");
//    
//    return NSOrderedSame;
//}];

@end
