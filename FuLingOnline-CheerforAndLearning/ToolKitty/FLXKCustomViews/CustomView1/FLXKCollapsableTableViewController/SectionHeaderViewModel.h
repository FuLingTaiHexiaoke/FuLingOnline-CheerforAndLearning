//
//  SectionHeaderViewModel.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionHeaderViewModel : NSObject
@property(nonatomic,strong)NSString* mainTitle;
@property(nonatomic,strong)NSString* subTitle;
@property(nonatomic,assign)NSInteger sectionIndex;
@end
