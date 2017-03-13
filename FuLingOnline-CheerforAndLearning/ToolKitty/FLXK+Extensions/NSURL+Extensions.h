//
//  NSURL+Extensions.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/11.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extensions)

/**
 * 解析URL参数的工具方法。
 */
- (NSDictionary *)parseURLParamsToDic;
@end
