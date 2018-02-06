//
//  CodeBack.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/19.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#ifndef CodeBack_h
#define CodeBack_h



NSProcessInfo *info = [NSProcessInfo processInfo];
NSLog(@"%@---\n%d----\n%d----\n%@----\n%@----\n%@---\n%@----\n%d------\n%@----\n%@",info.processName,
      info.processorCount,
      info.processIdentifier,
      info.arguments,
      info.hostName,
      info.environment,
      info.globallyUniqueString,info.operatingSystem,info.operatingSystemVersionString,info.operatingSystemName);
NSLog(@"globallyUniqueString:%@\nhostName:%@\noprerationSystemName:%@\noperatingSystemVersionString:%@\nphysicalMemory:%llu\nprocessName:%@\n systemUptime:%f\n processorCount:%d \n activeProcessorCount:%d",
      [info globallyUniqueString],
      [info hostName],
      [info operatingSystemName],
      [info operatingSystemVersionString],
      [info physicalMemory]/(1024*1024),
      [info processName],
      [info systemUptime],
      [info processorCount],
      [info activeProcessorCount]);
NSLog(@"uniqueIdentifier:%@\n name:%@\n systemName:%@\n systemVersion:%@\n model:%@\n localizedModel:%@\n butteryLevel:%.1f\n",
      [UIDevice currentDevice].identifierForVendor,
      [UIDevice currentDevice].name,
      [UIDevice currentDevice].systemName,
      [UIDevice currentDevice].systemVersion,
      [UIDevice currentDevice].model,
      [UIDevice currentDevice].localizedModel,
      [UIDevice currentDevice].batteryLevel*100
      );


#endif /* CodeBack_h */
